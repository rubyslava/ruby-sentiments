class AddAttendingUserIdsToEvents < ActiveRecord::Migration
  def change
    add_column :events, :attending_user_ids, :text
  end
end
