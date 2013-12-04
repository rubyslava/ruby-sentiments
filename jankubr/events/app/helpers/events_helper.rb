module EventsHelper
  def attending_class(event)
    'class="attending_event"'.html_safe if event.user_attending?(current_user)
  end
end
