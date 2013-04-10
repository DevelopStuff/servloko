require "bundler"

Bundler.setup
Bundler::GemHelper.install_tasks

require "rake"
require "rdoc/task"

task :clobber do
  rm_rf 'pkg'
  rm_rf 'tmp'
  rm_rf 'rdoc'
end

task(:release).clear_prerequisites.clear_actions

Rake::RDocTask.new do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "servloko gem"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end