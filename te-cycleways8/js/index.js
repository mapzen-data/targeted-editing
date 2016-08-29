var map = L.map('map', {"keyboardZoomOffset" : .05, "scrollWheelZoom": false });
var picking = false;

// usually we refer to key alone to make use of keymaster but
// the key global conflicts with something in the Leaflet namespace, so enable special mode
var key_nc = key.noConflict();

var hashControl = new HashControl();

if (hasWebGL()) {
  // use Tangram to draw tiles when there is WebGL available on the browser
  var layer = Tangram.leafletLayer({
    //scene: 'https://cdn.rawgit.com/mapzen-data/te-bike-lrm-mapzen/gh-pages/map/te-bike-map.yaml',
    scene: 'https://raw.githubusercontent.com/mapzen-data/te-bike-lrm-mapzen/gh-pages/map/te-bike-map.yaml',
    attribution: '<a href="https://mapzen.com/tangram" target="_blank">Tangram</a> | &copy; OSM contributors | <a href="https://mapzen.com/" target="_blank">Mapzen</a>'
  });

  window.layer = layer;
  var scene = layer.scene;
  window.scene = scene;
  var latlng = {};
  var popup = document.getElementById('popup'); // click-popup

  function killPopup() {
    picking = false;
    popup.style.visibility = 'hidden';
  }

  // Feature selection
  function initFeatureSelection () {
    map.getContainer().addEventListener('mousemove', function (event) {
      picking = true;
      latlng = map.mouseEventToLatLng(event);

      var pixel = { x: event.clientX, y: event.clientY };

      scene.getFeatureAt(pixel).then(function(selection) {
        var url = 'https://www.openstreetmap.org/edit?';
        var position = '19' + '/' + latlng.lat + '/' + latlng.lng;
        var properties = null;

        if (!selection || selection.feature == null || selection.feature.properties == null) {
          picking = false;
          popup.style.visibility = 'hidden';
          return;
        }

        // We used to return if we weren't selectable, but now we
        try {
          properties = selection.feature.properties;

          // default to OSM node, and zoom 19
          osm_type = 'node';
          osm_zoom = '19'

          // If it's a way (eg road or landuse polygon), then those are usually large, so zoom out a bit
          if( properties.sort_key ) {
            osm_type = 'way';
            osm_zoom = Math.max( 17, map.getZoom() );
          }

          // If it's a relation (usually landuse), then those are usually large, so zoom out a bit more
          osm_id = properties.id;
          if( osm_id < 0 ) {
            osm_type = 'relation'
            osm_id = Math.abs( osm_id );
            osm_zoom = Math.max( 16, map.getZoom() );
          }

          // Update the OSM iD editor URL
          url += osm_type + '=' + osm_id;
        } catch(e) { /*console.log( 'no feature at pixel' );*/ }

        url += '#map=' + position;

        var josmUrl = 'http://www.openstreetmap.org/edit?editor=remote#map='+position;

        popup.style.width = '250px';
        popup.style.left = (pixel.x + 0) + 'px';
        popup.style.top = (pixel.y + 0) + 'px';

        var kind_words = ''
        var named = '';

        if( properties.name ) {
          named = properties.name;
        } else {
          named = 'unnamed ' + properties.kind;
        }

        // What language do we want in the popup?
        // Roads layer content first...
        if( map.getZoom() >= 12 ) {
          if( (properties.highway == 'cycleway' && properties.cycleway == 'sidepath' || properties.cycleway == 'segregated') ||
              (properties.highway == 'footway'  && properties.bicycle == 'yes' && properties.segregated == 'yes' )
          ) {
            kind_words = named + " has a sidepath";
          } else if( properties.highway == "cycleway" && properties.cycleway != 'sidepath' ) {
            kind_words = named + " is a bike path";
          } else if( properties.highway == "footway" && (properties.bicycle == 'designated' || properties.bicycle == 'yes') ) {
            kind_words = named + " is a designated footway";
          } else if( properties.highway == "steps" && (properties.bicycle == 'designated' || properties.bicycle == 'yes') ) {
            kind_words = named + " is a designated steps";
          } else if( properties.highway == 'track' && (properties.bicycle == 'designated' || properties.bicycle == 'yes') ) {
            kind_words = named + " is a designated track";
          } else if( properties.kind == 'path' && (properties.bicycle == 'designated' || properties.bicycle == 'yes') ) {
            kind_words = named + " is a designated path";
          } else if( properties.cycleway && properties.oneway == 'yes' ) {
            kind_words = named + ' has a bike ' + properties.cycleway + " (implied right)";
          } else if( properties.cycleway ) {
            kind_words = named + ' has a bike ' + properties.cycleway + " (both sides)";
          } else if( properties.cycleway_left && properties.cycleway_right ){
            kind_words = named + ' has a bike ' + properties.cycleway_left + " (left) & " + properties.cycleway_right + " (right)";
          } else if( properties.cycleway_left ){
            kind_words = named + ' has a bike ' + properties.cycleway_left + " (left side)";
          } else if ( properties.cycleway_right ){
            kind_words = named + ' has a bike ' + properties.cycleway_right + " (right side)";
          } else if ( properties.is_bicycle_related ) {
            kind_words = named + " is a designated route only, does it have bike lanes?";
          }
          // ... now for POIs
          else if( properties.kind == 'bicycle' ) {
            kind_words = 'You found a bike shop to enhance!';
          } else if( properties.kind == 'bicycle_rental' ) {
                kind_words = 'You found a bike rental shop to enhance!';
          } else if( properties.kind == 'bicycle_rental_station' ) {
                kind_words = 'You found a bike rental station to enhance!';
          } else if( properties.kind == 'bicycle_parking' ) {
                kind_words = 'You found bike parking to enhance!';
          } else if( properties.kind == 'cycle_barrier' ) {
                kind_words = 'You found a bike barrier to enhance!';
          } else if( properties.kind == 'bicycle_junction' ) {
                kind_words = 'You found a bike junction to enhance!';
          } else if( properties.kind == 'bicycle_repair_station' ) {
            kind_words = 'You found a bike repair station to enhance!';
          //
          // Only show this when very far zoomed in
          // As it's confusing to have the popup flashing too much, and
          // enabling it farther out already conflicts with leaflet map pin dragging UX
          } else if(map.getZoom() >= 15) {
            kind_words = named + ' is not bike related, should it be?';
          }

          if( kind_words != '' ) {
            popup.innerHTML = '<span class="labelInner">' + kind_words + '</span><br>';
            popup.appendChild(createEditLinkElement(url, 'iD', 'Edit with iD ➹'));
            popup.appendChild(createEditLinkElement(josmUrl, 'JOSM', 'Edit with JOSM ➹'));
            popup.style.visibility = 'visible';
          } else {
            popup.style.visibility = 'hidden';
          }
        }
      });
    });
  }

  function createEditLinkElement (url, type, label) {
    var el = document.createElement('div');
    var anchor = document.createElement('a');
    el.className = 'labelInner';
    anchor.href = url;
    anchor.target = '_blank';
    anchor.textContent = label;
    anchor.addEventListener('click', function (event) {
      trackOutboundLink(url, 'editing_biking_features', type);
    }, false);
    el.appendChild(anchor);
    return el;
  }

  /**
  * Function that tracks a click on an outbound link in Google Analytics.
  * This function takes a valid URL string as an argument, and uses that URL string
  * as the event label. Setting the transport method to 'beacon' lets the hit be sent
  * using 'navigator.sendBeacon' in browser that support it.
  */
  function trackOutboundLink (url, post_name, editor) {
     // ga('send', 'event', [eventCategory], [eventAction], [eventLabel], [eventValue], [fieldsObject]);
     ga('send', 'event', 'outbound', post_name, url, {
     'transport': 'beacon',
     // If opening a link in the current window, this opens the url AFTER
     // registering the hit with Analytics. Disabled because here want the
     // link to open in a new window, so this hit can occur in the current tab.
     //'hitCallback': function(){document.location = url;}
     });
  }

  // helper functions used in debug to fetch tile coordinate JSON files
  function long2tile(lon,zoom) { return (Math.floor((lon+180)/360*Math.pow(2,zoom))); }
  function lat2tile(lat,zoom)  { return (Math.floor((1-Math.log(Math.tan(lat*Math.PI/180) + 1/Math.cos(lat*Math.PI/180))/Math.PI)/2 *Math.pow(2,zoom))); }

  function mapzenTileURL() {
    // find minimum max_zoom of all sources
    var max_zoom = 21;
    for (source in scene.config.sources) {
      if (scene.config.sources.hasOwnProperty(source)) {
        if (scene.config.sources[source].max_zoom != "undefined") {
          max_zoom = Math.min(max_zoom, scene.config.sources[source].max_zoom);
        }
      }
    }
    var zoom = max_zoom < map.getZoom() ? max_zoom : Math.floor(map.getZoom());
    var tileCoords = { x : long2tile(latlng.lng,zoom), y: lat2tile(latlng.lat,zoom), z: zoom };

    var url = 'http://vector.mapzen.com/osm/all/' + zoom + '/' + tileCoords.x  + '/' + tileCoords.y + '.topojson?api_key=vector-tiles-HqUVidw';
    return url;
  }

  /***** Render loop *****/

  function addGUI() {
    // Link to edit in OSM - hold 'e' and click
    map.getContainer().addEventListener('dblclick', function (event) {
      //console.log( 'dblclick was had' );
      if( timer ) { clearTimeout( timer ); timer = null; }
      popup.style.visibility = 'hidden';
    });

    var timer;

    // disable the popup with the escape key
    key_nc('esc', function(){ popup.style.visibility = 'hidden'; });

    map.getContainer().addEventListener('click', function (event) {
      //console.log( 'click was had' );
      if( timer ) { clearTimeout( timer ); timer = null; }
      timer = setTimeout( function(){
        picking = true;
        latlng = map.mouseEventToLatLng(event);

        var pixel = { x: event.clientX, y: event.clientY };
        var url = 'https://www.openstreetmap.org/edit?';
        var osm_zoom = Math.max( 16, map.getZoom() );

        // position the map so it's at a similar zoom to Tangram
        if (latlng) {
          url += '#map=' + osm_zoom + '/' + latlng.lat + '/' + latlng.lng;
              //console.log( 'url to get ' + url );
        }

        // Quick view tile JSON source debug
        if( key_nc.cmd || key_nc.alt ) {
          window.open( mapzenTileURL(), '_blank' );
        // Edit the map area immediately in OSM's iD editor
        // If you want to edit a specific feature, use the mouseover section
        // to specify whitelist of features kinds.
        } else if( key_nc.shift ) {
            window.open(url, '_blank');
        }
        timer = null;
      }, 200 );
    });
  }

  function inIframe () {
    try {
      return window.self !== window.top;
    } catch (e) {
      return true;
    }
  }

  window.addEventListener('load', function () {
    // If not embedded in a blog post, enable the mouse scroll wheel zoom
    if (!inIframe()) {
      map.scrollWheelZoom.enable();
    }
    // enable debug keyboard shortcuts
    addGUI();
    // enable mouse over popup windows
    initFeatureSelection();
    // finally add the layer to the map
    layer.addTo(map);
  });
} else {
  // Use normal OSM raster tiles instead of Tangram when WebGL is not available
  L.tileLayer('http://{s}.tile.osm.org/{z}/{x}/{y}.png', {
     attribution: '&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors'
   }).addTo(map);
}

