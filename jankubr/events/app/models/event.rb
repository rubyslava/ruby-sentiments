class Event < ActiveRecord::Base
  belongs_to :user
  has_many :event_attendees, dependent: :destroy
  has_many :event_dates, dependent: :destroy

  validates_presence_of :name, :starts_at
  validates_presence_of :date, if: ->(e) {e.day_of_week.blank?}
  validates_presence_of :day_of_week, if: ->(e) {e.date.blank?}
  after_save :generate_event_dates

private

  def generate_event_dates
    if day_of_week
      event_dates.future.delete_all
      now = Time.now
      first_date = current_date = get_closest_date
      while first_date + generate_days.days > current_date
        event_dates.create!(date: current_date)
        current_date += 1.week
      end
    else
      (event_dates.first || event_dates.new).update_attributes!(date: date)
    end
  end

  def generate_days
    90
  end

  def get_closest_date
    closest_date = Date.today
    while closest_date.wday != day_of_week
      closest_date += 1.day
    end
    closest_date
  end
end
