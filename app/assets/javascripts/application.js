// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require highstock.js
//= require exporting.js
//= require_tree .

jQuery(function($) {
 //When #byzone changes
 $("#server_zone_id").change(function() {
   var zone = $('select#server_zone_id :selected').val();
   if (zone == "" ) zone = "0";
   jQuery.get('/servers/update_zone_select/' + zone, function(data){ $("#zone_select").html(data);
   })
   return false;
 });
// $("#volume_zone_id").change(function() {
//   var zone = $('select#volume_zone_id :selected').val();
//   if (zone == "" ) zone = "0";
//   jQuery.get('/volumes/update_zone_select/' + zone, function(data){ $("#zone_select").html(data);
//   })
//   return false;
// });
 $("#account_id").change(function() {
  var account = $('select#account_id :selected').val();
  jQuery.get('/users/achange/' + account, function(data){location.reload();})
  return false;
 });
 $("#role_task").change(function() {
   var task = $('select#role_task :selected').val();
   var flow = $('input#id').val();
   if (task != "" ) {
     jQuery.post('/workflows/addtask/', { id: flow, task: task }, function(data){ $("div#workflowtasks").html(data); } );
   }
   return false;
 });

})

