script_path = File.expand_path(File.dirname(__FILE__))

God.watch do |w|
  w.name = 'run_server'
  w.start = ENV['PARKWHIZ_RUN_COMMAND'] || 'rails server'
  w.start_grace = 60
  w.keepalive
  w.restart_if do |restart|
    restart.condition(:http_response_code) do |c|
      c.host = ENV['PARKWHIZ_HOST'] || 'localhost'
      c.port = ENV['PARKWHIZ_PORT'] || 3000
      c.path = ENV['PARKWHIZ_HEALTHCHECK_PATH'] || '/'
      c.code_is_not = 200..299
      c.timeout = ENV['PARKWHIZ_HEALTHCHECK_TIMEOUT'] || 10
      c.interval = ENV['PARKWHIZ_HEALTHCHECK_INTERVAL'] || 60
    end
  end
end
