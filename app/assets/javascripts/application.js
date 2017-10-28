//= require rails-ujs
//= require jquery3
//= require popper
//= require bootstrap
//= require datepicker

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

document.addEventListener('click', function(event) {
  if (event.target && event.target.matches('#upload-photos-btn')) {
    event.preventDefault();
    // show the progress bars
    $('.progress-container').removeClass('d-none');

    // do the stuff
    upload();
    return false;
  }
});

var processProgress = function(galleryId, uploadFileCount) {
  var processProgressBar = $('#process-progress');
  var width = 0;
  var id = setInterval(foobar, 1000);
  function foobar() {
    $.ajax({
      url: '/galleries/' + galleryId + '/count',
      dataType: 'json',
      method: 'GET',
      // processData: false,
      // contentType: false,
      success: function(data) {
        console.log('process progress success', data);
        if (width == 100) {
          console.log('process progress done');
          $('#process-progress-label').html('done');
          clearInterval(id);
        } else {
          width = (data.count / uploadFileCount) * 100;
          console.log('process progress. data.count: ' + data.count + ', uploadFileCount: ' + uploadFileCount + ', width: ' + width);
          processProgressBar.css('width', width + '%');
        }
      },
      error: function(data, status, error) {
        console.log('process progress error, data: ' + data + 'status: ' + status + 'error: ' + error);
      }
    });
  }
}

function upload() {
  var form = $('#upload-form').get(0);
  var uploadProgressBar = $('#upload-progress');
  var formData = new FormData(form);
  var galleryId = $('input[name=gallery_id]').val();
  // start monitoring proccessing progress
  var uploadFileCount = $('#photos-file-input input').get(0).files.length;
  processProgress(galleryId, uploadFileCount);

  $.ajax({
    url: form.action,
    dataType: 'json',
    method: 'POST',
    data : formData,
    processData: false,
    contentType: false,
    xhr: function() {
      var xhr = new window.XMLHttpRequest();
      xhr.upload.addEventListener("progress", function(evt) {
        if (evt.lengthComputable) {
          var percentComplete = Math.round((evt.loaded / evt.total) * 100);
          //Do something with upload progress here
          console.log('uploading. percentComplete: ' + percentComplete);
          uploadProgressBar.css('width', percentComplete + '%');
          if (percentComplete == 100) {
            $('#upload-progress-label').html('uploaded');
          }
        }
     }, false);
     return xhr;
    },
    success: function(data) {
      console.log('upload progress success', data);
    },
    error: function(data, status, error) {
      console.log('upload progress error, data: ' + data + 'status: ' + status + 'error: ' + error);
    }
  });
}
