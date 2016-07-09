require 'spec_helper'

describe 'ark::default' do
  let(:chef_run) do
    runner = ChefSpec::SoloRunner.new(node_attributes)
    runner.converge(described_recipe)
  end

  let(:node_attributes) do
    {}
  end

  shared_examples 'installs packages' do
    it 'installs necessary packages' do
      installed_packages.each { |name| expect(chef_run).to install_package(name) }
    end
  end

  shared_examples 'does not install packages' do
    it 'does not install packages' do
      packages_not_installed.each { |name| expect(chef_run).not_to install_package(name) }
    end
  end

  context 'when no attributes are specified, on an unspecified platform' do

    let(:installed_packages) do
      %w[ libtool autoconf unzip rsync make gcc autogen ]
    end

    it_behaves_like 'installs packages'

    let(:packages_not_installed) do
      %w[ gcc-c++ seven_zip ]
    end

    it_behaves_like 'does not install packages'

    it "apache mirror" do
      attribute = chef_run.node['ark']['apache_mirror']
      expect(attribute).to eq "http://apache.mirrors.tds.net"
    end

    it "prefix root" do
      attribute = chef_run.node['ark']['prefix_root']
      expect(attribute).to eq "/usr/local"
    end

    it "prefix bin" do
      attribute = chef_run.node['ark']['prefix_bin']
      expect(attribute).to eq "/usr/local/bin"
    end

    it "prefix home" do
      attribute = chef_run.node['ark']['prefix_home']
      expect(attribute).to eq "/usr/local"
    end

    it "tar binary" do
      attribute = chef_run.node['ark']['tar']
      expect(attribute).to eq "/bin/tar"
    end
  end

  context 'when no attributes are specified, on CentOS' do
    let(:node_attributes) do
      { platform: 'centos', version: '6.7' }
    end

    let(:installed_packages) do
      %w[ libtool autoconf unzip rsync make gcc xz-lzma-compat bzip2 tar ]
    end

    it_behaves_like 'installs packages'
  end

  context 'when no attributes are specified, on Debian' do
    let(:node_attributes) do
      { platform: 'ubuntu', platform_family: 'debian', version: '14.04' }
    end

    let(:installed_packages) do
      %w[ libtool autoconf unzip rsync make gcc autogen shtool pkg-config ]
    end

    it_behaves_like 'installs packages'
  end

  context 'when no attributes are specified, on FreeBSD' do
    let(:node_attributes) do
      { platform: 'freebsd', version: '10.2' }
    end

    let(:installed_packages) do
      %w[ libtool autoconf unzip rsync gmake gcc autogen gtar ]
    end

    it_behaves_like 'installs packages'

    it "tar binary" do
      attribute = chef_run.node['ark']['tar']
      expect(attribute).to eq '/usr/bin/tar'
    end
  end

  context 'when no attributes are specified, on Mac OSX' do
    let(:node_attributes) do
      { platform: 'mac_os_x', version: '10.11.1' }
    end

    let(:packages_not_installed) do
      %w[ libtool autoconf unzip rsync make gcc ]
    end

    it_behaves_like 'does not install packages'

    it "tar binary" do
      attribute = chef_run.node['ark']['tar']
      expect(attribute).to eq '/usr/bin/tar'
    end
  end

  context 'when no attributes are specified, on RHEL' do
    let(:node_attributes) do
      { platform: 'redhat', platform_family: 'rhel', version: '6.5' }
    end

    let(:installed_packages) do
      %w[ libtool autoconf unzip rsync make gcc xz-lzma-compat bzip2 tar ]
    end

    it_behaves_like 'installs packages'
  end

  context 'when no attributes are specified, on SmartOS' do
    let(:node_attributes) do
      { platform: 'smartos', version: '5.11' }
    end

    let(:installed_packages) do
      %w[ libtool autoconf unzip rsync make gcc gtar autogen ]
    end

    it_behaves_like 'installs packages'

    it "tar binary" do
      attribute = chef_run.node['ark']['tar']
      expect(attribute).to eq '/bin/gtar'
    end
  end

  context 'when no attributes are specified, on Windows' do
    let(:node_attributes) do
      { platform: 'windows', version: '2012R2' }
    end

    let(:packages_not_installed) do
      %w[ libtool autoconf unzip rsync make gmake gcc autogen xz-lzma-compat bzip2 tar ]
    end

    it_behaves_like 'does not install packages'

    it "tar binary" do
      attribute = chef_run.node['ark']['tar']
      expect(attribute).to eq '"\7-zip\7z.exe"'
    end
  end
end
