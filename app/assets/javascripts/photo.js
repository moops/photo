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

      var formRow = document.createElement('div');
      formRow.className = "form-group row";
      formRow.id = `photo-row-${i}`;
      document.getElementById('upload-form').insertBefore(formRow, document.getElementById('upload-buttons'));
      console.log('created row: i', i, formRow, f);

      var files = evt.target.files;

      // Only process image files.
      if (!f.type.match('image.*')) {
        continue;
      }

      var reader = new FileReader();

      // Closure to capture the file information.
      reader.onload = (function(theFile, index) {
        return function(e) {
          console.log(index, theFile.name, `photo-row-${index}`);
          var foundFormRow = document.getElementById(`photo-row-${index}`);
          foundFormRow.innerHTML = [
              '<span class="col-sm-1"><img class="thumb" height="100" width="100" src="', e.target.result, '" title="', escape(theFile.name), '"/></span>',
              '<div class="col-sm-2"><input name="photo_names[]" type="text" value="', escape(theFile.name), '"/></div>',
              '<div class="col-sm-2"><input name="photo_artists[]" type="text" placeholder="artist"/></div>',
              '<div class="col-sm-2"><input name="photo_captions[]" type="text" placeholder="caption"/></div>',
              '<div class="col-sm-2"><input name="photo_includes[]" type="checkbox" checked value="', index, '"/></div>'].join('');
        };
      })(f, i);

      // Read in the image file as a data URL.
      reader.readAsDataURL(f);
    }

    document.getElementById('upload-buttons').classList.remove('invisible');
  }

  var photosInput = document.querySelector('#photos-file-input input[type="file"]');
  if (photosInput) {
    photosInput.addEventListener('change', handleFileDrop);
  }
});
