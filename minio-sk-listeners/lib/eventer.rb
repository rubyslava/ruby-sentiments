class Eventer < Struct.new(:user, :listener)
  def start
    listener.application_started
  end

  def attend(event)
    attendance = user.attend(event)
    listener.attendance_added(attendance)
  end
end
