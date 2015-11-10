if defined?(ChefSpec)

  def create_basic_vsftpd_user_conf(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:basic_vsftpd_user_conf, :create, resource_name)
  end

end
