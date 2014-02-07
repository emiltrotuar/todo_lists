worker_processes 8
timeout 30

deploy_to = "/home/cartobus/apps/todo_lists"

working_directory "#{deploy_to}/current"

listen "unix:#{deploy_to}/shared/sockets/unicorn.sock", :backlog => 512
pid "#{deploy_to}/shared/pids/unicorn.pid"

log_path = "#{deploy_to}/shared/log"

stdout_path "#{log_path}/unicorn.log"
stderr_path "#{log_path}/unicorn_error.log"

preload_app true

if GC.respond_to?(:copy_on_write_friendly=)
  GC.copy_on_write_friendly = true
end

before_fork do |server, worker|
  old_pid = "#{server.config[:pid]}.oldbin"
  if File.exists?(old_pid) && server.pid != old_pid
    begin
      Process.kill("QUIT", File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
      # someone else did our job for us
    end
  end
end
