$(document).ready(function(){
  $('.seach-question').click(function() {
    var dataform = {
      name_question: $('#name_question').val()
    };
    var questions_choosen_ids = $('#choosen-ids').val().split(',');
    $.ajax('/employers/questions', {
      type: 'GET',
      data: dataform,
      success: function(result) {
        $('#table-question').html(result);
        $.each( questions_choosen_ids, function(index, value){
          $('#job_question_ids_' + value).prop('checked', true)
        });
      },
      error: function (result) {
        alertify.error(I18n.t('employers.status_steps.transmission_error'));
      }
    });
  });

  if ($('#choosen-ids').val() == '') {
    html_result = '<span class="text-muted no-question"><small><em>' +
      I18n.t("no_question_choosen") + '</em></small></span>';
    $('.tagsinput').append(html_result)
  };
});
