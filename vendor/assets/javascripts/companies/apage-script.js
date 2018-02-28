$(document).ready(function(){
  function initialize() {
    var map;
    var bounds = new google.maps.LatLngBounds();
    var mapOptions = {
        mapTypeId: 'roadmap'
    };

    // Display a map on the page
    map = new google.maps.Map(document.getElementById("map_canvas"), mapOptions);
    map.setTilt(45);

    // Multiple Markers
    var markers = [
      ['Ha Noi(Head office)', 21.0167,105.7842],
      ['Da Nang', 16.0544,108.2022],
      ['Ho Chi Minh city', 10.8231,106.6297],
      ['Singapore', 1.3521,103.8198],
      ['Dhaka', 23.8103,90.4125],
      ['Makati', 14.5547,121.0244],
      ['Tokyo', 35.6895,139.6917],
      ['Shimane', 35.4723,133.0505],
      ['Oita', 33.2382,131.6126]
    ];
    // Info Window Content
    var infoWindowContent = [
      ['<div class="info_content">' +
      '<h4>Framgia Vietnam</h4>' +
      '<h4>Ha Noi(Head office)</h4>' +
      '<i class="material-icons">room</i><p>13F Keangnam Landmark 72 Tower, Plot E6, Pham Hung Road, Nam Tu Liem Dist., Ha Noi</p>' +
      '<i class="material-icons">smartphone</i><p>84-4-3795-5417</p>' +
      '</div>'],
      ['<div class="info_content">' +
      '<h4>Framgia Vietnam</h4>' +
      '<h4>Da Nang</h4>' +
      '<i class="material-icons">room</i><p>6F, Vinh Trung Plaza, 255~257 Hung Vuong Str., Vinh Trung ward, Thanh Khe district, Da Nang</p>' +
      '</div>'],
      ['<div class="info_content">' +
      '<h4>Framgia Vietnam</h4>' +
      '<h4>Ho chi Minh City</h4>' +
      '<i class="material-icons">room</i><p>8F Nice building, 467 Dien Bien Phu Str., Ward 25, Binh Thanh district, HCMC</p>' +
      '</div>'],
      ['<div class="info_content">' +
      '<h4>Framgia Holdings Pte. Ltd. (Head office)</h4>' +
      '<i class="material-icons">room</i><p>8 Eu Tong Sen Street #14-94 The Central　Singapore 059818</p>' +
      '</div>'],
      ['<div class="info_content">' +
      '<h4>Framgia Bangladesh Ltd.</h4>' +
      '<i class="material-icons">room</i><p>Union Heights 01(8F)　55/2, West Pantha Path (Adjacent to Squire Hospital) Dhaka-1205</p>' +
      '</div>'],
      ['<div class="info_content">' +
      '<h4>Framgia Philippines CO.,LTD</h4>' +
      '<i class="material-icons">room</i><p>Room 302 3rd floor, Executive Building, Sen.Gil PuyatAve. cor.Makati Ave., Makati City</p>' +
      '</div>'],
      ['<div class="info_content">' +
      '<h4>Framgia Japan,Inc.</h4>' +
      '<i class="material-icons">room</i><p>Tokyo : Tokyo-to, Shibuya-ku, Shibuya, 3 Chome−6−1 , EAST Shibuya Bld 6F</p>' +
      '</div>'],
      ['<div class="info_content">' +
      '<h4>Framgia Japan,Inc.</h4>' +
      '<i class="material-icons">room</i><p>Shimane : Shimane-ken, Unnan-shi, Kakeya Kakeyacho 880</p>' +
      '</div>'],
      ['<div class="info_content">' +
      '<h4>Framgia Japan,Inc.</h4>' +
      '<i class="material-icons">room</i><p>Oita: Oita-ken, Beppu, Kamegawa Higashimachi 6-8 bits1</p>' +
      '</div>']
    ];
    // Display multiple markers on a map
    var infoWindow = new google.maps.InfoWindow(), marker, i;

    // Loop through our array of markers & place each one on the map
    for( i = 0; i < markers.length; i++ ) {
      var position = new google.maps.LatLng(markers[i][1], markers[i][2]);
      bounds.extend(position);
      marker = new google.maps.Marker({
        position: position,
        map: map,
        title: markers[i][0]
      });

      // Allow each marker to have an info window
      google.maps.event.addListener(marker, 'click', (function(marker, i) {
        return function() {
          infoWindow.setContent(infoWindowContent[i][0]);
          infoWindow.open(map, marker);
        }
      })(marker, i));
      // Automatically center the map fitting all markers on the screen
      map.fitBounds(bounds);
    }
    // Override our map zoom level once our fitBounds function runs (Make sure it only runs once)
    var boundsListener = google.maps.event.addListener((map), 'bounds_changed', function(event) {
      this.setZoom(4);
      google.maps.event.removeListener(boundsListener);
    });
  }
  // google map
  jQuery(".world-map").on("click", function(e) {
    e.preventDefault();
    if (!jQuery(this).attr("first")) {
      jQuery('.map-wrapper').fadeIn();
      jQuery('.map-bg').fadeIn();
      var script = document.createElement('script');
      script.src = "http://maps.googleapis.com/maps/api/js?sensor=false&callback=initialize";
      document.body.appendChild(script);
      jQuery(this).attr("first", "false");
    } else {
      jQuery('.map-wrapper').fadeIn();
      jQuery('.map-bg').fadeIn();
    }
  });

  jQuery(".map-close").on("click", function(e) {
    jQuery('.map-wrapper').fadeOut();
    jQuery('.map-bg').fadeOut();
  });

  jQuery(document).mouseup(function (e) {
    var container = jQuery(".map-wrapper");
    if (!container.is(e.target) // if the target of the click isn't the container...
      && container.has(e.target).length === 0) // ... nor a descendant of the container
    {
      container.fadeOut();
      jQuery('.map-bg').fadeOut();
    }
  });
  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
    (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
    m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
    })(window,document,'script','https://www.google-analytics.com/analytics.js','ga');

    ga('create', 'UA-46995268-2', 'auto');
    ga('send', 'pageview');

  var _wpcf7 = {"loaderUrl":"http:\/\/recruit.framgia.vn\/wp-content\/plugins\/contact-form-7\/images\/ajax-loader.gif","recaptchaEmpty":"Please verify that you are not a robot.","sending":"\u0110ang g\u1eedi ..."};

});
