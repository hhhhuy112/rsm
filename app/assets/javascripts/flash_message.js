$(document).ready(function() {
  $('#flash-message').delay(5000).slideUp(500, function() {
    $(this).remove();
  });
});
