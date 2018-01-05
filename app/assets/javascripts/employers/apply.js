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
<<<<<<< HEAD
<<<<<<< HEAD
=======
>>>>>>> fa774d8... fix status applies 1

$(document).on('hidden.bs.modal', '.modal-apply', function () {
  var apply_id = $(this).data("id");
  $.get('/employers/applies/' +  apply_id);
})
<<<<<<< HEAD
=======
>>>>>>> bbf4e01... fix status apply
=======
>>>>>>> fa774d8... fix status applies 1
