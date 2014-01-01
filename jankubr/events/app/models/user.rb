class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :lockable
  has_many :event_attendees, dependent: :destroy
  has_many :events, through: :event_attendees

  before_create :set_role

  def admin?
   role == 'admin'
  end

private
  def set_role
    self.role = 'user'
  end
end
