# Author: Davíð Halldór Lúðvíksson

# Task passes argument run the custom browser
if ENV['browser']
  p "arg is #{ENV['browser']}"
  BROWSER = ENV['browser']
else
  puts "Browser is default *firefox"
  BROWSER = '*firefox'
end

# Constants for site under test and the Selenium RC host
SITE = ""
HOST = ""