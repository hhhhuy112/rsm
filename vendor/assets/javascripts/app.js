var App = function() {
  var uiInit = function() {
    handleHeader();
    handleMenu();
    scrollToTop();
    var yearCopy = $('#year-copy'), d = new Date();
    if (d.getFullYear() === 2014) { yearCopy.html('2014'); } else { yearCopy.html('2014-' + d.getFullYear().toString().substr(2,2)); }

    $('[data-toggle="tabs"] a, .enable-tabs a').click(function(e){ e.preventDefault(); $(this).tab('show'); });

    $('[data-toggle="tooltip"], .enable-tooltip').tooltip({container: 'body', animation: false});

    $('[data-toggle="popover"], .enable-popover').popover({container: 'body', animation: true});

    $('[data-toggle="lightbox-image"]').magnificPopup({type: 'image', image: {titleSrc: 'title'}});

    $('[data-toggle="lightbox-gallery"]').magnificPopup({
      delegate: 'a.gallery-link',
      type: 'image',
      gallery: {
        enabled: true,
        navigateByImgClick: true,
        arrowMarkup: '<button type="button" class="mfp-arrow mfp-arrow-%dir%" title="%title%"></button>',
        tPrev: 'Previous',
        tNext: 'Next',
        tCounter: '<span class="mfp-counter">%curr% of %total%</span>'
      },
      image: {titleSrc: 'title'}
    });

    $('input, textarea').placeholder();
    $('[data-toggle="animation-appear"]').each(function(){
      var $this       = $(this);
      var $animClass  = $this.data('animation-class');
      var $elemOff    = $this.data('element-offset');

      $this.appear(function() {
        $this.removeClass('visibility-none').addClass($animClass);
      },{accY: $elemOff});
    });
    $('[data-toggle="countTo"]').each(function(){
      var $this = $(this);
      $this.appear(function() {
        $this.countTo({
          speed: 1500,
          refreshInterval: 20,
          onComplete: function() {
            if($this.data('after')) {
                $this.html($this.html() + $this.data('after'));
            }
          }
        });
      });
    });
    $('.store-menu .submenu').on('click', function(){
      $(this)
        .parent('li')
        .toggleClass('open');
    });
  };
  var handleHeader = function(){
    var header = $('#header');
    $(window).scroll(function() {
      if ($(this).scrollTop() > header.outerHeight()) {
        header.removeClass('header-job').addClass('white')
      } else {
        header.removeClass('white').addClass('header-job');
      }
    });
  };
  var handleMenu = function(){
    var sideNav = $('.site-nav');
    $('.site-menu-toggle').on('click', function(){
      sideNav.toggleClass('site-nav-visible');
    });

    sideNav.on('mouseleave', function(){
      $(this).removeClass('site-nav-visible');
    });
  };

  var scrollToTop = function() {
    var link = $('#to-top');
    var windowW = window.innerWidth
      || document.documentElement.clientWidth
      || document.body.clientWidth;

    $(window).scroll(function() {
      if (($(this).scrollTop() > 150) && (windowW > 991)) {
        link.fadeIn(100);
      } else {
        link.fadeOut(100);
      }
    });

    link.click(function() {
      $('html, body').animate({scrollTop: 0}, 500);
      return false;
    });
  };
  return {
    init: function() {
      uiInit();
    }
  };
}();
$(function(){ App.init(); });
$( document ).ready( function() {
  $('body').on('click', '.menu-open', function () {
    $('.header-right .menu').fadeIn().addClass('is-mobile-menu');
    $(this).hide();
    $('.menu-close').fadeIn();
  });
  $('body').on('click', '.menu-close', function () {
    $('.header-right .menu').css('display','none').removeClass('is-mobile-menu');
    $(this).hide();
    $('.menu-open').fadeIn();
  });
});
