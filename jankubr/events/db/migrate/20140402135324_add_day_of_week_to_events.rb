class AddDayOfWeekToEvents < ActiveRecord::Migration
  def change
    add_column :events, :day_of_week, :integer
  end
end
