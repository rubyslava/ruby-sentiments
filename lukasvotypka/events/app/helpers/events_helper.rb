module EventsHelper
  def event_active?(event)
    return false if current_user.nil?

    if @participant_hash.nil?
      @participant_hash = {}
      @participants.each do |participant|
        @participant_hash[participant.event_id] = true
      end
    end

    @participant_hash[event.id]
  end

  def cache_key_event_user(event, user)
    return "" if user.nil? || event.nil?
    "#{event.cache_key}-user-#{user.id}"
  end
end
