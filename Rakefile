# Author: Davíð Halldór Lúðvíksson

require 'rubygems' unless ENV['NO_RUBYGEMS']
require 'rake/gempackagetask'
require 'rubygems/specification'
require 'date'
gem 'ci_reporter'
gem "rspec", "=1.2.8"
gem "selenium-client", "=1.2.17"
gem "syntax"
require 'ci/reporter/rake/rspec'
require 'rake/rdoctask'
require 'rake/testtask'
require 'selenium/rake/tasks'
require 'spec/rake/spectask'

GEM = "rtest"
AUTHOR = "Davíð Halldór Lúðvíksson"
EMAIL = "davidhalldor@gmail.com"
HOMEPAGE = "http://github.com/davidhalldor/rtest"
SUMMARY = "A gem that provides Ruby Selenium test skeleton project"

# Rake build to make rdoc, start Selenium server, stop Selenium server,
# run unit tests, run rspec tests, run failing rspec tests,
# make Selenium, ci reports and run Selenium acceptance tests

desc 'Create rdoc'
Rake::RDocTask.new('rdoc') do |rdoc|
  rdoc.title = GEM
  rdoc.main  = 'README'
  rdoc.options << '-c utf-8'
  rdoc.rdoc_files.include 'test/*.rb', 'README', 'LICENSE'
end

desc 'Start the Selenium server'
Selenium::Rake::RemoteControlStartTask.new('start') do |rc|
  if not File.directory?("selenium")
    mkdir 'selenium'
  end
  rc.port = 4444
  rc.timeout_in_seconds = 3 * 60
  rc.background = true
  rc.wait_until_up_and_running = true
  rc.jar_file = "vendor/selenium-server.jar"
  rc.additional_args << "-singleWindow"
  rc.log_to = "selenium/server.log"
  if ENV['FIREFOX_PROFILE']
    rc.additional_args << "-firefoxProfileTemplate #{ENV['FIREFOX_PROFILE']}"
  end
end

desc 'Run all specs tests for web application'
Spec::Rake::SpecTask.new('spec') do |task|
  task.fail_on_error = false
  task.spec_files = FileList['test/*_spec.rb']
  task.spec_opts << '--color'
  task.spec_opts << "--require 'rubygems,selenium/rspec/reporting/selenium_test_report_formatter'"
  task.spec_opts << "--format=Selenium::RSpec::SeleniumTestReportFormatter:./tmp/acceptance_tests_report.html"
  task.spec_opts << "--format=progress"
  task.verbose = true
end

desc 'Run all failing examples'
Spec::Rake::SpecTask.new('failed') do |task|
  task.spec_files = FileList['test/*_spec.rb']
  task.spec_opts << '--loadby' << 'mtime' <<
          '--backtrace' <<
          '--format' << 'progress' <<
          '--format' << 'failing_examples:failed' <<
          '--example' << 'failed'
end

desc 'Stop the selenium server'
Selenium::Rake::RemoteControlStopTask.new('stop') do |rc|
  rc.host = "localhost"
  rc.port = 4444
  rc.timeout_in_seconds = 3 * 60
end

desc 'Clean temporary directories and files'
task 'clobber' do
  rm_rf 'tmp'
  rm_rf 'selenium'
  rm_f 'failed'
end

# Gemspec specific tasks

spec = Gem::Specification.new do |s|
  s.name = GEM
  s.version = "0.0.3"
  s.author = AUTHOR
  s.email = EMAIL
  s.homepage = HOMEPAGE
  s.description = s.summary = SUMMARY

  s.platform = Gem::Platform::RUBY
  s.has_rdoc = true
  s.extra_rdoc_files = ["README", "LICENSE"]

  s.add_dependency "ci_reporter"
  s.add_dependency "rspec", "=1.2.8"
  s.add_dependency "selenium-client", "=1.2.17"
  s.add_dependency "syntax"

  s.require_path = 'lib'
  s.autorequire = GEM
  s.files = %w(LICENSE README Rakefile) + Dir.glob("{lib,test,vendor}/**/*")
end

Rake::GemPackageTask.new(spec) do |pkg|
  pkg.gem_spec = spec
end

desc "install the gem locally"
task :install => [:package] do
  sh %{sudo gem install pkg/#{GEM}-#{VERSION}}
end

desc "create a gemspec file"
task :make_spec do
  File.open("#{GEM}.gemspec", "w") do |file|
    file.puts spec.to_ruby
  end
end

task :default => :spec

desc 'Run the acceptance test'
task :acceptance => [:start, :spec, :stop]