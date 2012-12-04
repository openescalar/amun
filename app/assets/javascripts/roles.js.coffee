# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
  hide_role_tasks = () ->
    $('tr#tasks').hide()
  show_role_tasks = () ->
    $('tr#tasks').show()
  hide_role_tasks_all = () ->
    $('tr#tasks').hide()
  
#  $ -> hide_role_tasks_all()
  $('span#showtasks').click -> hide_role_tasks()

