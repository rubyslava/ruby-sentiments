module ApplicationHelper
  def short_datetime(datetime)
    if datetime
      l(datetime, format: :short)
    else
      'n/a'
    end
  end
end
