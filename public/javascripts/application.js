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