set :domain, 'production.minahost.com'
set :user, 'vagrant'
set :identity_file, '.vagrant/machines/default/virtualbox/private_key'
set :application, 'production_minapumarails'
set :repository, 'git@github.com:thecantero/minapumarails.git'
set :web_url, ENV['PRODUCTION_WEB_URL']
set :visible_to_robots, false