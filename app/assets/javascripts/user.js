$(document).ready(function() {
  $('.tab-custom-menu > .list-group > .list-group-item').click(function(e){
    e.preventDefault();
    $(this).siblings('a.active').removeClass('active');
    $(this).addClass('active');
    var index = $(this).index();
    $('.tab-custom-content > .tab-content').removeClass('active');
    $('.tab-custom-content > .tab-content').eq(index).addClass('active');
  });

  $(document).on('click', '.container-avatar .profile-label', function(){
    $('#bannerSelect').click();
  });

  $(document).on('change', '#user_cv', function(event){
    $('.contain-cv .thumbnail-cv').prop('href', URL.createObjectURL(event.target.files[0]));
    $('.contain-cv iframe').prop('src', URL.createObjectURL(event.target.files[0]));
  })

  $('.contain-cv iframe').fancybox({
    buttons: ['close'],
    transitionIn: 'elastic',
    transitionOut: 'elastic',
    speedIn: 400,
    speedOut: 400,
    type: 'iframe',
    iframe: {
      preload: false // fixes issue with iframe and IE
    },
    width: '100%',
    height: '100%',
    padding: 0
  });
});
