$(document).on('change', '.apply_select', function(event){
  var applyId = $(this).next().val();
  var value = $(this).val();
  if(value === "interview_scheduled"){
    event.preventDefault();
    $.get('/employers/applies/' +  applyId + '/edit');
  }else{
    this.form.commit.click();
  }
});

$(document).on('hidden.bs.modal', '.modal-apply', function () {
  var apply_id = $(this).data("id");
  $.get('/employers/applies/' +  apply_id);
})
