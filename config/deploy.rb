# config valid only for current version of Capistrano
lock "3.9.1"

set :application, 'anotheryou'
set :repo_url, 'git@github.com:codefarmdev/api.anotheryou.com.br.git'
set :deploy_to, ENV["DEPLOY_SERVER_PATH"]
set :pty, true
set :rvm_type, :system
set :rvm_ruby_version, "2.3.1@anotheryou"
set :ssh_options, {:forward_agent => true}

set :deployer, -> {
  name = `git config user.name`.strip
  name = `whoami`.strip if name == ''
  name
}

set :semver, -> {
  version = `semver tag`.strip
  version
}

set :slack_webhook, "https://hooks.slack.com/services/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"

set :slack_icon_url,         -> { 'https://codefarm.com.br/img/square.png' }
set :slack_channel,          -> { '#another-you' }
set :slack_username,         -> { 'farmerbot' }
set :slack_run_starting,     -> { true }
set :slack_run_finished,     -> { true }
set :slack_run_failed,       -> { true }
set :slack_msg_starting,     -> { "#{fetch(:deployer)} *iniciou* o deploy para *#{fetch(:stage)}* (#{fetch(:semver)}) . :rocket:" }
set :slack_msg_finished,     -> { "#{fetch(:deployer)} *terminou* o deploy para *#{fetch(:stage)}* (#{fetch(:semver)}) . :star2:" }
set :slack_msg_failed,       -> { "#{fetch(:deployer)} *fez cagada* no deploy para *#{fetch(:stage)}* (#{fetch(:semver)}) . :shit:" }

set :tmp_dir, "#{deploy_to}/tmp"
set :linked_files, fetch(:linked_files, []).push('config/database.yml', '.env')
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')
set :bundle_binstubs, nil
set :default_env, { rvm_bin_path: '~/.rvm/bin' }

namespace :deploy do
  task :restart do
    on roles(:app) do
      execute("touch #{deploy_to}/current/tmp/restart.txt")
    end
  end
end

after 'deploy:finishing', 'deploy:restart'