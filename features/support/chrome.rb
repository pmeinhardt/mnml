# Register a driver for chrome.

require 'selenium/webdriver'

Capybara.register_driver :chrome do |app|
  args = ['--window-size=1280,700']

  pref = Selenium::WebDriver::Chrome::Profile.new

  # Set Accept-Languages HTTP header:
  pref['intl.accept_languages'] = 'en'

  Capybara::Selenium::Driver.new(app,
    browser: :chrome,
    args:    args,
    profile: pref
  )
end
