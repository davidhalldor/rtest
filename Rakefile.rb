# Author: Davíð Halldór Lúðvíksson

require 'rubygems'
gem 'ci_reporter'
require 'ci/reporter/rake/rspec'
require 'rake/rdoctask'
require 'rake/testtask'
require 'selenium/rake/tasks'
require 'spec/rake/spectask'

# Rake build to make rdoc, start Selenium server, stop Selenium server,
# run unit tests, run rspec tests, run failing rspec tests,
# make Selenium, ci reports and run Selenium acceptance tests

desc 'Create rdoc'
Rake::RDocTask.new('rdoc') do |rdoc|
  rdoc.title = 'TestTvSmartLykilord'
  rdoc.main  = 'README'
  rdoc.options << '-c utf-8'
  rdoc.rdoc_files.include 'test/*.rb', 'README', 'LICENSE'
end

desc 'Start the Selenium server'
Selenium::Rake::RemoteControlStartTask.new('start') do |rc|
  if File.directory?("selenium")
    rm_rf 'selenium'
  end
  mkdir 'selenium'
  rc.port = 4444
  rc.timeout_in_seconds = 3 * 60
  rc.background = true
  rc.wait_until_up_and_running = true
  rc.jar_file = "vendor/selenium-server.jar"
  rc.additional_args << "-singleWindow"
  rc.log_to = "Selenium/server.log"
  if ENV['FIREFOX_PROFILE']
    rc.additional_args << "-firefoxProfileTemplate #{ENV['FIREFOX_PROFILE']}"
  end
end

desc 'Run all specs tests for web application'
Spec::Rake::SpecTask.new('spec') do |task|
  task.fail_on_error = false
  task.spec_files = FileList['test/breyta_internet_askrift_spec.rb', 'test/uppfletting_pantana_spec.rb',
          'test/stilla_tilkynningar_spec.rb']
  task.spec_opts << '--backtrace' <<
          '--format' << 'progress' <<
          '--format' << 'failing_examples:failed'
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
  rm_rf 'Selenium'
  rm_f 'failed'
end

task 'default'=> 'spec'

desc 'Run the acceptance test'
task :acceptance => [:start, :spec, :stop]

