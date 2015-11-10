# basic_vsftpd_user_conf resource
property :user, String, name_property: true
property :content, String

def user_conf_dir()
  run_context.node['basic_vsftpd']['config']['user_config_dir'] ||
    Chef::Application.fatal!("node['basic_vsftpd']['config']['user_config_dir'] is not set.")
end

action :create do
  file ::File.join(user_conf_dir, user) do
    content new_resource.content
    owner 'root'
    group 'root'
    mode '0400'
    action :create
  end
end

action :delete do
  file ::File.join(user_conf_dir, user) do
    action :delete
  end
end
