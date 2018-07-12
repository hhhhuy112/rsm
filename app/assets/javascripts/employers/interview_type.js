$(document).ready(function() {
  $(document).on('click', '.remove', function(){
    $(this).parent().parent().parent().parent().parent().parent().remove()
  })
})
