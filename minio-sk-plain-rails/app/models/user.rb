class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable

  has_many :attendances
  has_many :attending_events, through: :attendances, source: :event

  def attend(event)
    attendances.build(user: self, event: event)
  end

  def signed_in?
    true
  end
end
