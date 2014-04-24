class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.text :description
      t.date :scheduled_on
      t.time :beginning_at
      t.time :ending_at

      t.timestamps
    end
  end
end
