require 'tempfile'
require 'servloko/version'

module Servloko
  
  def self.start(file,port,daemonize)
    puts "Servloko v#{Servloko::VERSION} booting on port #{port}"
    puts "------------------------------------------------------"
    rackup = Tempfile.new(['servloko','.ru'])
    begin
      rackup.write "app = proc do |env|\n"
      rackup.write "  req = Rack::Request.new(env)\n"
      rackup.write "  body = [`ruby #{file} \"\#\{req.query_string\}\"`.chomp.gsub('\r\n','<br/>')]\n"
      rackup.write "  [200,{'Content-Type' => 'text/html'},body]\n"
      rackup.write "end\n"
      rackup.write "run app\n"
      rackup.flush

      if daemonize
        puts `nohup thin start -R #{rackup.path} -p #{port} &`
      else
        puts `thin start -R #{rackup.path} -p #{port}`
      end
    rescue SignalException => e
      puts
    ensure
      puts "------------------------------------------------------"
      puts "shutting down..."
      rackup.close
      rackup.unlink
    end
  end
  
end
