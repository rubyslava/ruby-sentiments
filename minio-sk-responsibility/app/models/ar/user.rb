class Ar::User < ActiveRecord::Base
  self.table_name = :users

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :rememberable, :registerable, :validatable
         # :trackable, :validatable, :registerable, :recoverable
end
