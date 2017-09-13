//= require rails-ujs
//= require jquery3
//= require popper
//= require bootstrap
//= require datepicker
//= require dropzone
//= require_tree .

$(document).ready(function() {
	// calendars
	$('#gallery_gallery_on').datepicker();
});

function remove_field(element, item) {
  element.up(item).remove();
}