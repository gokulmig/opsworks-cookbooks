require 'minitest/spec'

describe_recipe 'apache2::mod_php5' do
  include MiniTest::Chef::Resources
  include MiniTest::Chef::Assertions

  it 'installs dependencies' do
    case node[:platform]
    when 'debian', 'ubuntu'
      package('libapache2-mod-php5').must_be_installed
    when 'centos','amazon','redhat','amazon','fedora','scientific','oracle'
      package('php').must_be_installed
    end
  end

  it 'enables mod_php5' do
    link("#{node[:apache][:dir]}/mods-enabled/php5.load").must_exist.with(
         :link_type, :symbolic).and(:to, "#{node[:apache][:dir]}/mods-available/php5.load")
  end
end
