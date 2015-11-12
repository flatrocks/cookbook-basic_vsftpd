basic_vsftpd Cookbook
=====================

A basic cookbook to install and configure the vsftpd package.

All vsftpd configuration options can be set using this cookbook,
and no "helpful" defaults are provided.
See [Attributes](#attributes) for details.

## Supported platforms
This cookbook has only been tested for Ubuntu 14.04.

Testing/adding support for other platforms is encouraged.  See [Contributing](#contributing).

## Recipes

### default
This recipe:
* installs the vsftpd package
* creates the vsftpd.conf configuration file
from ```node['basic_vsftpd']['config']['...']``` attributes
* if ```node['basic_vsftpd']['config']['user_config_dir']``` is set, creates an empty user config directory
* enables and starts the ```vsftpd``` service

### chroot_list
Creates a chroot_list file for vsftpd from node attributes.
See [Other attributes](@other-attributes) for details.
_If you don't want to use this recipe, you can create the chroot_list file manually._

### userlist
Creates a userlist file for vsftpd from node attributes.
See [Other attributes](@other-attributes) for details.
_If you don't want to use this recipe, you can create the userlist file manually._

## Resources

### user_conf
This resource creates a user configuration file in the vsftpd user_config_dir directory.

Properties:
* __user__, string, name property, the name of the user
* __content__, string, the content of the user config file

Actions:
* :create, :delete

Note: This resource requires the ```node['basic_vsftpd']['config']['user_config_dir']```
attribute to be set and for the directory to exist.

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

Note: When setting ```node['basic_vsftpd']['config'][...]``` attributes using Ruby,
each should be set individually, __not__ all at once using a Ruby hash.  That is,
```
# Yes
default['basic_vsftpd']['config']['option1'] = 'setting1'
default['basic_vsftpd']['config']['option2'] = 'setting2'

# NO!
default['basic_vsftpd']['config'] = {
  'option1' => 'setting1',
  'option2' => 'setting2'
}
```

### Other attributes
* __node['basic_vsftpd']['chroot_list']__, default: [ ], used by the chroot_list recipe, list of
user names to fill vsftpd's chroot_list file.
* __node['basic_vsftpd']['userlist']__, default: [ ], used by the userlist recipe, list of
user names to fill vsftpd's userlist file.

Requirements
------------


Contributing
------------

__Examples:__

Often the real trick is in configuring vsftpd,
for a specific application,
but that's outside the scope of this cookbook.
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
Author: Tom Wilson (tom at rollnorocks.com)

    Copyright (C) 2015, Tom Wilson

    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License along
    with this program; if not, write to the Free Software Foundation, Inc.,
    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
