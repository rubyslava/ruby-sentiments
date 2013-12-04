class Event < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :name, :date, :starts_at
end
