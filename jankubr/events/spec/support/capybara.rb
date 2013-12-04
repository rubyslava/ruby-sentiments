require 'capybara/rails'
RSpec.configure do |c|
  c.include Capybara::DSL, :example_group => {
    :file_path => /\bspec\/integration\//
  }
end
Capybara.javascript_driver = :webkit
