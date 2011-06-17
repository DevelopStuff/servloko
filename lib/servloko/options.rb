module Servloko
  module Options
    def self.parse(argv)
      opts = {}
      # file
      opts[:file] = ARGV[0].chomp
      
      opts[:deamonize]
            
      # port
      argv.each_with_index do |a,idx|
        if a == "-p" && !argv[idx+1].nil?
          opts[:port] = argv[idx+1].chomp.to_i
        end
        
        if a == "-d"
          opts[:deamonize] = true
        end
      end
      
      opts
    end
  end
end