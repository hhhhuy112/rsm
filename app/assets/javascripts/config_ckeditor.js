$(document).ready(function(){
  if ($('textarea').length > 0) {
    var data = $('.ckeditor');
    $.each(data, function(i) {
      if (data[i].id != '' && $(this).hasClass('apply_information_introducing')) {
        CKEDITOR.replace(data[i].id)
      }
    });
  }
});
