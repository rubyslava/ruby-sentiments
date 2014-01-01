class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :lockable
  before_create :set_role

  def admin?
   role == 'admin'
  end

private
  def set_role
    self.role = 'user'
  end
end
