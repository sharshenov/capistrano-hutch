namespace :load do
  task :defaults do
    set :hutch_role, -> { :app }
    set :hutch_default_hooks, -> { true }

    set :hutch_pid, -> { File.join(shared_path, 'tmp', 'pids', 'hutch.pid') }
    set :hutch_config, -> { File.join(shared_path, 'config', 'hutch.yml') }
    set :hutch_env, -> { fetch(:rails_env, fetch(:rack_env, fetch(:stage))) }

    # Rbenv and RVM integration
    set :rbenv_map_bins, fetch(:rbenv_map_bins).to_a.concat(%w(hutch))
    set :rvm_map_bins, fetch(:rvm_map_bins).to_a.concat(%w(hutch))
  end
end

namespace :deploy do
  after :publishing, :restart_hutch do
    invoke 'hutch:restart' if fetch(:hutch_default_hooks)
  end
end

namespace :hutch do
  desc 'Start hutch'
  task :start do
    on roles fetch(:hutch_role) do
      within current_path do
        with rack_env: fetch(:hutch_env), rails_env: fetch(:hutch_env) do
          start_hutch unless hutch_pid_process_exists?
        end
      end
    end
  end

  desc 'Stop hutch'
  task :stop do
    on roles fetch(:hutch_role) do
      stop_hutch if hutch_pid_process_exists?
    end
  end

  desc 'Restart hutch'
  task :restart do
    invoke 'hutch:stop'
    invoke 'hutch:start'
  end

  desc 'Status hutch'
  task :status do
    on roles fetch(:hutch_role) do
      if hutch_pid_process_exists?
        info "Hutch is running"
      else
        warn "Hutch is not running!"
      end
    end
  end

  def hutch_pid_process_exists?
    hutch_pid_file_exists? and test(*("kill -0 $( cat #{fetch :hutch_pid} )").split(' '))
  end

  def hutch_pid_file_exists?
    test(*("[ -f #{fetch :hutch_pid} ]").split(' '))
  end

  def stop_hutch
    execute "kill -TERM `cat #{fetch :hutch_pid}`" if hutch_pid_process_exists?
  end

  def start_hutch
    args = []
    args.push "--pidfile #{fetch :hutch_pid}"
    args.push "--config #{fetch :hutch_config}"
    args.push '--daemon'
    args.push fetch(:hutch_options) if fetch(:hutch_options)

    execute :bundle, :exec, :hutch, args.compact.join(' ')
  end

end