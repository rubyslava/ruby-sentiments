class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.text :description
      t.date :date
      t.time :from_time
      t.time :to_time

      t.timestamps
    end
  end
end
