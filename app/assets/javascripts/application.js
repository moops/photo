//= require rails-ujs
//= require jquery3
//= require popper
//= require bootstrap
//= require datepicker
//= require_tree .

$(document).ready(function() {
	// calendars
	$('#gallery_gallery_on').datepicker();

  // tooltips
  $('[data-toggle="tooltip"]').tooltip();
});

function remove_field(element, item) {
  element.up(item).remove();
}

// hide success messages after 4 seconds
window.setTimeout(function() {
    $('.alert-dismissible').fadeTo(500, 0).slideUp(500, function() {
        $(this).remove();
    });
}, 4000);