# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ($) ->
  updateazone = () ->
    change = $("option:selected",this).val()
    $.get '/images/update_zone_select/' + change,
      (data) -> $("div#zone_select").html(data)

  $('body').on 'change',
    'select#image_zone_id',
    updateazone
  false

