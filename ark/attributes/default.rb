default['ark']['apache_mirror'] = 'http://apache.mirrors.tds.net'
default['ark']['prefix_root'] = '/usr/local'
default['ark']['prefix_bin'] = '/usr/local/bin'
default['ark']['prefix_home'] = '/usr/local'

default['seven_zip']['home'] = '\\7-zip'

default['ark']['tar'] = case node['platform_family']
                        when 'windows'
                          "\"#{ENV['SYSTEMDRIVE']}\\7-zip\\7z.exe\""
                        when 'mac_os_x', 'freebsd'
                          '/usr/bin/tar'
                        when 'smartos'
                          '/bin/gtar'
                        else
                          '/bin/tar'
                        end


pkgs = %w(libtool autoconf) unless platform_family?('mac_os_x', 'windows')
pkgs += %w(make) unless platform_family?('mac_os_x', 'windows', 'freebsd')
pkgs += %w(unzip rsync gcc) unless platform_family?('mac_os_x', 'windows')
pkgs += %w(autogen) unless platform_family?('rhel', 'fedora', 'mac_os_x', 'suse', 'windows')
pkgs += %w(gtar) if platform?('freebsd') || platform?('smartos')
pkgs += %w(gmake) if platform?('freebsd')
pkgs += %w(xz-lzma-compat bzip2 tar) if platform_family?('rhel', 'fedora')
pkgs += %w(shtool pkg-config) if platform_family?('debian')

default['ark']['package_dependencies'] = pkgs
