require 'tempfile'
require 'servloko/version'

module Servloko
  
  def self.start(file,port,daemonize)
    
    rackup = Tempfile.new(['servloko','.ru'])
    
    begin
       rackup.write "app = proc do |env|\n"
       rackup.write "  body = [`ruby #{file}`.chomp.gsub('\r\n','<br/>')]\n"
       rackup.write "  [200,{'Content-Type' => 'text/html'},body]\n"
       rackup.write "end\n"
       rackup.write "run app\n"
       rackup.flush

       if daemonize
         puts `nohup thin start -R #{rackup.path} -p #{port} &`
       else
         puts `thin start -R #{rackup.path} -p #{port}`
       end
    ensure
       rackup.close
       rackup.unlink
    end
  end
  
end
