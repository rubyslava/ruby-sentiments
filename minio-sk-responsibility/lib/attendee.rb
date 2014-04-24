class Attendee
  include Virtus.model
  include Equalizer.new(:id)

  attribute :id, Integer
  attribute :email, String
end
