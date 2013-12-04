//= require vendor/_jquery-2.x.js
//= require vendor/_jquery.storageapi.js

sign_meeting = (link) ->
  link.parents("div.meeting").css "background-color", "yellow"
  $(link).hide()
storage = $.localStorage
$ ->
  signed = storage.get("signed")
  if signed?
    sign_meeting $("a[data-id='" + value + "']") for value in signed

  $("a.signup").bind "click", ->
    id = $(this).attr("data-id")
    title = $(this).siblings("div.head").children("h2").html()
    already_signed = storage.get("signed")
    already_signed = []  unless already_signed?
    already_signed = already_signed.concat(id)
    storage.set "signed", already_signed
    alert "Výborně jste přihlášení na sraz s titulem" + title
    sign_meeting $(this)
