# config valid only for Capistrano 3.1
lock '3.1.0'

set :application, 'bday'
set :repo_url, 'git@github.com:onesup/bday37.git'
set :scm_user, "onesup"


# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

# Default deploy_to directory is /var/www/my_app
set :deploy_to, "/home/deployer/www/bday"
set :user, "deployer"


# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
set :linked_files, %w{config/database.yml config/secrets.yml log/production.log log/development.log}

# Default value for linked_dirs is []
# set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }
set :default_env, {
  path: "$HOME/.rbenv/shims:$HOME/.rbenv/bin:$PATH",
}

set :rbenv_type, :user
set :rbenv_ruby, "2.1.1"

# Default value for keep_releases is 5
# set :keep_releases, 5


# capistrano-rails options

# If the environment differs from the stage name
# set :rails_env, 'staging'

# Defaults to 'db'
#set :migration_role, 'migrator'

# Defaults to [:web]
set :assets_roles, [:web, :app]

# Defaults to 'assets' this should match config.assets.prefix in your rails config/application.rb
# set :assets_prefix, 'prepackaged-assets'

# If you need to touch public/images, public/javascripts and public/stylesheets on each deploy:
set :normalize_asset_timestamps, %{public/images public/javascripts public/stylesheets}


# using ForwardAgent
# set :ssh_options, { forward_agent: true }


namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      # execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :publishing, :restart

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

end
