class CreateArEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.text :name, null: false
      t.text :description, null: false
      t.date :date, null: false
      t.time :from
      t.time :to

      t.timestamps null: false
    end
  end
end
