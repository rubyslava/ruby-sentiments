class Event < ActiveRecord::Base
  has_many :participants
  has_and_belongs_to_many :users, uniq: true, join_table: 'participants'

  validates_presence_of :title
  validates_presence_of :text_description
  validates_presence_of :start_time

  def toggle_participation(user)
    raise ArgumentError.new("User can not be nil") if user.nil?

    rel = participants.where(user_id: user.id).first
    if rel.nil?
      users << user
      return true
    else
      rel.destroy
      return false
    end
  end
end
