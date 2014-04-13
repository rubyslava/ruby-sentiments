class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.text :text_description
      t.datetime :start_time
      t.datetime :end_time

      t.timestamps
    end
    add_index :events, :start_time
    add_index :events, :end_time
  end
end
