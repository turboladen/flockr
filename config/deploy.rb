require 'bundler/capistrano'

set :stages, %w(production staging)
set :default_stage, 'staging'
require 'capistrano/ext/multistage'

set :user, 'deploy'
set :domain, 'flockr.com'
set :application, 'flockr'

set :repository,  'git@github.com:turboladen/flockr.git'
set :deploy_to, "/opt/nginx/html/#{application}"

set :deploy_via, :remote_cache
set :scm, :git
set :scm_verbose, true
set :use_sudo, false
set :rails_env, 'production'


# chruby
set :ruby_version,  "2.0"
set :bundle_cmd,    "chruby-exec #{ruby_version} -- bundle"

# Passenger
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

# default_run_options[:pty] = true

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

