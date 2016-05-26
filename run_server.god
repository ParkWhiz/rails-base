script_path = File.expand_path(File.dirname(__FILE__))

God.watch do |w|
  w.name = 'run_server'
  w.keepalive
  # command used to start the server
  w.start = ENV['PARKWHIZ_RUN_COMMAND'] || 'passanger start'
  # seconds to wait after start before health checks begin
  w.start_grace = (ENV['HEALTHCHECK_START_GRACE'] || 60).to_i
  w.restart_if do |restart|
    restart.condition(:http_response_code) do |c|
      # For detailed explanation on these parameters, see:  
      #   https://github.com/mojombo/god/blob/master/lib/god/conditions/http_response_code.rb
      c.host = ENV['HEALTHCHECK_HOST'] || 'localhost'
      c.port = (ENV['HEALTHCHECK_PORT'] || 3000).to_i
      c.path = ENV['HEALTHCHECK_PATH'] || '/'
      c.code_is_not = 200..299
      c.timeout = (ENV['HEALTHCHECK_TIMEOUT'] || 60).to_i
      c.interval = (ENV['HEALTHCHECK_INTERVAL'] || 60).to_i
      times_in = (ENV['HEALTHCHECK_TIMES_IN'] || 3).to_i
      times_of = (ENV['HEALTHCHECK_TIMES_OF'] || 3).to_i
      # Of times_of health checks, times_in checks must fail before we restart
      c.times = [times_in, times_of]
    end
  end
end
