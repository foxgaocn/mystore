set :rvm_type, :user                     # Defaults to: :auto
set :rvm_ruby_version, '2.1.0'


set :application, 'brewwizard'
set :repo_url, 'git@github.com:foxgaocn/mystore.git'

# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

set :deploy_to, '/home/ubuntu/store'
set :scm, :git

set :ssh_options, {:forward_agent => true, :keys => [File.join(ENV["HOME"], ".ssh", "wanhoo.pem")]}
set :use_sudo, false
set :user, "ubuntu"

role :web, "54.206.49.183"         # Your HTTP server,
role :app, "54.206.49.183"                          # This may be the same as your `Web` server
role :db,  "54.206.49.183", :primary => true # This is where Rails migrations will run


# set :format, :pretty
# set :log_level, :debug
# set :pty, true

# set :linked_files, %w{config/database.yml}
# set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# set :default_env, { path: "/opt/ruby/bin:$PATH" }
# set :keep_releases, 5

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      execute :touch, release_path.join('tmp/restart.txt')
      #run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
    end
  end

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

  after :finishing, 'deploy:cleanup'

end

namespace :db do
  desc "creates database & database user"
  task :create do  
    on roles(:db), in: :sequence, wait: 5 do
      execute :rake, 'db:create'
    end
  end
end
