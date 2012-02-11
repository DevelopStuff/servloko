require 'tempfile'
require 'pty'
require 'servloko/version'

module Servloko
  
  def self.start(file,thin_opts)
    puts "Servloko v#{Servloko::VERSION} booting thin"
    puts "------------------------------------------------------"
    rackup = Tempfile.new(['servloko','.ru'])
    begin
      
      unless thin_opts.include?("-d")
        rackup.write "use Rack::CommonLogger\n"
      end
      
      rackup.write "app = proc do |env|\n"
      rackup.write "  req = Rack::Request.new(env)\n"
      rackup.write "  body = [`ruby #{file} \"\#\{req.query_string\}\"`.chomp.gsub('\r\n','<br/>')]\n"
      rackup.write "  [200,{'Content-Type' => 'text/html'},body]\n"
      rackup.write "end\n"
      rackup.write "run app\n"
      rackup.flush
      
      PTY.spawn "thin start -R #{rackup.path} #{thin_opts}" do |r,w,p|
        loop { puts r.gets }
      end
    rescue SignalException => e
      puts
      puts "shutting down..."
    ensure
      puts "------------------------------------------------------"
      rackup.close
      rackup.unlink
    end
  end
  
end
