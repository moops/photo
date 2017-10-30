$(document).ready(function() {
  $('.exif-link').click(function(e) {
    var photoId = parseInt($(this).attr('href').match(/\d/)[0]);
    gtag('event', 'view', { 'event_category': 'engagement', 'event_label': 'exif', 'value': photoId });
  });
  $('.comments-link').click(function(e) {
    var photoId = parseInt($(this).attr('href').match(/\d/)[0]);
    gtag('event', 'view', { 'event_category': 'engagement', 'event_label': 'comments', 'value': photoId });
  });
  $('.search-form').submit(function(e) {
    var searchTerm = $('#q').val();
    gtag('event', 'search', { 'event_category': 'engagement', 'event_label': 'gallery', 'value': searchTerm });
  });
});
