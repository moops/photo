//= require jquery
//= require rails_ujs
//= require jquery-fileupload
//= require turbolinks
//= require bootstrap
//= require bootstrap-datepicker
//= require_tree .

$(document).ready(function() {
	// calendars
	$('#gallery_gallery_on').datepicker();
});

function remove_field(element, item) {
  element.up(item).remove();
}