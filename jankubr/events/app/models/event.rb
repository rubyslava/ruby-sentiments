class Event < ActiveRecord::Base
  belongs_to :user

  serialize :attending_user_ids, Array

  validates_presence_of :name, :date, :starts_at

  def user_attending?(user)
    attending_user_ids.include?(user.id)
  end
end
