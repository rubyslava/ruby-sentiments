gem 'minitest'
require 'minitest/autorun'
require './db'

class DbTest < Minitest::Test
  def setup
    @model = Event
    @model.storage.clear
  end

  def test_all
    assert_equal [], @model.all
    record = @model.new(1, Time.now, 'Fraktal', nil)
    @model.storage << record
    assert_equal [record], @model.all
  end

  def test_find
    record = @model.new(1, Time.now, 'Fraktal', nil)
    @model.storage << record
    assert_equal record, @model.find(1)
    assert_equal 1, @model.find(1).id
    assert_equal 'Fraktal', @model.find(1).place
  end

  def test_save
    @model.storage << @model.new(1, Time.now, 'Fraktal', nil)
    record = @model.find(1)
    assert_equal nil, record.rsvp
    record.rsvp = true
    assert_equal true, record.rsvp
    assert_equal true, @model.find(1).rsvp
  end
end
