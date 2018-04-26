$(document).ready(function() {
  $('.tab-custom-menu > .list-group > .list-group-item').click(function(e){
    e.preventDefault();
    $(this).siblings('a.active').removeClass('active');
    $(this).addClass('active');
    var index = $(this).index();
    $('.tab-custom-content > .tab-content').removeClass('active');
    $('.tab-custom-content > .tab-content').eq(index).addClass('active');
  });

  $(document).on('change', '#user_cv', function(event){
    if ($('.view-cv').hasClass('not-active')) {
      $('.view-cv').removeClass('not-active');
    }
    $('.view-cv').prop('href', URL.createObjectURL(event.target.files[0]));
  })

  $(document).on('click', '.form-update-user .profile-label', function(){
    $('#bannerSelect').click();
  });
});
