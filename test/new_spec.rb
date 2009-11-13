# Author: Davíð Halldór Lúðvíksson - * - 

require "lib/constants"
require "lib/selenium_driver"

describe "New spec" do
  attr_reader :selenium_driver

  before(:all) do
    driver = SeleniumDriver.new
    @selenium_driver = driver.create_selenium_driver
    @selenium_driver.start_new_browser_session
  end

  before(:each) do
    @selenium_driver.open "/"
  end

  after(:all) do
    @selenium_driver.close_current_browser_session
  end
  
  it "should put new test spec here" do
  end
end