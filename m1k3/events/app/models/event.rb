class Event < ActiveRecord::Base
  has_many :attendances
  has_many :attendees, through: :attendances, source: :user

  def attending?(user)
    attendees.include?(user)
  end
end
