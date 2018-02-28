$('.choose-cv').change(function(){
  $('#choose-cv').val($('.choose-cv').val().split('\\').pop());
});
