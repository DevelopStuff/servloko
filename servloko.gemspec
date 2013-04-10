# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "servloko/version"

Gem::Specification.new do |s|
  s.name        = "servloko"
  s.version     = Servloko::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Jake Good"]
  s.email       = ["jake@whoisjake.com"]
  s.homepage    = "http://www.thoughtstoblog.com"
  s.summary     = %q{Servloko takes a ruby script and magically provides it's output to the web.}
  s.description = %q{Servloko takes a ruby script and magically provides it's output to the web. Be careful though, you could expose system details.}

  s.rubyforge_project = "servloko"
  s.add_dependency "thin", "~> 1.5.0"
  s.add_development_dependency "rake", "~> 10.0.0"
  
  s.files         = `git ls-files`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.rdoc_options     = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
end