// detect webgl on browser for Tangram
function hasWebGL() {
  try {
    var canvas = document.createElement('canvas');
    return !!(window.WebGLRenderingContext && (canvas.getContext('webgl') || canvas.getContext('experimental-webgl')));
  } catch (x) {
    return false;
  }
}


var routingData = {
  waypoints: [
    L.latLng(37.752, -122.418),
    L.latLng(37.779, -122.391)
  ],
  costing: 'bicycle'
}


// read searchquery and set up hash if there is none
// you can ignore this part if you are not planning to setup search query for your page
var hashVal = hashControl.read()
if( hashVal !== null) {
  var wps = [];
  for(var key in hashVal) {
    if(key.startsWith('point')) {
      var idx = parseInt(key.charAt(5));
      var kind = key.slice(6,9);
      if(wps[idx] === undefined) wps[idx] = L.latLng(0,0);
      wps[idx][kind] = hashVal[key];
    }
  }

  var mode = hashVal.mode;

  routingData.waypoints = wps;
  routingData.costing = mode;

} else {
  // when there was no hash set yet
  hashControl.set({
    point0lat: routingData.waypoints[0].lat,
    point0lng: routingData.waypoints[0].lng,
    point1lat: routingData.waypoints[1].lat,
    point1lng: routingData.waypoints[1].lng,
    mode: routingData.costing
  })
}

