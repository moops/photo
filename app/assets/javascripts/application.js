//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require jdpicker
//= require_tree .

jQuery(document).ready(function() { 
	$('#gallery_on').jdPicker();
});


function remove_field(element, item) {
  element.up(item).remove();
}

function showAddPhotos(id) {
	var el = $(id);
	if (!el.visible()) {
		Effect.BlindDown(id, { duration: 0.5 });
	}
}

function toggle_photo_form() {
	var one = $('one_photo');
	var bunch = $('bunch_photo');
	if (one.visible()) {
		Effect.BlindDown('bunch_photo', { duration: 0.5 });
		Effect.BlindUp('one_photo', { duration: 0.5 });
	} else {
		Effect.BlindDown('one_photo', { duration: 0.5 });
		Effect.BlindUp('bunch_photo', { duration: 0.5 });
  }
}