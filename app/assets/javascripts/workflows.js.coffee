# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ($) ->
  removeme = () ->
    clicked = $(this)
    $.post '/workflows/deltask/',
      id: clicked.data("wid")
      task: clicked.data("rtask")
      (data) -> $("div#workflowtasks").html(data)

  $('body').on 'click',
    'span#removetask',
    removeme
  false

