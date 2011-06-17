require 'tempfile'
require 'servloko/version'

module Servloko
  
  def self.start(file,port,daemonize)
    
    rackup = Tempfile.new('servloko.ru')
    
    begin
       rackup.write "app = proc do |env|\n"
       rackup.write "  body = [`ruby #{file}`.chomp]\n"
       rackup.write "  [200,{'Content-Type => 'text/html'},body]\n"
       rackup.write "end\n"
       rackup.write "run app\n"
       rackup.flush

       if daemonize
         `nohup thin -R #{rackup} -p #{port} &`
       else
         `thin -R #{rackup} -p {port}`
       end
    ensure
       rackup.close
       rackup.unlink
    end
  end
  
end
