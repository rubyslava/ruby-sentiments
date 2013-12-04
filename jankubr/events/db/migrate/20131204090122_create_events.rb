class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.text :description
      t.date :date
      t.time :starts_at
      t.time :ends_at

      t.timestamps
    end
  end
end
