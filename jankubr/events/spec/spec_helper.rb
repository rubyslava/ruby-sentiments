ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

RSpec.configure do |config|
  config.mock_with :rspec

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # config.before(:each) do
    # if Capybara.current_driver == :rack_test
    #   DatabaseCleaner.strategy = :transaction
    # else
    #   DatabaseCleaner.strategy = :truncation
    # end
    # DatabaseCleaner.start
  # end

  # config.after :each do
  #   DatabaseCleaner.clean
  # end

  # config.after :all do
  #   ActiveRecord::Base.connection.tables.each do |table|
  #     ActiveRecord::Base.connection.execute("TRUNCATE TABLE #{table}")
  #   end
  # end

end


def stub_passwords_generation
  Client.any_instance.stub(:generate_password).and_return('123456')
  Dealer.any_instance.stub(:generate_password).and_return('123456')
end
