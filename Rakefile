require 'rubygems'
require 'rake'
require File.expand_path('../lib/remotipart/rails/version', __FILE__)

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "remotipart"
    gem.summary = %Q{Remotipart is a Ruby on Rails gem enabling remote multipart forms (AJAX style file uploads) with jQuery.}
    gem.description = %Q{Remotipart is a Ruby on Rails gem enabling remote multipart forms (AJAX style file uploads) with jQuery.
    This gem augments the native Rails 3 jQuery-UJS remote form function enabling asynchronous file uploads with little to no modification to your application.
    }
    gem.email = %w{greg@formasfunction.com steve@alfajango.com}
    gem.homepage = "http://www.alfajango.com/blog/remotipart-rails-gem/"
    gem.authors = ["Greg Leppert", "Steve Schwartz"]
    gem.add_development_dependency "thoughtbot-shoulda", ">= 0"
    gem.version = Remotipart::Rails::VERSION
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
  Jeweler::RubygemsDotOrgTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

require 'rspec/core'
require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = FileList['spec/**/*_spec.rb']
end

RSpec::Core::RakeTask.new(:rcov) do |spec|
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rcov = true
end

begin
  require 'rcov/rcovtask'
  Rcov::RcovTask.new do |test|
    test.libs << 'spec'
    test.pattern = 'spec/**/*_spec.rb'
    test.verbose = true
  end
rescue LoadError
  task :rcov do
    abort "RCov is not available. In order to run rcov, you must: sudo gem install spicycode-rcov"
  end
end

task :test => :check_dependencies

task :default => :spec

require 'rake/rdoctask'
require File.expand_path('../lib/remotipart/rails/version', __FILE__)
Rake::RDocTask.new do |rdoc|
  version = Remotipart::Rails::VERSION

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "remotipart #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
