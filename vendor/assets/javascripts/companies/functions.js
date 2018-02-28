/* global screenReaderText */
/**
 * Theme functions file.
 *
 * Contains handlers for navigation and widget area.
 */
var screenReaderText = {"expand":"expand child menu","collapse":"collapse child menu"};
( function( $ ) {
  var body, masthead, menuToggle, siteNavigation, socialNavigation, siteHeaderMenu, resizeTimer;

  function initMainNavigation( container ) {

      // Add dropdown toggle that displays child menu items.
    var dropdownToggle = $( '<button />', {
      'class': 'dropdown-toggle',
      'aria-expanded': false
    } ).append( $( '<span />', {
      'class': 'screen-reader-text',
      text: screenReaderText.expand
    } ) );

    container.find( '.menu-item-has-children > a' ).after( dropdownToggle );

    // Toggle buttons and submenu items with active children menu items.
    container.find( '.current-menu-ancestor > button' ).addClass( 'toggled-on' );
    container.find( '.current-menu-ancestor > .sub-menu' ).addClass( 'toggled-on' );

    // Add menu items with submenus to aria-haspopup="true".
    container.find( '.menu-item-has-children' ).attr( 'aria-haspopup', 'true' );

    container.find( '.dropdown-toggle' ).click( function( e ) {
      var _this = $( this ),
        screenReaderSpan = _this.find( '.screen-reader-text' );

      e.preventDefault();
      _this.toggleClass( 'toggled-on' );
      _this.next( '.children, .sub-menu' ).toggleClass( 'toggled-on' );

      // jscs:disable
      _this.attr( 'aria-expanded', _this.attr( 'aria-expanded' ) === 'false' ? 'true' : 'false' );
      // jscs:enable
      screenReaderSpan.text( screenReaderSpan.text() === screenReaderText.expand ? screenReaderText.collapse : screenReaderText.expand );
    } );
  }
  initMainNavigation( $( '.main-navigation' ) );

  masthead = $( '#masthead' );
  menuToggle = masthead.find( '#menu-toggle' );
  siteHeaderMenu = masthead.find( '#site-header-menu' );
  siteNavigation = masthead.find( '#site-navigation' );
  socialNavigation = masthead.find( '#social-navigation' );

  // Enable menuToggle.
  ( function() {

    // Return early if menuToggle is missing.
    if ( ! menuToggle.length ) {
      return;
    }

    // Add an initial values for the attribute.
    menuToggle.add( siteNavigation ).add( socialNavigation ).attr( 'aria-expanded', 'false' );

    menuToggle.on( 'click.twentysixteen', function() {
      $( this ).add( siteHeaderMenu ).toggleClass( 'toggled-on' );

      $( this ).add( siteNavigation ).add( socialNavigation ).attr( 'aria-expanded', $( this ).add( siteNavigation ).add( socialNavigation ).attr( 'aria-expanded' ) === 'false' ? 'true' : 'false' );
    } );
  } )();

    // Fix sub-menus for touch devices and better focus for hidden submenu items for accessibility.
    ( function() {
      if ( ! siteNavigation.length || ! siteNavigation.children().length ) {
        return;
      }

      // Toggle `focus` class to allow submenu access on tablets.
      function toggleFocusClassTouchScreen() {
        if ( window.innerWidth >= 910 ) {
          $( document.body ).on( 'touchstart.twentysixteen', function( e ) {
            if ( ! $( e.target ).closest( '.main-navigation li' ).length ) {
              $( '.main-navigation li' ).removeClass( 'focus' );
            }
          } );
          siteNavigation.find( '.menu-item-has-children > a' ).on( 'touchstart.twentysixteen', function( e ) {
            var el = $( this ).parent( 'li' );

            if ( ! el.hasClass( 'focus' ) ) {
              e.preventDefault();
              el.toggleClass( 'focus' );
              el.siblings( '.focus' ).removeClass( 'focus' );
            }
          } );
        } else {
          siteNavigation.find( '.menu-item-has-children > a' ).unbind( 'touchstart.twentysixteen' );
        }
      }

      if ( 'ontouchstart' in window ) {
        $( window ).on( 'resize.twentysixteen', toggleFocusClassTouchScreen );
        toggleFocusClassTouchScreen();
      }

      siteNavigation.find( 'a' ).on( 'focus.twentysixteen blur.twentysixteen', function() {
        $( this ).parents( '.menu-item' ).toggleClass( 'focus' );
      } );
  } )();

    // Add the default ARIA attributes for the menu toggle and the navigations.
  function onResizeARIA() {
      if ( window.innerWidth < 910 ) {
        if ( menuToggle.hasClass( 'toggled-on' ) ) {
          menuToggle.attr( 'aria-expanded', 'true' );
        } else {
          menuToggle.attr( 'aria-expanded', 'false' );
        }

        if ( siteHeaderMenu.hasClass( 'toggled-on' ) ) {
          siteNavigation.attr( 'aria-expanded', 'true' );
          socialNavigation.attr( 'aria-expanded', 'true' );
        } else {
          siteNavigation.attr( 'aria-expanded', 'false' );
          socialNavigation.attr( 'aria-expanded', 'false' );
        }

        menuToggle.attr( 'aria-controls', 'site-navigation social-navigation' );
      } else {
        menuToggle.removeAttr( 'aria-expanded' );
        siteNavigation.removeAttr( 'aria-expanded' );
        socialNavigation.removeAttr( 'aria-expanded' );
        menuToggle.removeAttr( 'aria-controls' );
      }
  }

    // Add 'below-entry-meta' class to elements.
  function belowEntryMetaClass( param ) {
    if ( body.hasClass( 'page' ) || body.hasClass( 'search' ) || body.hasClass( 'single-attachment' ) || body.hasClass( 'error404' ) ) {
      return;
    }

    $( '.entry-content' ).find( param ).each( function() {
      var element = $( this ),
        elementPos = element.offset(),
        elementPosTop = elementPos.top,
        entryFooter = element.closest( 'article' ).find( '.entry-footer' ),
        entryFooterPos = entryFooter.offset(),
        entryFooterPosBottom = entryFooterPos.top + ( entryFooter.height() + 28 ),
        caption = element.closest( 'figure' ),
        newImg;

        // Add 'below-entry-meta' to elements below the entry meta.
      if ( elementPosTop > entryFooterPosBottom ) {

          // Check if full-size images and captions are larger than or equal to 840px.
        if ( 'img.size-full' === param ) {

          // Create an image to find native image width of resized images (i.e. max-width: 100%).
          newImg = new Image();
          newImg.src = element.attr( 'src' );

          $( newImg ).on( 'load.twentysixteen', function() {
            if ( newImg.width >= 840  ) {
              element.addClass( 'below-entry-meta' );

              if ( caption.hasClass( 'wp-caption' ) ) {
                caption.addClass( 'below-entry-meta' );
                caption.removeAttr( 'style' );
              }
            }
          } );
        } else {
          element.addClass( 'below-entry-meta' );
        }
      } else {
        element.removeClass( 'below-entry-meta' );
        caption.removeClass( 'below-entry-meta' );
      }
    } );
  }

  $( document ).ready( function() {
    body = $( document.body );

    $( window )
      .on( 'load.twentysixteen', onResizeARIA )
      .on( 'resize.twentysixteen', function() {
        clearTimeout( resizeTimer );
        resizeTimer = setTimeout( function() {
          belowEntryMetaClass( 'img.size-full' );
          belowEntryMetaClass( 'blockquote.alignleft, blockquote.alignright' );
        }, 300 );
        onResizeARIA();
    } );

    belowEntryMetaClass( 'img.size-full' );
    belowEntryMetaClass( 'blockquote.alignleft, blockquote.alignright' );

      // framgia javascript
    var fvn = function(){};

    fvn.prototype.init = function() {
      this.owlClient = jQuery(".owl-client");
      this.owlTeam = jQuery(".owl-team");
      this.bindEvents();
    };

    fvn.prototype.bindEvents = function() {
      this.bindCarousel();
    };

    fvn.prototype.bindCarousel = function() {
      var self = this;

        // owl carousle Client
      self.owlClient.each(function() {
        jQuery(this).owlCarousel({
          singleItem: false,
          items: 6,
          itemsDesktop: [1400,6],
          itemsTablet: [799,4],
          itemsTabletSmall: [768,3],
          itemsMobile: [480,2],
          pagination: true,
          navigation: false,
          navigationText: false,
          autoPlay: true,
          slideSpeed: 100,
          paginationSpeed: 400
        });
      });

        // owl carousle Team
      self.owlTeam.each(function() {
        jQuery(this).owlCarousel({
          singleItem: false,
          items: 3,
          itemsDesktop: [1400,3],
          itemsTablet: [799,3],
          itemsTabletSmall: [768,3],
          itemsMobile: [480,1],
          pagination: false,
          navigation: false,
          navigationText: false,
          autoPlay: true,
          slideSpeed: 100,
          paginationSpeed: 400
        });
      });

    };

    var appObj = new fvn();
    appObj.init();

    $(function() {
      $('a[href*="#"]:not([href="#"])').click(function() {
        if (location.pathname.replace(/^\//,'') == this.pathname.replace(/^\//,'') && location.hostname == this.hostname) {
          var target = $(this.hash);
          target = target.length ? target : $('[name=' + this.hash.slice(1) +']');
          if (target.length) {
            $('html, body').animate({
              scrollTop: target.offset().top
            }, 1000);
            return false;
          }
        }
      });
    });

      // change header style on scroll
    if (jQuery("body").hasClass("home")) {
      var wrap = jQuery(window);
      var header = jQuery('#header');
      wrap.on("scroll", function() {
        var scrolled = jQuery(window).scrollTop();
        if (scrolled > 1) {
          header.addClass("white");
        } else {
          header.removeClass("white");
        }
      });
    }

    $(".language").select2({
      minimumResultsForSearch: Infinity
    });

    $(".inactive a").on("click", function(e) {
      e.preventDefault();
    });

      // counterup
    $('.section-statistic .number').counterUp({
      delay: 100, // the delay time in ms
      time: 1500 // the speed time in ms
    });

      // mobile menu
    jQuery('body').on('click', '.menu-open', function () {
      jQuery(".header-right .menu").fadeIn().addClass("is-mobile-menu");
      jQuery(this).fadeOut();
      jQuery('.menu-close').fadeIn();
      jQuery("#header").toggleClass("mobile");
    });
    jQuery('body').on('click', '.menu-close', function () {
      jQuery(".header-right .menu").css("display","none   ").removeClass("is-mobile-menu");
      jQuery(this).fadeOut();
      jQuery('.menu-open').fadeIn();
      jQuery("#header").toggleClass("mobile");
    });
  });

  window.onload = function() {
    // this will fire after the entire page is loaded, including images
    // match height
    var maxHeight = -1;
    var item = jQuery(".section-activity").find(".item");
    item.each(function() {
      maxHeight = maxHeight > jQuery(this).outerHeight() ? maxHeight : jQuery(this).outerHeight();
    });
    item.each(function() {
      jQuery(this).outerHeight(maxHeight);
    });

    $("#lang_sel").clone().appendTo(".menu");
  };

} )( jQuery );
