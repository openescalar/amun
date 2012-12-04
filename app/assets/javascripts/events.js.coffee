# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ($) ->
  autorefreshevent = () ->
    uuid = $('span#autorefreshevent').data("uuid")
    setTimeout(autorefreshevent,5000)
    $.get '/events/getevent',
      ident: uuid
      (data) -> $("div#eventsbyident").html(data)

  startautorefresh = () ->
    autorefreshevent()
    
  $('body').on 'click',
    'span#autorefreshevent'
    startautorefresh
  false
      
