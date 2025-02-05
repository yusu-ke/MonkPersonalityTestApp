# spec/support/headless.rb
# frozen_string_literal: true

Capybara.register_driver :selenium_chrome_headless do |app|
  version = Capybara::Selenium::Driver.load_selenium
  options_key = Capybara::Selenium::Driver::CAPS_VERSION.satisfied_by?(version) ? :capabilities : :options
  browser_options = ::Selenium::WebDriver::Chrome::Options.new.tap do |opts|
    opts.add_argument("--headless")
    opts.add_argument("--disable-gpu") if Gem.win_platform?
    opts.add_argument("--no-sandbox")
    opts.add_argument("--window-size=1680,1050")
    opts.add_argument("--disable-site-isolation-trials")
    opts.add_preference("download.default_directory", Capybara.save_path)
    opts.add_preference(:download, default_directory: Capybara.save_path)
  end

  Capybara::Selenium::Driver.new(app, **{ browser: :chrome, options_key => browser_options })
end

RSpec.configure do |config|
  config.before(:each, type: :system) do
    driven_by :selenium_chrome_headless
  end
end
