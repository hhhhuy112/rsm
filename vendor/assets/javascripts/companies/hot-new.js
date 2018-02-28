jQuery(document).ready(function($){
  $('.hot-news').owlCarousel({
    stagePadding: 50,
      singleItem: false,
      items: 3,
      itemsDesktop: [1400,3],
      itemsTablet: [799,3],
      itemsTabletSmall: [768,2],
      itemsMobile: [480,1],
    margin: 30,
      pagination: true,
      navigation: false,
      navigationText: false,
      autoPlay: false,
      slideSpeed: 100,
      paginationSpeed: 400
  });
});
