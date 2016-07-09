resource_name :pip

property :package_name, String, name_attribute: true

action :install do
  pip_executable = '/usr/local/bin/pip3'

  execute "#{pip_executable} install #{package_name}"
end
