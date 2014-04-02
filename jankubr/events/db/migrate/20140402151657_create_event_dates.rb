class CreateEventDates < ActiveRecord::Migration
  def change
    create_table :event_dates do |t|
      t.integer :event_id
      t.date :date

      t.timestamps
    end
    add_index :event_dates, :event_id

    add_column :event_attendees, :event_date_id, :integer
    add_index :event_attendees, :event_date_id

    # Event.all.each do |e|
    #   event_date = EventDate.create!(event_id: e.id, date: e.date)
    #   e.event_attendees.update_all(event_date_id: event_date.id)
    # end
  end
end
