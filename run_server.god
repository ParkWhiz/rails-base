script_path = File.expand_path(File.dirname(__FILE__))

app_name = ENV['PARKWHIZ_APP_NAME'] || 'unspecified'
my_ip = Net::HTTP::get('icanhazip.com', '/index.html').strip

God.contact(:slack) do |c|
  c.name = 'restart'
  c.url = ENV['HEALTHCHECK_SLACK_URL'] || "http://notifications-disabled.parkwhiz.com"
  c.channel = '#rails_supervisor'
  c.format = "App: #{app_name} @ #{my_ip} restarted due to failing health check"
end

God.watch do |w|
  w.name = 'run_server'
  w.keepalive
  # command used to start the server
  w.start = ENV['PARKWHIZ_RUN_COMMAND'] || 'passenger start'
  w.dir = ENV['PARKWHIZ_RUN_DIR'] || '/app'
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
      # Of times_of health checks, times_in checks must fail before we restart
      times_in = (ENV['HEALTHCHECK_TIMES_IN'] || 3).to_i
      times_of = (ENV['HEALTHCHECK_TIMES_OF'] || 3).to_i
      c.times = [times_in, times_of]
      c.notify = 'restart'
    end
  end
  w.lifecycle do |on|
    on.condition(:flapping) do |c|
      # If we find ourselves restarting over and over, stop monitoring for
      #   a while. If it keeps happening, stop monitoring permanently
      c.to_state = [:start, :restart]
      c.transition = :unmonitored
      # number of restarts before we back off
      c.times = (ENV['HEALTHCHECK_FLAP_MAX_RESTART_TIMES'] || 5).to_i
      # amount of time within restarts must take place
      c.within = (ENV['HEALTHCHECK_FLAP_MAX_RESTART_WITHIN'] || 30 * 60).to_i
      # time after which to try monitoring again
      c.retry_in = (ENV['HEALTHCHECK_FLAP_RETRY_IN'] || 30 * 60).to_i
      # amount of times to try restoring monitoring before backing off forever
      c.retry_times = (ENV['HEALTHCHECK_FLAP_RETRY_TIMES'] || 5).to_i
      # amount of time within which failed attempts to resume monitoring must
      #   take place
      c.retry_within = (ENV['HEALTHCHECK_FLAP_RETRY_WITHIN'] || 5 * 60 * 60).to_i
    end
  end
end
