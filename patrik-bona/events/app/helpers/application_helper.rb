module ApplicationHelper
  def time(time)
    time.strftime('%H:%M') if time
  end
end