var control = L.Routing.control({
  routeLine: function (route, options) { return L.Routing.mapzenLine(route, options); },
  waypoints: routingData.waypoints,
  // You can get your own Mapzen turn-by-turn & search API key from the Mapzen developer portal (https://mapzen.com/developers/)
  geocoder: L.Control.Geocoder.mapzen('search-DqwJuRM'),
  reverseWaypoints: true,
  router: L.Routing.mapzen('valhalla-SxUZCXy', {costing: routingData.costing}),
  collapsible: true,
  lineOptions: {styles: [{color: 'red', opacity: 0.6, weight: 7, dashArray: '2,14'}]},
  show: (map.getSize().x > 768)? true: false,
  formatter: new L.Routing.mapzenFormatter(),
  summaryTemplate:'<div class="start">{name}</div><div class="info {costing}">{distance}, {time}</div>'
}).addTo(map);

L.Routing.errorControl(control).addTo(map);

// Adding easy button for UI

L.easyButton('btn-bicycle', function(btn, map){
  control.getRouter().options.costing = 'bicycle';
  control.route();
}).addTo(map);

L.easyButton('btn-auto', function(btn, map){
  control.getRouter().options.costing = 'auto';
  control.route();
}).addTo(map);

L.easyButton('btn-pedestrian', function(btn, map){
  control.getRouter().options.costing = 'pedestrian';
  control.route();
}).addTo(map);

L.easyButton('btn-multimodal', function(btn, map){
  control.getRouter().options.costing = 'multimodal';
  control.route();
}).addTo(map);


// change hash value whenever new routing starts
// you can ignore this part if you are not planning to setup search query for your page
control.on('routingstart', function () {
  var waypoints = control.getWaypoints();
  var mode = control.getRouter().options.costing;
  var newHashData = {}
  for(var i in waypoints) {
    var latKeyName = 'point' + i + 'lat';
    var lngKeyName = 'point' + i + 'lng';
    newHashData[latKeyName] = parseFloat(waypoints[i].latLng.lat).toFixed(4);
    newHashData[lngKeyName] = parseFloat(waypoints[i].latLng.lng).toFixed(4);
  }
  newHashData['mode'] = mode;
  hashControl.set(newHashData);
})

/*
// show where waypoints after route updates
control.on('routesfound', function () {
  map.fitBounds(routingData.waypoints);
})
*/

// to show where waypoints are even if there is no routing data
control.on('routingerror', function () {
  var waypoints = control.getWaypoints();
  map.fitBounds([
    waypoints[0].latLng,
    waypoints[waypoints.length-1].latLng
  ]);
})
