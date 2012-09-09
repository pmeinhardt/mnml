# Configure Capybara for use with cucumber.

Capybara.configure do |config|
  # Use Chrome as the default browser for javascript testing:
  # config.javascript_driver = :chrome

  # Use the given selector type:
  config.default_selector = :css

  # Ignore hidden elements on the page:
  config.ignore_hidden_elements = true

  # Set capybara server port:
  config.server_port = 7787
end
