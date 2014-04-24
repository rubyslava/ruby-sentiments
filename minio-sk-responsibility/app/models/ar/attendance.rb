class Ar::Attendance < ActiveRecord::Base
  self.table_name = :attendances

  belongs_to :user
  belongs_to :event
end
