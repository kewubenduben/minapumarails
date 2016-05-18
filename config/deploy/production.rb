set :domain, 'production.minahost.com'
set :user, 'vagrant'
set :application, 'production_minapumarails'
set :repository, 'git@github.com:thecantero/minapumarails.git'
set :web_url, ENV['PRODUCTION_WEB_URL']
set :visible_to_robots, false