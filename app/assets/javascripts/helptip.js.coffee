jQuery ($) ->
  gethelptip = () ->
    helptip = $(this)
    $.get '/helptips/',
      obj: helptip.data("obj")
      (data) -> $("div#helptips").html(data)
  
  getpreview = () ->
    getpre = $(this)
    obj getpre.data("obj")
    objtype getpre.data("objtype")
    $.get '/' + objtype + '/' + obj,
      obj: obj
      objtype: objtype
      (data) -> $("div#objpreview").html(data)
  
#  $('body').on 'mouseover',
#    'span#gethelp',
#    gethelptip

#  $('body').on 'mouseover',
#    'span#objpreview'
#    getpreview
