$(document).ready(function(){
  $(document).on('change','#interview_type', function(){
    var interview_type_id = $(this).val();
    var apply_id = $('#apply').val();
    $.ajax({
      type: 'GET',
      url: '/employers/applies/' + apply_id + '/evaluations/new.js',
      data: {
        interview_type_id : interview_type_id,
      }
    });
  })
})
