if (window.File && window.FileReader && window.FileList && window.Blob) {

} else {
  alert('The File APIs are not fully supported in this browser.');
}

$(document).ready(function() {

  function handleFileDrop(evt) {
    evt.stopPropagation();
    evt.preventDefault();

    var files = evt.target.files;

    // files is a FileList of File objects. List some properties.
    for (var i = 0, f; f = files[i]; i++) {

      var photoCell = document.createElement('span');
      photoCell.className = "card mt-2 mr-2";
      photoCell.id = 'photo-cell-' + i;
      document.getElementById('photos-row').appendChild(photoCell);

      var files = evt.target.files;

      // Only process image files.
      if (!f.type.match('image.*')) {
        continue;
      }

      var reader = new FileReader();

      // Closure to capture the file information.
      reader.onload = (function(theFile, index) {
        return function(e) {
          var foundPhotoCell = document.getElementById('photo-cell-' + index);
          foundPhotoCell.innerHTML = [
              '  <span class="card-body">',
              '    <div class="upload-overlay align-middle text-center d-none">uploaded</div>',
              '    <div class="row">',
              '      <div class="col-5 px-1">',
              '        <img height="120" width="120" src="', e.target.result, '" title="', escape(theFile.name), '"/>',
              '      </div>',
              '      <div class="col-7 px-1">',
              '        <input name="photo_names[]" type="text" size="16" value="', escape(theFile.name), '" class="form-control"/>',
              '        <input name="photo_artists[]" type="text" size="16" placeholder="artist" class="form-control my-2"/>',
              '        <input name="photo_captions[]" type="text" size="16" placeholder="caption" class="form-control my-2"/>',
              '        <input name="photo_includes[]" type="checkbox" checked value="', index, '" class="form-control"/>',
              '      </div>',
              '    </div>',
              '  </span>'].join('');
        };
      })(f, i);

      // Read in the image file as a data URL.
      reader.readAsDataURL(f);
    }

    document.getElementById('upload-buttons').classList.remove('invisible');
  }

  var photosInput = document.querySelector('#photos-file-input input[type="file"]');
  if (!!photosInput) {
    console.log('found a photo drop zone');
    photosInput.addEventListener('change', handleFileDrop);
  } else {
    console.log('NO photo drop zone found');
  }
});
