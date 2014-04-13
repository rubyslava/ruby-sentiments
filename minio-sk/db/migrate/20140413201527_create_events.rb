class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name, null: false
      t.text :description, null: false
      t.date :happening_on, null: false
      t.time :happening_from
      t.time :happening_to

      t.timestamps null: false
    end
  end
end
