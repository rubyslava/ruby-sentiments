$(document).on "ready page:load", ->
  $(".event").on "show.bs.collapse", ->
    $(this).addClass("open")

  $(".event").on "hide.bs.collapse", ->
    $(this).removeClass("open")

  # handling events

  signUpEvent = (id) ->
    $("#event_#{id}").addClass("signed-up")

  markSignedUpEvents = (events) ->
    for event in events then do (event) =>
      signUpEvent(event)

  getSignedUpEvents = ->
    JSON.parse(localStorage.getItem("signed-up-events")) || []

  markSignedUpEvents(getSignedUpEvents())

  $(".event .event-sign-up").on "click", (e) ->
    event = $(this).data("event-id")
    events = getSignedUpEvents()

    if $.inArray(event, events) is -1
      events.push(event)
      localStorage.setItem('signed-up-events', JSON.stringify(events))
      signUpEvent(event)

    e.preventDefault()