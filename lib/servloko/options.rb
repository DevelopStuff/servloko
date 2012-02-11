module Servloko
  module Options
    def self.parse(argv)
      opts = {}
      
      return opts unless ARGV.size > 0
      
      # file
      opts[:file] = ARGV[0].chomp
      
      opts[:daemonize]
            
      # port
      argv.each_with_index do |a,idx|
        if a == "-p" && !argv[idx+1].nil?
          opts[:port] = argv[idx+1].chomp.to_i
        end
        
        if a == "-d"
          opts[:daemonize] = true
          opts[:pid_file] = argv[idx+1].chomp if argv[idx+1]
        end
      end
      
      opts
    end
  end
end