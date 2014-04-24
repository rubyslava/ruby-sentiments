module ApplicationHelper
  def current_user
    super || Guest.new
  end
end
