//= require jquery
//= require jquery_ujs
//= require jquery_ui
//= require jquery-fileupload
//= require bootstrap
//= require galleriffic
//= require opacityrollover
//= require bootstrap-datepicker
//= require_tree .

$(document).ready(function() { 
	// calendars
	$('#gallery_gallery_on').datepicker();
});

function remove_field(element, item) {
  element.up(item).remove();
}