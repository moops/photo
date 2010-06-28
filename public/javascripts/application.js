// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults


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