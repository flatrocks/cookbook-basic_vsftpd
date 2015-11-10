basic_vsftpd Cookbook
=====================

A basic and fully configurable cookbook for the vsftpd package.

All configuration options can be set using this cookbook,
and few are set be default.
If you do not set an option, the default vsftpd setting will be used.
(I.e. this cookbook overwrites any vsftpd.conf file created during the package install.)

This cookbook makes no assumptions about how you want to use vsftpd.
Help with any particular configuration will be left to the docs/wiki.

## Recipes

### default
This recipe:
* installs the vsftpd package
* creates the vsftpd.conf configuration file
from ```node['basic_vsftpd']['config']``` attributes
* creates an empty user config directory (if ```node['basic_vsftpd']['config']['user_config_dir']``` is set)
* and starts the service.

### chroot_list
This recipe is intended to be included after the default recipe.
It creates a chroot_list file for vsftpd from node attributes.
You may omit this recipe and create the chroot_list file manually.

### userlist
This recipe is intended to be included after the default recipe.
It creates a userlist file for vsftpd from node attributes.
You may omit this recipe and create the userlist file manually.

## Resources

### user_conf
This resource creates a user configuration file in the vsftpd user_config_dir directory.
Note that the resource requires the ```node['basic_vsftpd']['config']['user_config_dir']```
to be set and for the directory to exist.

Properties:
* __user__, string, name property, the name of the user
* __content__, string, the content of the user config file

Actions:
* :create, :delete

Attributes
----------

### vsftpd config attributes
Only two vsftpd configuration attributes are set by default.
The default values are the same as the vsftpd defaults,
and are set only to make the defaults available to the node.
* __node['basic_vsftpd']['config']['chroot_list_file']__, default: '/etc/vsftpd.chroot_list'
* __node['basic_vsftpd']['config']['userlist_file']__, default: '/etc/vsftpd.user_list'

To set other _vsftpd.conf_ attributes
```
# string attributes:
default['basic_vsftpd']['config']['option_name'] = 'string_option_value'
# YES/NO attributes
default['basic_vsftpd']['config']['yesno_option_name'] = 'YES' # or 'NO'
# numeric attributes
default['basic_vsftpd']['config']['numeric_option_name'] = 12345
default['basic_vsftpd']['config']['numeric_option_name'] = '12345' # also OK
```

### Other attributes
* __node['basic_vsftpd']['chroot_list']__, default: [], used by the chroot_list recipe, provides
user names to fill vsftpd's chroot_list file.
* __node['basic_vsftpd']['userlist']__, default: [], used by the userlist recipe, provides
user names to fill vsftpd's userlist file.

Requirements
------------


Contributing
------------

__Examples:__

Often the real trick is in configuring vsftpd.
Please consider documenting useful configuration examples
by adding a page to the wiki.

__Code:__

1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
-------------------
Authors: TODO: List authors
