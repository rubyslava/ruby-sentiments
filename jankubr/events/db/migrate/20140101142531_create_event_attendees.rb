class CreateEventAttendees < ActiveRecord::Migration
  def change
    create_table :event_attendees do |t|
      t.integer :event_id
      t.integer :user_id

      t.timestamps
    end
    add_index :event_attendees, :event_id
    add_index :event_attendees, :user_id

    Event.find_each do |event|
      YAML.load(event.attending_user_ids).each do |user_id|
        EventAttendee.create!(event_id: event.id, user_id: user_id)
      end
    end

    remove_column :events, :attending_user_ids
  end
end
