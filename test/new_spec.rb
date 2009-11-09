# Author: Davíð Halldór Lúðvíksson

require 'rubygems'
gem "rspec", "=1.2.8"
gem "selenium-client", "=1.2.17"
require "selenium/client"
require "selenium/rspec/spec_helper"
require "lib/constants"
require "lib/selenium_driver"

describe "New spec" do
  attr_reader :selenium_driver

  before(:all) do
    driver = SeleniumDriver.new
    @selenium_driver = driver.create_selenium_driver
  end

  before(:each) do
    @selenium_driver.start_new_browser_session
  end

  append_after(:each) do
    @selenium_driver.close_current_browser_session
  end
  
  it "should put new test spec here" do     
  end
end