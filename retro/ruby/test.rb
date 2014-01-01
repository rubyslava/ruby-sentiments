require 'rack/test'
gem 'minitest'
require 'minitest/autorun'

class DatingTest < Minitest::Test
  include Rack::Test::Methods

  def app
    Dating
  end

  def setup
    DB << Event.new(1, Time.now, 'Fraktal', nil)
  end

  def test_index
    get '/'
    assert last_response.body.include?('Fraktal')
    assert last_response.body.include?('nothing')
    assert last_response.ok?
  end

  def test_create
    post '/attend/1/1'
    follow_redirect!
    assert last_response.body.include?('true')
    assert Event.find(1).rsvp
    assert_equal "http://example.org/", last_request.url
  end
end

