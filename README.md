servloko
========
A simple way to take a ruby script and serve it up via an HTTP port.

usage
=====
servloko <file> [-p PORT] [-d (deamonize)]
	
	$> servloko /path/to/ruby/file.rb
	$> servloko /path/to/ruby/file.rb -p 3000
	$> servloko /path/to/ruby/file.rb -p 3000 -d