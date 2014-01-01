class Event < ActiveRecord::Base
  validates :name, :date, presence: true
end
