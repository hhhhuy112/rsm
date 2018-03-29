$(document).ready(function () {
  $('#select-step').change(function() {
    var dataform = {
      step_id: $('#select-step').val()
    };
    $.ajax('/employers/status_steps', {
      type: 'GET',
      data: dataform,
      success: function(result) {
        if (result.error === undefined) {
          $('.form-search-applies').html(result.content);
          $('#select-step').val(result.step_current);
        } else {
          alertify.error(result.error);
        }
      },
      error: function (result) {
        alertify.error(I18n.t('employers.status_steps.transmission_error'));
      }
    });
  });

  check_job_choosen_ids();

  $(document).on('change', 'input[name="job_ids[]"]', function(){
    $('.no-job').remove();
    var id = $(this).val();
    if ($.inArray(id, $('#choosen-ids').val().split(',')) === -1) {
      $('.no-job').remove();
      var html_result = '<span class="tag" id="tag-' + id + '" data-id="' + id +
        '"><span>' + get_name_job(id) + '&nbsp;&nbsp;</span><a href="javascript:void(0)" title=' +
        I18n.t("employers.jobs.tag_job.remove_tag") +
        ' class= "remove-tag">&#10007;</a></span>';
      $('.tagsinput').append(html_result);
      $('#choosen-ids').val($('#choosen-ids').val() + ',' + id);
    } else {
      $('#tag-' + id).remove();
      $('#choosen-ids').val($('#choosen-ids').val().replace(',' + id, ''));
      check_job_choosen_ids();
    }
  });

  function check_job_choosen_ids() {
    if ($('#choosen-ids').val() === '') {
      no_job = '<span class="text-muted no-job"><small><em>' +
        I18n.t("no_job_choosen") + '</em></small></span>';
      $('.tagsinput').append(no_job);
    };
  };

  function get_name_job(id) {
    var name_job = $('#name-job-' + id).text().slice(0,50);
    if (name_job !== $('#name-job-' + id).text()) {
      name_job = name_job + '...'
    };
    return name_job
  };

  $(document).on('click', '.remove-tag', function(){
    var id = $(this).parent().attr('data-id');
    $('#choosen-ids').val($('#choosen-ids').val().replace(',' + id, ''));
    $(this).parent().remove();
    $('#job_ids_' + id).prop('checked', false);
    check_job_choosen_ids();
  })
});
