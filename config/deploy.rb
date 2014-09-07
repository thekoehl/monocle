# config valid only for Capistrano 3.1
lock '3.2.1'

set :application, 'monocle'
set :repo_url, 'git@github.com:phantomdata/monocle.git'

set :linked_files, %w{config/database.yml .env config/puma.rb}
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

set :chruby_ruby, 'ruby-2.1.2'
set :shell, '/bin/bash'
set :pty, true

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute "cd #{release_path} && source /usr/local/share/chruby/chruby.sh && chruby ruby-2.1.2 && RAILS_ENV=production bundle install"
      execute "cd #{release_path} && source /usr/local/share/chruby/chruby.sh && chruby ruby-2.1.2 && RAILS_ENV=production bundle exec rake db:migrate"
      execute "[ -e #{release_path}/tmp/pids/puma-production.pid ] && kill -SIGUSR2 `cat #{release_path}/tmp/pids/puma-production.pid` || true"
    end
  end

  after :publishing, :restart
end
