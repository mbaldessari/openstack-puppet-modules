module Puppet::Parser::Functions

  newfunction(:compute_stonith, :arity =>2, :type => :rvalue,
              :doc => ("Given a compute_map hash and an array of fence device configs," +
                       "return the xvm and ipmilan devices needed to fence compute nodes only" +
                       ".")) do |args|
    compute_maps = args[0]
    devices = args[1]
    unless compute_maps.is_a?(Hash) && compute_maps.length > 0
      raise Puppet::ParseError, "compute_stonith: Argument 'compute_maps' must be a hash. The value given was: #{compute_maps}"
    end
    unless devices.is_a?(Array)
      raise Puppet::ParseError, "compute_stonith: Argument 'devices' must be an array. The value given was: #{devices}"
    end

    nodes = {}
    compute_maps.each do |key, t|
      s = t.gsub('\n', '').strip
      members = s.split(' ')
      members[1..-1].each do |mac|
        nodes[mac] = members[0]
      end
    end

    ret_xvm = {}
    ret_ipmilan = {}
    all_devices = devices.select do |device|
      host_mac = device['host_mac']
      if nodes.has_key?(host_mac)
        if device['agent'] == 'fence_xvm'
          ret_xvm[host_mac] = device['params']
        elsif device['agent'] == 'fence_ipmilan'
          ret_ipmilan[host_mac] = device['params']
        end
      end
    end
    return [ret_xvm, ret_ipmilan]
  end
end
