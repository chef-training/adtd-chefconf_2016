if defined?(ChefSpec)
  def install_ark(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:ark, :install, resource_name)
  end

  def install_with_make_ark(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:ark, :install_with_make, resource_name)
  end

  # TODO: Define additional matchers for each supported action ...
  #
  # actions :install, :install_with_make, :dump, :cherry_pick, :put,
  #         :configure, :setup_py_build, :setup_py_install, :setup_py, :unzip
end
