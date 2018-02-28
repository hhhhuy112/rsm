$(document).ready(function() {
  function check_question_choosen_ids(){
    if ($('#choosen-ids').val() === '') {
      no_question = '<span class="text-muted no-question"><small><em>' +
        I18n.t("no_question_choosen") + '</em></small></span>';
      $('.tagsinput').append(no_question);
    };
  };

  function get_name_question(id){
    var name_question = $('#question-content-' + id).text().slice(0,15);
    if (name_question !== $('#question-content-' + id).text()) {
      name_question = name_question + '...'
    };
    return name_question
  };

  $(document).on('change', 'input[name="job[question_ids][]"]', function(){
    $('.no-question').remove();
    var id = $(this).val();
    if ($.inArray(id, $('#choosen-ids').val().split(',')) === -1) {
      var html_result = '<span class="tag" id="tag-' + id + '" data-id="' + id +
        '"><span>' + get_name_question(id) + '&nbsp;&nbsp;</span><a href="#" title=' +
        I18n.t("employers.jobs.tag_question.remove_tag") +
        ' class= "remove-tag">&#10007;</a></span>';
      $('.tagsinput').append(html_result);
      $('#choosen-ids').val($('#choosen-ids').val() + ',' + id);
      $('#name-question-choosen').val($('#name-question-choosen').val() + ',' + get_name_question(id));
    } else {
      $('#tag-' + id).remove();
      $('#choosen-ids').val($('#choosen-ids').val().replace(',' + id, ''));
      $('#name-question-choosen').val($('#name-question-choosen').val().replace(',' + get_name_question(id), ''));
      check_question_choosen_ids();
    }
  });

  $(document).on('click', '.remove-tag', function(){
    var id = $(this).parent().attr('data-id');
    $('#choosen-ids').val($('#choosen-ids').val().replace(',' + id, ''));
    $('#name-question-choosen').val($('#name-question-choosen').val().replace(',' + get_name_question(id), ''));
    $(this).parent().remove();
    $('#job_question_ids_' + id).prop('checked', false);
    check_question_choosen_ids();
  })
});
