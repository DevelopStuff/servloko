servloko
========
A simple way to take a ruby script and serve it up via an HTTP port.

install
=======
	$> gem install servloko

usage
=====
servloko <file> [thin opts (thin -h)]
	
	$> servloko /path/to/ruby/file.rb
	$> servloko /path/to/ruby/file.rb [thin opts]