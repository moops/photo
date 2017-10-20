//= require rails-ujs
//= require jquery3
//= require popper
//= require bootstrap
//= require datepicker
//= require_tree .

document.addEventListener("DOMContentLoaded", function(event) {
  // calendars
	$('#gallery-gallery-on').datepicker({ format: 'yyyy-mm-dd' });

  // focus
  field = document.querySelector('.focus');
  if (!!field) {
    field.focus();
  }

  // tooltips
  $('[data-toggle="tooltip"]').tooltip();
});

function remove_field(element, item) {
  element.up(item).remove();
}

// hide success messages after 3 seconds
window.setTimeout(function() {
    $('.alert-dismissible').fadeTo(500, 0).slideUp(500, function() {
        $(this).remove();
    });
}, 3000);

document.addEventListener('submit', function(event) {
  if (event.target) {
    console.log('submit happened!', event);
    upload_progress(17, document.getElementById('upload-progress'), 5);
  }
});

function upload_progress(galleryId, element, total) {
  console.log(`update progress with: ${total}`);
  //var total = 6;
  $.ajax({
    url: `/galleries/${galleryId}/count?foo=${total}`,
    dataType: 'json',
    success: function(data) {
      var percent = (data.count / total) * 100;
      console.log(`success, data ${data.count}`);
      element.style.width = percent;

      if (total < 10) {// (percent < 100) {
        console.log('do it again in 1s');
        window.setTimeout(upload_progress(galleryId, element, total + 1), 1000);
      }
    },
    error: function(data, status, error) {
      console.log(`error, count ${data} of ${total} status ${status} error ${error}`);
    },
    complete: function(request, status) {
      console.log('complete:', request, status);
    }
  });
}
