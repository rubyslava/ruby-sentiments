class Event < ActiveRecord::Base
  has_many :attendances, autosave: true
  has_many :attending_users, through: :attendances, source: :user

  def attended_by?(user)
    attending_users.include?(user)
  end
end
