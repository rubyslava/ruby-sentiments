class Ar::Event < ActiveRecord::Base
  self.table_name = :events

  has_many :attendances
  has_many :attendees, through: :attendances, source: :user
end
