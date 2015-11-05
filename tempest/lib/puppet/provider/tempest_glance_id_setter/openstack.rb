require File.join(File.dirname(__FILE__), '..','..','..', 'puppet/provider/tempest')

Puppet::Type.type(:tempest_glance_id_setter).provide(
  :openstack,
  :parent => Puppet::Provider::Tempest
) do

  @credentials = Puppet::Provider::Openstack::CredentialsV2_0.new

  def exists?
    lines.find do |line|
      should_line.chomp == line.chomp
    end
  end

  def file_path
    resource[:tempest_conf_path]
  end

  def create
    handle_create_with_match
  end

  def destroy
    handle_create_with_match
  end

  def get_image_id
    if resource[:ensure] == :present or resource[:ensure].nil?
      if @image_id.nil?
        images = self.class.request('image', 'list', file_path)
        img = images.detect {|img| img[:name] == resource[:image_name]}
        if img.nil?
          raise(Puppet::Error, "Image #{resource[:image_name]} not found!")
        end
        @image_id = img[:id]
      end
    elsif resource[:ensure] != :absent
      raise(Puppet::Error, "Cannot ensure to #{resource[:ensure]}")
    end
    @image_id
  end

  def should_line
    "#{resource[:name]} = #{get_image_id}"
  end

  def match
    /^\s*#{resource[:name]}\s*=\s*/
  end

  def handle_create_with_match()
    regex = match
    match_count = lines.select { |l| regex.match(l) }.count

    file = lines
    case match_count
    when 1
      File.open(file_path, 'w') do |fh|
        lines.each do |l|
          fh.puts(regex.match(l) ? "#{should_line}" : l)
        end
      end
    when 0
      block_pos = lines.find_index { |l| /^\[compute\]/ =~ l }
      if block_pos.nil?
        file += ["[compute]\n", "#{should_line}\n"]
      else
        file.insert(block_pos+1, "#{should_line}\n")
      end
      File.write(file_path, file.join)
    else                        # cannot be negative.
      raise Puppet::Error, "More than one line in file \
'#{file_path}' matches pattern '#{regex}'"
    end
  end

  private
  def lines
    # If this type is ever used with very large files, we should
    #  write this in a different way, using a temp
    #  file; for now assuming that this type is only used on
    #  small-ish config files that can fit into memory without
    #  too much trouble.
    @lines ||= File.readlines(file_path)
  end

end
