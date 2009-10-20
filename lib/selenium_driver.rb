# Author: Davíð Halldór Lúðvíksson

require 'rubygems'
gem "rspec", "=1.2.8"
gem "selenium-client", ">=1.2.17"
require "selenium/client"
require "selenium/rspec/spec_helper"
require "lib/constants"

# Class for making instance of the Selenium driver for every testsuite
class SeleniumDriver
  def create_selenium_driver
    driver = Selenium::Client::Driver.new \
                        :host => HOST,
                        :port => 4444,
                        :browser => BROWSER,
                        :url => "http://#{SITE}",
                        :timeout_in_second => 60
    return driver
  end
end