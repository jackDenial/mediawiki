# Cookbook Name:: media
# Recipe:: default
#
# Copyright 2017, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
include_recipe "apt"
include_recipe "apache2"
include_recipe "apache2::mod_php5"
include_recipe "apache2::mod_rewrite"
include_recipe "mysql::server"
include_recipe "database::mysql"

include_recipe "php::default"
include_recipe "php::module_apc"
include_recipe "php::module_mysql"



# Database connection information
mysql_connection_info = {
  :host     => 'localhost',
  :username => 'root',
  :password => node['mysql']['server_root_password']
}

# Create new database
mysql_database node['mediawiki']['database']['name'] do
  connection mysql_connection_info
  action :create
end

# Create new user
mysql_database_user node['mediawiki']['database']['user']  do
  connection mysql_connection_info
	password	node['mediawiki']['database']['password']
  action 		:create
end
  
# Grant privilages to user
mysql_database_user node['mediawiki']['database']['user'] do
  connection    mysql_connection_info
  database_name node["mediawiki"]["database"]["name"]
  privileges    [:all]
  action        :grant
end

# Add virtualhost
web_app "mediawiki" do
  server_name node["mediawiki"]["server_name"]
  docroot node["mediawiki"]["webdir"]
end

# Additional packages
case node["platform_family"]
when "rhel"
  package "php-xml"
  package "libicu-devel"
	service "apache2" do
    action :restart
  end
when "debian"
  package "libicu-dev"
end


php_pear "intl" do
    action :install
end

# Configure mediawiki database
bash "configure_mediawkiki_database" do
  user "root"
	cwd node["mediawiki"]["webdir"]
  code "php maintenance/install.php" + 
    " --pass '" + node["mediawiki"]["admin_password"] + 
    "' --dbname '" + node["mediawiki"]["database"]["name"] + 
    "' --dbpass '" + node["mediawiki"]["database"]["password"] + 
    "' --dbuser '" + node["mediawiki"]["database"]["name"] + 
    "' --server '" + node["mediawiki"]["server"] + 
    "' --scriptpath '" + node["mediawiki"]["scriptpath"] + 
    "' --lang '" + node["mediawiki"]["language_code"] +
    "' '" + node["mediawiki"]["site_name"] + "' '" + node["mediawiki"]["admin_user"] + "'"
	action :run
end
