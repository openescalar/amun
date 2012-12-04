# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ($) ->
  playdeploy = () ->
    clicked = $(this)
    $.post '/deployments/deploy/',
      id: clicked.data("deploy")
    alert "Deployment " + clicked.data("dname") + " executed"

  playworkflow = () ->
    clicked = $(this)
    $.post '/deployments/deployworkflow/',
      id: clicked.data("deploy")
      wf: clicked.data("flow")
    alert "Workflow " + clicked.data("wname") + " executed"

  $('body').on 'click',
    'span#deploymentexec',
    playdeploy
  $('body').on 'click',
    'span#workflowexec',
    playworkflow
  false

