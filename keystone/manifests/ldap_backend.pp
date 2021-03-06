# == define: keystone::ldap_backend
#
# Implements ldap configuration for keystone.
#
# === parameters:
# [*name*]
#   The ldap backend domain's name. (string value)
#   No default.
#
# [*url*]
#   URL for connecting to the LDAP server. (string value)
#   Defaults to 'undef'
#
# [*user*]
#   User BindDN to query the LDAP server. (string value)
#   Defaults to 'undef'
#
# [*password*]
#   Password for the BindDN to query the LDAP server. (string value)
#   Defaults to 'undef'
#
# [*suffix*]
#   LDAP server suffix (string value)
#   Defaults to 'undef'
#
# [*query_scope*]
#   The LDAP scope for queries, this can be either "one"
#   (onelevel/singleLevel) or "sub" (subtree/wholeSubtree). (string value)
#   Defaults to 'undef'
#
# [*page_size*]
#   Maximum results per page; a value of zero ("0") disables paging. (integer value)
#   Defaults to 'undef'
#
# [*user_tree_dn*]
#   Search base for users. (string value)
#   Defaults to 'undef'
#
# [*user_filter*]
#   LDAP search filter for users. (string value)
#   Defaults to 'undef'
#
# [*user_objectclass*]
#   LDAP objectclass for users. (string value)
#   Defaults to 'undef'
#
# [*user_id_attribute*]
#   LDAP attribute mapped to user id. WARNING: must not be a multivalued attribute. (string value)
#   Defaults to 'undef'
#
# [*user_name_attribute*]
#   LDAP attribute mapped to user name. (string value)
#   Defaults to 'undef'
#
# [*user_mail_attribute*]
#   LDAP attribute mapped to user email. (string value)
#
# [*user_enabled_attribute*]
#   LDAP attribute mapped to user enabled flag. (string value)
#   Defaults to 'undef'
#
# [*user_enabled_mask*]
#   Bitmask integer to indicate the bit that the enabled value is stored in if
#   the LDAP server represents "enabled" as a bit on an integer rather than a
#   boolean. A value of "0" indicates the mask is not used. If this is not set
#   to "0" the typical value is "2". This is typically used when
#   "user_enabled_attribute = userAccountControl". (integer value)
#   Defaults to 'undef'
#
# [*user_enabled_default*]
#   Default value to enable users. This should match an appropriate int value
#   if the LDAP server uses non-boolean (bitmask) values to indicate if a user
#   is enabled or disabled. If this is not set to "True" the typical value is
#   "512". This is typically used when "user_enabled_attribute =
#   userAccountControl". (string value)
#   Defaults to 'undef'
#
# [*user_enabled_invert*]
#   Invert the meaning of the boolean enabled values. Some LDAP servers use a
#   boolean lock attribute where "true" means an account is disabled. Setting
#   "user_enabled_invert = true" will allow these lock attributes to be used.
#   This setting will have no effect if "user_enabled_mask" or
#   "user_enabled_emulation" settings are in use. (boolean value)
#   Defaults to 'undef'
#
# [*user_attribute_ignore*]
#   List of attributes stripped off the user on update. (list value)
#   Defaults to 'undef'
#
# [*user_default_project_id_attribute*]
#   LDAP attribute mapped to default_project_id for users. (string value)
#   Defaults to 'undef'
#
# [*user_allow_create*]
#   Allow user creation in LDAP backend. (boolean value)
#   Defaults to 'undef'
#
# [*user_allow_update*]
#   Allow user updates in LDAP backend. (boolean value)
#   Defaults to 'undef'
#
# [*user_allow_delete*]
#   Allow user deletion in LDAP backend. (boolean value)
#   Defaults to 'undef'
#
# [*user_pass_attribute*]
#   LDAP attribute mapped to password. (string value)
#   Defaults to 'undef'
#
# [*user_enabled_emulation*]
#   If true, Keystone uses an alternative method to determine if
#   a user is enabled or not by checking if they are a member of
#   the "user_enabled_emulation_dn" group. (boolean value)
#   Defaults to 'undef'
#
# [*user_enabled_emulation_dn*]
#   DN of the group entry to hold enabled users when using enabled emulation.
#   (string value)
#   Defaults to 'undef'
#
# [*user_additional_attribute_mapping*]
#   List of additional LDAP attributes used for mapping
#   additional attribute mappings for users. Attribute mapping
#   format is <ldap_attr>:<user_attr>, where ldap_attr is the
#   attribute in the LDAP entry and user_attr is the Identity
#   API attribute. (list value)
#   Defaults to 'undef'
#
# [*project_tree_dn*]
#   Search base for projects (string value)
#   Defaults to 'undef'
#
# [*project_filter*]
#   LDAP search filter for projects. (string value)
#   Defaults to 'undef'
#
# [*project_objectclass*]
#   LDAP objectclass for projects. (string value)
#   Defaults to 'undef'
#
# [*project_id_attribute*]
#   LDAP attribute mapped to project id. (string value)
#   Defaults to 'undef'
#
# [*project_member_attribute*]
#   LDAP attribute mapped to project membership for user. (string value)
#   Defaults to 'undef'
#
# [*project_name_attribute*]
#   LDAP attribute mapped to project name. (string value)
#   Defaults to 'undef'
#
# [*project_desc_attribute*]
#   LDAP attribute mapped to project description. (string value)
#   Defaults to 'undef'
#
# [*project_enabled_attribute*]
#   LDAP attribute mapped to project enabled. (string value)
#   Defaults to 'undef'
#
# [*project_domain_id_attribute*]
#   LDAP attribute mapped to project domain_id. (string value)
#   Defaults to 'undef'
#
# [*project_attribute_ignore*]
#   List of attributes stripped off the project on update. (list value)
#   Defaults to 'undef'
#
# [*project_allow_create*]
#   Allow project creation in LDAP backend. (boolean value)
#   Defaults to 'undef'
#
# [*project_allow_update*]
#   Allow project update in LDAP backend. (boolean value)
#   Defaults to 'undef'
#
# [*project_allow_delete*]
#   Allow project deletion in LDAP backend. (boolean value)
#   Defaults to 'undef'
#
# [*project_enabled_emulation*]
#   If true, Keystone uses an alternative method to determine if
#   a project is enabled or not by checking if they are a member
#   of the "project_enabled_emulation_dn" group. (boolean value)
#   Defaults to 'undef'
#
# [*project_enabled_emulation_dn*]
#   DN of the group entry to hold enabled projects when using
#   enabled emulation. (string value)
#   Defaults to 'undef'
#
# [*project_additional_attribute_mapping*]
#   Additional attribute mappings for projects. Attribute
#   mapping format is <ldap_attr>:<user_attr>, where ldap_attr
#   is the attribute in the LDAP entry and user_attr is the
#   Identity API attribute. (list value)
#   Defaults to 'undef'
#
# [*role_tree_dn*]
#   Search base for roles. (string value)
#   Defaults to 'undef'
#
# [*role_filter*]
#   LDAP search filter for roles. (string value)
#   Defaults to 'undef'
#
# [*role_objectclass*]
#   LDAP objectclass for roles. (string value)
#   Defaults to 'undef'
#
# [*role_id_attribute*]
#   LDAP attribute mapped to role id. (string value)
#   Defaults to 'undef'
#
# [*role_name_attribute*]
#   LDAP attribute mapped to role name. (string value)
#   Defaults to 'undef'
#
# [*role_member_attribute*]
#   LDAP attribute mapped to role membership. (string value)
#   Defaults to 'undef'
#
# [*role_attribute_ignore*]
#   List of attributes stripped off the role on update. (list value)
#   Defaults to 'undef'
#
# [*role_allow_create*]
#   Allow role creation in LDAP backend. (boolean value)
#   Defaults to 'undef'
#
# [*role_allow_update*]
#   Allow role update in LDAP backend. (boolean value)
#   Defaults to 'undef'
#
# [*role_allow_delete*]
#   Allow role deletion in LDAP backend. (boolean value)
#   Defaults to 'undef'
#
# [*role_additional_attribute_mapping*]
#   Additional attribute mappings for roles. Attribute mapping
#   format is <ldap_attr>:<user_attr>, where ldap_attr is the
#   attribute in the LDAP entry and user_attr is the Identity
#   API attribute. (list value)
#   Defaults to 'undef'
#
# [*group_tree_dn*]
#   Search base for groups. (string value)
#   Defaults to 'undef'
#
# [*group_filter*]
#   LDAP search filter for groups. (string value)
#   Defaults to 'undef'
#
# [*group_objectclass*]
#   LDAP objectclass for groups. (string value)
#   Defaults to 'undef'
#
# [*group_id_attribute*]
#   LDAP attribute mapped to group id. (string value)
#   Defaults to 'undef'
#
# [*group_name_attribute*]
#   LDAP attribute mapped to group name. (string value)
#   Defaults to 'undef'
#
# [*group_member_attribute*]
#   LDAP attribute mapped to show group membership. (string value)
#   Defaults to 'undef'
#
# [*group_desc_attribute*]
#   LDAP attribute mapped to group description. (string value)
#   Defaults to 'undef'
#
# [*group_attribute_ignore*]
#   List of attributes stripped off the group on update. (list value)
#   Defaults to 'undef'
#
# [*group_allow_create*]
#   Allow group creation in LDAP backend. (boolean value)
#   Defaults to 'undef'
#
# [*group_allow_update*]
#   Allow group update in LDAP backend. (boolean value)
#   Defaults to 'undef'
#
# [*group_allow_delete*]
#   Allow group deletion in LDAP backend. (boolean value)
#   Defaults to 'undef'
#
# [*group_additional_attribute_mapping*]
#   Additional attribute mappings for groups. Attribute mapping
#   format is <ldap_attr>:<user_attr>, where ldap_attr is the
#   attribute in the LDAP entry and user_attr is the Identity
#   API attribute. (list value)
#   Defaults to 'undef'
#
# [*use_tls*]
#   Enable TLS for communicating with LDAP servers. (boolean value)
#   Defaults to 'undef'
#
# [*tls_cacertfile*]
#   CA certificate file path for communicating with LDAP servers. (string value)
#   Defaults to 'undef'
#
# [*tls_cacertdir*]
#   CA certificate directory path for communicating with LDAP servers. (string value)
#   Defaults to 'undef'
#
# [*tls_req_cert*]
#   Valid options for tls_req_cert are demand, never, and allow. (string value)
#   Defaults to 'undef'
#
# [*identity_driver*]
#   Identity backend driver. (string value)
#   Defaults to 'undef'
#
# [*credential_driver*]
#   Credential backend driver. (string value)
#   Defaults to 'undef'
#
# [*assignment_driver*]
#   Assignment backend driver. (string value)
#   Defaults to 'undef'
#
# [*use_pool*]
#   Enable LDAP connection pooling. (boolean value)
#   Defaults to false
#
# [*pool_size*]
#   Connection pool size. (integer value)
#   Defaults to '10'
#
# [*pool_retry_max*]
#   Maximum count of reconnect trials. (integer value)
#   Defaults to '3'
#
# [*pool_retry_delay*]
#   Time span in seconds to wait between two reconnect trials. (floating point value)
#   Defaults to '0.1'
#
# [*pool_connection_timeout*]
#   Connector timeout in seconds. Value -1 indicates indefinite wait for response. (integer value)
#   Defaults to '-1'
#
# [*pool_connection_lifetime*]
#   Connection lifetime in seconds. (integer value)
#   Defaults to '600'
#
# [*use_auth_pool*]
#   Enable LDAP connection pooling for end user authentication.
#   If use_pool is disabled, then this setting is meaningless and is not used at all. (boolean value)
#   Defaults to false
#
# [*auth_pool_size*]
#   End user auth connection pool size. (integer value)
#   Defaults to '100'
#
# [*auth_pool_connection_lifetime*]
#   End user auth connection lifetime in seconds. (integer value)
#   Defaults to '60'
#
# === DEPRECATED group/name
#
# [*tenant_tree_dn*]
# [*tenant_filter*]
# [*tenant_objectclass*]
# [*tenant_id_attribute*]
# [*tenant_member_attribute*]
# [*tenant_name_attribute*]
# [*tenant_desc_attribute*]
# [*tenant_enabled_attribute*]
# [*tenant_domain_id_attribute*]
# [*tenant_attribute_ignore*]
# [*tenant_allow_create*]
# [*tenant_allow_update*]
# [*tenant_enabled_emulation*]
# [*tenant_enabled_emulation_dn*]
# [*tenant_additional_attribute_mapping*]
# [*tenant_allow_delete*]
#
# == Dependencies
# == Examples
define keystone::ldap_backend(
  $url                                 = undef,
  $user                                = undef,
  $password                            = undef,
  $suffix                              = undef,
  $query_scope                         = undef,
  $page_size                           = undef,
  $user_tree_dn                        = undef,
  $user_filter                         = undef,
  $user_objectclass                    = undef,
  $user_id_attribute                   = undef,
  $user_name_attribute                 = undef,
  $user_mail_attribute                 = undef,
  $user_enabled_attribute              = undef,
  $user_enabled_mask                   = undef,
  $user_enabled_default                = undef,
  $user_enabled_invert                 = undef,
  $user_attribute_ignore               = undef,
  $user_default_project_id_attribute   = undef,
  $user_allow_create                   = undef,
  $user_allow_update                   = undef,
  $user_allow_delete                   = undef,
  $user_pass_attribute                 = undef,
  $user_enabled_emulation              = undef,
  $user_enabled_emulation_dn           = undef,
  $user_additional_attribute_mapping   = undef,
  $tenant_tree_dn                      = undef,   #DEPRECATED
  $project_tree_dn                     = undef,
  $tenant_filter                       = undef,   #DEPRECATED
  $project_filter                      = undef,
  $tenant_objectclass                  = undef,   #DEPRECATED
  $project_objectclass                 = undef,
  $tenant_id_attribute                 = undef,   #DEPRECATED
  $project_id_attribute                = undef,
  $tenant_member_attribute             = undef,   #DEPRECATED
  $project_member_attribute            = undef,
  $tenant_desc_attribute               = undef,   #DEPRECATED
  $project_desc_attribute              = undef,
  $tenant_name_attribute               = undef,   #DEPRECATED
  $project_name_attribute              = undef,
  $tenant_enabled_attribute            = undef,   #DEPRECATED
  $project_enabled_attribute           = undef,
  $tenant_domain_id_attribute          = undef,   #DEPRECATED
  $project_domain_id_attribute         = undef,
  $tenant_attribute_ignore             = undef,   #DEPRECATED
  $project_attribute_ignore            = undef,
  $tenant_allow_create                 = undef,   #DEPRECATED
  $project_allow_create                = undef,
  $tenant_allow_update                 = undef,   #DEPRECATED
  $project_allow_update                = undef,
  $tenant_allow_delete                 = undef,   #DEPRECATED
  $project_allow_delete                = undef,
  $tenant_enabled_emulation            = undef,   #DEPRECATED
  $project_enabled_emulation           = undef,
  $tenant_enabled_emulation_dn         = undef,   #DEPRECATED
  $project_enabled_emulation_dn        = undef,
  $tenant_additional_attribute_mapping = undef,   #DEPRECATED
  $project_additional_attribute_mapping= undef,
  $role_tree_dn                        = undef,
  $role_filter                         = undef,
  $role_objectclass                    = undef,
  $role_id_attribute                   = undef,
  $role_name_attribute                 = undef,
  $role_member_attribute               = undef,
  $role_attribute_ignore               = undef,
  $role_allow_create                   = undef,
  $role_allow_update                   = undef,
  $role_allow_delete                   = undef,
  $role_additional_attribute_mapping   = undef,
  $group_tree_dn                       = undef,
  $group_filter                        = undef,
  $group_objectclass                   = undef,
  $group_id_attribute                  = undef,
  $group_name_attribute                = undef,
  $group_member_attribute              = undef,
  $group_desc_attribute                = undef,
  $group_attribute_ignore              = undef,
  $group_allow_create                  = undef,
  $group_allow_update                  = undef,
  $group_allow_delete                  = undef,
  $group_additional_attribute_mapping  = undef,
  $use_tls                             = undef,
  $tls_cacertdir                       = undef,
  $tls_cacertfile                      = undef,
  $tls_req_cert                        = undef,
  $identity_driver                     = undef,
  $assignment_driver                   = undef,
  $credential_driver                   = undef,
  $use_pool                            = false,
  $pool_size                           = 10,
  $pool_retry_max                      = 3,
  $pool_retry_delay                    = 0.1,
  $pool_connection_timeout             = -1,
  $pool_connection_lifetime            = 600,
  $use_auth_pool                       = false,
  $auth_pool_size                      = 100,
  $auth_pool_connection_lifetime       = 60,
) {

  $domain_enabled = getparam(Keystone_config['identity/domain_specific_drivers_enabled'], 'value')
  $domain_dir_enabled = getparam(Keystone_config['identity/domain_config_dir'], 'value')
  $err_msg = "You should add \"using_domain_config => true\" parameter to your Keystone class, got \"${domain_enabled}\" for identity/domain_specific_drivers_enabled and \"${domain_dir_enabled}\" for identity/domain_config_dir"

  if(bool2num($domain_enabled) == 0) {
    fail($err_msg)
  }
  validate_re($domain_dir_enabled, '^/.+', $err_msg)

  if (!defined(File[$domain_dir_enabled])) {
    ensure_resource('file', $domain_dir_enabled, {
      ensure  => directory,
      owner   => 'keystone',
      group   => 'keystone',
      mode    => '0750',
      require => File['/etc/keystone/keystone.conf']
    })
  }

  $domain = $name

  # In Juno the term "tenant" was deprecated in the config in favor of "project"
  # Let's assume project_ is being used and warning otherwise. If both are set we will
  # fail, because having both set may cause unexpected results in Keystone.
  if ($tenant_tree_dn) {
    $project_tree_dn_real = $tenant_tree_dn
    warning ('tenant_tree_dn is deprecated in Juno. switch to project_tree_dn')
    if ($project_tree_dn) {
      fail ('tenant_tree_dn and project_tree_dn are both set. results may be unexpected')
    }
  }
  else {
    $project_tree_dn_real = $project_tree_dn
  }

  if ($tenant_filter) {
    $project_filter_real = $tenant_filter
    warning ('tenant_filter is deprecated in Juno. switch to project_filter')
    if ($project_filter) {
      fail ('tenant_filter and project_filter are both set. results may be unexpected')
    }
  }
  else {
    $project_filter_real = $project_filter
  }

  if ($tenant_objectclass) {
    $project_objectclass_real = $tenant_objectclass
    warning ('tenant_objectclass is deprecated in Juno. switch to project_objectclass')
    if ($project_objectclass) {
      fail ('tenant_objectclass and project_objectclass are both set. results may be unexpected')
    }
  }
  else {
    $project_objectclass_real = $project_objectclass
  }

  if ($tenant_id_attribute) {
    $project_id_attribute_real = $tenant_id_attribute
    warning ('tenant_id_attribute is deprecated in Juno. switch to project_id_attribute')
    if ($project_id_attribute) {
      fail ('tenant_id_attribute and project_id_attribute are both set. results may be unexpected')
    }
  }
  else {
    $project_id_attribute_real = $project_id_attribute
  }

  if ($tenant_member_attribute) {
    $project_member_attribute_real = $tenant_member_attribute
    warning ('tenant_member_attribute is deprecated in Juno. switch to project_member_attribute')
    if ($project_member_attribute) {
      fail ('tenant_member_attribute and project_member_attribute are both set. results may be unexpected')
    }
  }
  else {
    $project_member_attribute_real = $project_member_attribute
  }

  if ($tenant_desc_attribute) {
    $project_desc_attribute_real = $tenant_desc_attribute
    warning ('tenant_desc_attribute is deprecated in Juno. switch to project_desc_attribute')
    if ($project_desc_attribute) {
      fail ('tenant_desc_attribute and project_desc_attribute are both set. results may be unexpected')
    }
  }
  else {
    $project_desc_attribute_real = $project_desc_attribute
  }

  if ($tenant_name_attribute) {
    $project_name_attribute_real = $tenant_name_attribute
    warning ('tenant_name_attribute is deprecated in Juno. switch to project_name_attribute')
    if ($project_name_attribute) {
      fail ('tenant_name_attribute and project_name_attribute are both set. results may be unexpected')
    }
  }
  else {
    $project_name_attribute_real = $project_name_attribute
  }

  if ($tenant_enabled_attribute) {
    $project_enabled_attribute_real = $tenant_enabled_attribute
    warning ('tenant_enabled_attribute is deprecated in Juno. switch to project_enabled_attribute')
    if ($project_enabled_attribute) {
      fail ('tenant_enabled_attribute and project_enabled_attribute are both set. results may be unexpected')
    }
  }
  else {
    $project_enabled_attribute_real = $project_enabled_attribute
  }

  if ($tenant_attribute_ignore) {
    $project_attribute_ignore_real = $tenant_attribute_ignore
    warning ('tenant_attribute_ignore is deprecated in Juno. switch to project_attribute_ignore')
    if ($project_attribute_ignore) {
      fail ('tenant_attribute_ignore and project_attribute_ignore are both set. results may be unexpected')
    }
  }
  else {
    $project_attribute_ignore_real = $project_attribute_ignore
  }

  if ($tenant_domain_id_attribute) {
    $project_domain_id_attribute_real = $tenant_domain_id_attribute
    warning ('tenant_domain_id_attribute is deprecated in Juno. switch to project_domain_id_attribute')
    if ($project_domain_id_attribute) {
      fail ('tenant_domain_id_attribute and project_domain_id_attribute are both set. results may be unexpected')
    }
  }
  else {
    $project_domain_id_attribute_real = $project_domain_id_attribute
  }

  if ($tenant_allow_create) {
    $project_allow_create_real = $tenant_allow_create
    warning ('tenant_allow_create is deprecated in Juno. switch to project_allow_create')
    if ($project_allow_create) {
      fail ('tenant_allow_create and project_allow_create are both set. results may be unexpected')
    }
  }
  else {
    $project_allow_create_real = $project_allow_create
  }

  if ($tenant_allow_update) {
    $project_allow_update_real = $tenant_allow_update
    warning ('tenant_allow_update is deprecated in Juno. switch to project_allow_update')
    if ($project_allow_update) {
      fail ('tenant_allow_update and project_allow_update are both set. results may be unexpected')
    }
  }
  else {
    $project_allow_update_real = $project_allow_update
  }

  if ($tenant_allow_delete) {
    $project_allow_delete_real = $tenant_allow_delete
    warning ('tenant_allow_delete is deprecated in Juno. switch to project_allow_delete')
    if ($project_allow_delete) {
      fail ('tenant_allow_delete and project_allow_delete are both set. results may be unexpected')
    }
  }
  else {
    $project_allow_delete_real = $project_allow_delete
  }

  if ($tenant_enabled_emulation) {
    $project_enabled_emulation_real = $tenant_enabled_emulation
    warning ('tenant_enabled_emulation is deprecated in Juno. switch to project_enabled_emulation')
    if ($project_enabled_emulation) {
      fail ('tenant_enabled_emulation and project_enabled_emulation are both set. results may be unexpected')
    }
  }
  else {
    $project_enabled_emulation_real = $project_enabled_emulation
  }

  if ($tenant_enabled_emulation_dn) {
    $project_enabled_emulation_dn_real = $tenant_enabled_emulation_dn
    warning ('tenant_enabled_emulation_dn is deprecated in Juno. switch to project_enabled_emulation_dn')
    if ($project_enabled_emulation_dn) {
      fail ('tenant_enabled_emulation_dn and project_enabled_emulation_dn are both set. results may be unexpected')
    }
  }
  else {
    $project_enabled_emulation_dn_real = $project_enabled_emulation_dn
  }

  if ($tenant_additional_attribute_mapping) {
    $project_additional_attribute_mapping_real = $tenant_additional_attribute_mapping
    warning ('tenant_additional_attribute_mapping is deprecated in Juno. switch to project_additional_attribute_mapping')
    if ($project_additional_attribute_mapping) {
      fail ('tenant_additional_attribute_mapping and project_additional_attribute_mapping are both set. results may be unexpected')
    }
  }
  else {
    $project_additional_attribute_mapping_real = $project_additional_attribute_mapping
  }

  $ldap_packages = ['python-ldap', 'python-ldappool']
  ensure_resource('package', $ldap_packages, { ensure => present })

  # check for some common driver name mistakes
  if ($assignment_driver != undef) {
      if ! ($assignment_driver =~ /^keystone.assignment.backends.*Assignment$/) {
          fail('assigment driver should be of the form \'keystone.assignment.backends.*Assignment\'')
      }
  }

  if ($identity_driver != undef) {
      if ! ($identity_driver =~ /^keystone.identity.backends.*Identity$/) {
          fail('identity driver should be of the form \'keystone.identity.backends.*Identity\'')
      }
  }

  if ($credential_driver != undef) {
      if ! ($credential_driver =~ /^keystone.credential.backends.*Credential$/) {
          fail('credential driver should be of the form \'keystone.credential.backends.*Credential\'')
      }
  }

  if ($tls_cacertdir != undef) {
    ensure_resource('file', $tls_cacertdir, { ensure => directory })
  }

  keystone_domain_config {
    "${domain}::ldap/url":                                  value => $url;
    "${domain}::ldap/user":                                 value => $user;
    "${domain}::ldap/password":                             value => $password, secret => true;
    "${domain}::ldap/suffix":                               value => $suffix;
    "${domain}::ldap/query_scope":                          value => $query_scope;
    "${domain}::ldap/page_size":                            value => $page_size;
    "${domain}::ldap/user_tree_dn":                         value => $user_tree_dn;
    "${domain}::ldap/user_filter":                          value => $user_filter;
    "${domain}::ldap/user_objectclass":                     value => $user_objectclass;
    "${domain}::ldap/user_id_attribute":                    value => $user_id_attribute;
    "${domain}::ldap/user_name_attribute":                  value => $user_name_attribute;
    "${domain}::ldap/user_mail_attribute":                  value => $user_mail_attribute;
    "${domain}::ldap/user_enabled_attribute":               value => $user_enabled_attribute;
    "${domain}::ldap/user_enabled_mask":                    value => $user_enabled_mask;
    "${domain}::ldap/user_enabled_default":                 value => $user_enabled_default;
    "${domain}::ldap/user_enabled_invert":                  value => $user_enabled_invert;
    "${domain}::ldap/user_attribute_ignore":                value => $user_attribute_ignore;
    "${domain}::ldap/user_default_project_id_attribute":    value => $user_default_project_id_attribute;
    "${domain}::ldap/user_allow_create":                    value => $user_allow_create;
    "${domain}::ldap/user_allow_update":                    value => $user_allow_update;
    "${domain}::ldap/user_allow_delete":                    value => $user_allow_delete;
    "${domain}::ldap/user_pass_attribute":                  value => $user_pass_attribute;
    "${domain}::ldap/user_enabled_emulation":               value => $user_enabled_emulation;
    "${domain}::ldap/user_enabled_emulation_dn":            value => $user_enabled_emulation_dn;
    "${domain}::ldap/user_additional_attribute_mapping":    value => $user_additional_attribute_mapping;
    "${domain}::ldap/project_tree_dn":                      value => $project_tree_dn_real;
    "${domain}::ldap/project_filter":                       value => $project_filter_real;
    "${domain}::ldap/project_objectclass":                  value => $project_objectclass_real;
    "${domain}::ldap/project_id_attribute":                 value => $project_id_attribute_real;
    "${domain}::ldap/project_member_attribute":             value => $project_member_attribute_real;
    "${domain}::ldap/project_desc_attribute":               value => $project_desc_attribute_real;
    "${domain}::ldap/project_name_attribute":               value => $project_name_attribute_real;
    "${domain}::ldap/project_enabled_attribute":            value => $project_enabled_attribute_real;
    "${domain}::ldap/project_attribute_ignore":             value => $project_attribute_ignore_real;
    "${domain}::ldap/project_domain_id_attribute":          value => $project_domain_id_attribute_real;
    "${domain}::ldap/project_allow_create":                 value => $project_allow_create_real;
    "${domain}::ldap/project_allow_update":                 value => $project_allow_update_real;
    "${domain}::ldap/project_allow_delete":                 value => $project_allow_delete_real;
    "${domain}::ldap/project_enabled_emulation":            value => $project_enabled_emulation_real;
    "${domain}::ldap/project_enabled_emulation_dn":         value => $project_enabled_emulation_dn_real;
    "${domain}::ldap/project_additional_attribute_mapping": value => $project_additional_attribute_mapping_real;
    "${domain}::ldap/role_tree_dn":                         value => $role_tree_dn;
    "${domain}::ldap/role_filter":                          value => $role_filter;
    "${domain}::ldap/role_objectclass":                     value => $role_objectclass;
    "${domain}::ldap/role_id_attribute":                    value => $role_id_attribute;
    "${domain}::ldap/role_name_attribute":                  value => $role_name_attribute;
    "${domain}::ldap/role_member_attribute":                value => $role_member_attribute;
    "${domain}::ldap/role_attribute_ignore":                value => $role_attribute_ignore;
    "${domain}::ldap/role_allow_create":                    value => $role_allow_create;
    "${domain}::ldap/role_allow_update":                    value => $role_allow_update;
    "${domain}::ldap/role_allow_delete":                    value => $role_allow_delete;
    "${domain}::ldap/role_additional_attribute_mapping":    value => $role_additional_attribute_mapping;
    "${domain}::ldap/group_tree_dn":                        value => $group_tree_dn;
    "${domain}::ldap/group_filter":                         value => $group_filter;
    "${domain}::ldap/group_objectclass":                    value => $group_objectclass;
    "${domain}::ldap/group_id_attribute":                   value => $group_id_attribute;
    "${domain}::ldap/group_name_attribute":                 value => $group_name_attribute;
    "${domain}::ldap/group_member_attribute":               value => $group_member_attribute;
    "${domain}::ldap/group_desc_attribute":                 value => $group_desc_attribute;
    "${domain}::ldap/group_attribute_ignore":               value => $group_attribute_ignore;
    "${domain}::ldap/group_allow_create":                   value => $group_allow_create;
    "${domain}::ldap/group_allow_update":                   value => $group_allow_update;
    "${domain}::ldap/group_allow_delete":                   value => $group_allow_delete;
    "${domain}::ldap/group_additional_attribute_mapping":   value => $group_additional_attribute_mapping;
    "${domain}::ldap/use_tls":                              value => $use_tls;
    "${domain}::ldap/tls_cacertdir":                        value => $tls_cacertdir;
    "${domain}::ldap/tls_cacertfile":                       value => $tls_cacertfile;
    "${domain}::ldap/tls_req_cert":                         value => $tls_req_cert;
    "${domain}::ldap/use_pool":                             value => $use_pool;
    "${domain}::ldap/pool_size":                            value => $pool_size;
    "${domain}::ldap/pool_retry_max":                       value => $pool_retry_max;
    "${domain}::ldap/pool_retry_delay":                     value => $pool_retry_delay;
    "${domain}::ldap/pool_connection_timeout":              value => $pool_connection_timeout;
    "${domain}::ldap/pool_connection_lifetime":             value => $pool_connection_lifetime;
    "${domain}::ldap/use_auth_pool":                        value => $use_auth_pool;
    "${domain}::ldap/auth_pool_size":                       value => $auth_pool_size;
    "${domain}::ldap/auth_pool_connection_lifetime":        value => $auth_pool_connection_lifetime;
  }

  ensure_resource('keystone_config', 'identity/driver',   {value => $identity_driver})
  ensure_resource('keystone_config', 'credential/driver', {value => $credential_driver})
  ensure_resource('keystone_config', 'assignment/driver', {value => $assignment_driver})
}
