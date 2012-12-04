# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ($) ->
  loadgraph = () ->
     d = new Date()
     graph = $(this)
     gtype = $(this).data()
     $("img#refreshable" + gtype.gtype ).attr("src", graph.attr("src") + "?" + d.getTime())
     $("img#refreshable" + gtype.gtype ).attr("data-isrc", graph.attr("src"))

  $('body').on 'click',
    'img#graph',
    loadgraph
  false

jQuery ($) ->
  autorefreshevent = () ->
    d = new Date()
    load = $("img#refreshableload").attr("data-isrc")
    mem = $("img#refreshablememory").attr("data-isrc")
    cpu = $("img#refreshablecpu-0").attr("data-isrc")
    setTimeout(autorefreshevent,10000)
    $("img#refreshableload").attr("src", load + "?" + d.getTime())
    $("img#refreshablememory").attr("src", mem + "?" + d.getTime())
    $("img#refreshablecpu-0").attr("src", cpu + "?" + d.getTime())
  
  startautorefresh = () ->
    autorefreshevent()

  $('body').on 'click',
    'span#autorefreshgraph'
    startautorefresh
  false  

jQuery ($) ->
  logrefreshevent = () ->
    ser = $("div#logios").data()
    $.get '/servers/' + ser.serial + '/getlog',
       (data) -> $("textarea#logiostext").val(data)
    setTimeout(logrefreshevent,10000)
    
  startlogrefresh = () ->
    logrefreshevent()
    

  $('body').on 'click',
    'span#logautorefresh'
    startlogrefresh
  false


