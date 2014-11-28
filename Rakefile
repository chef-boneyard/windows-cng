require 'rake'
require 'rake/clean'
require 'rake/testtask'

CLEAN.include('**/*.gem', '**/*.log')

namespace 'gem' do
  desc "Create the windows-cng gem"
  task :create => [:clean] do
    Dir["*.gem"].each{ |f| File.delete(f) }
    spec = eval(IO.read('windows-cng.gemspec'))

    if Gem::VERSION < "2.0"
      Gem::Builder.new(spec).build
    else
      require 'rubygems/package'
      Gem::Package.build(spec)
    end
  end
  
  desc "Install the windows-cng gem"
  task :install => [:create] do
    file = Dir["*.gem"].first
    sh "gem install -l #{file}"
  end
end

desc "Run the example program"
task :example do
  sh "ruby -Ilib examples/dir_example.rb"
end

Rake::TestTask.new do |t|
  t.warning = true
  t.verbose = true
end

task :default => :test
