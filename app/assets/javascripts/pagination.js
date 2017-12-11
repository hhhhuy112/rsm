$(document).on('click', '.show_jobs .pagination a', function (event) {
  event.preventDefault();
  $.getScript($(this).attr('href'));
  return false;
});

$(document).on('click', '.show_bookmark  #pag_bookmark .pagination a', function (event) {
  event.preventDefault();
  $.getScript($(this).attr('href'));
  return false;
});
