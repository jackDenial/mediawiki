default["mediawiki"]["version"]              = "1.28"
default["mediawiki"]["webdir"]               = node['apache']['docroot_dir'] + "/mediawiki-" + default["mediawiki"]["version"]
default["mediawiki"]["tarball"]["name"]      = "mediawiki-" + default["mediawiki"]["version"] + ".tar.gz"
default["mediawiki"]["tarball"]["url"]       = "https://releases.wikimedia.org/mediawiki/1.23/" + default["mediawiki"]["tarball"]["name"]
default["mediawiki"]["database"]["name"]     = "mediawiki"
default["mediawiki"]["database"]["user"]     = "mediawiki"
default["mediawiki"]["database"]["password"] = "Atmecs@123"
default["mediawiki"]["server_name"]          = "wiki.localhost"
default["mediawiki"]["scriptpath"]           = ""
default['mysql']['server_root_password']     = 'Atmecs@123'

default["mediawiki"]["server"]               = "http://" + default["mediawiki"]["server_name"] 
default["mediawiki"]["site_name"]            = "my Wiki"
default["mediawiki"]["language_code"]        = "en"
default["mediawiki"]["admin_user"]           = "administrator"
default["mediawiki"]["admin_password"]       = "admin
