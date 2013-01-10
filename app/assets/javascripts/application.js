//= require jquery
//= require jquery_ujs
//= require jquery_ui
//= require jquery-fileupload
//= require bootstrap
//= require jdpicker
//= require jeditable
//= require_tree .

$(document).ready(function() { 
	
	//calendars
	$('#gallery_on').jdPicker();
	$('#gallery_gallery_on').jdPicker();
//	$('#new_photo').fileupload();
	
	//upload one or many photos
	function toggle_photo_form() {
		$('#one-photo').toggle('blind', {}, 500 );
		$('#bunch-photo').toggle('blind', {}, 500 );
	}

	$('#btn-one-photo').click(
		function(e) {
			if (!$('#btn-one-photo').hasClass('active')) {
				toggle_photo_form();
			}
		});
	$('#btn-bunch-photo').click(
		function(e) {
			if (!$('#btn-bunch-photo').hasClass('active')) {
				toggle_photo_form();
			}
		});
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

