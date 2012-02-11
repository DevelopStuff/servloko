require 'tempfile'
require 'pty'
require 'servloko/version'

module Servloko
  
  def self.start(opts = {})
    file = opts[:file]
    port = opts[:port] || 3000
    daemonize = opts[:daemonize] || false
    pid_file = opts[:pid_file] if daemonize
    
    puts "Servloko v#{Servloko::VERSION} booting on port #{port}"
    puts "------------------------------------------------------"
    rackup = Tempfile.new(['servloko','.ru'])
    begin
      if !daemonize
        rackup.write "use Rack::CommonLogger\n"
      end
      rackup.write "app = proc do |env|\n"
      rackup.write "  req = Rack::Request.new(env)\n"
      rackup.write "  body = [`ruby #{file} \"\#\{req.query_string\}\"`.chomp.gsub('\r\n','<br/>')]\n"
      rackup.write "  [200,{'Content-Type' => 'text/html'},body]\n"
      rackup.write "end\n"
      rackup.write "run app\n"
      rackup.flush

      if daemonize
        pid_file ||= File.join(Dir::tmpdir,"servloko.pid")
        puts "starting thin in daemon mode."
        puts "to stop: cat #{pid_file} | xargs kill"
        puts `thin start -R #{rackup.path} -p #{port} -d -P #{pid_file}`
      else
        PTY.spawn "thin start -R #{rackup.path} -p #{port}" do |r,w,p|
          loop { puts r.gets }
        end
      end
    rescue SignalException => e
      puts "shutting down..."
    ensure
      puts "------------------------------------------------------"
      rackup.close
      rackup.unlink
    end
  end
  
end
