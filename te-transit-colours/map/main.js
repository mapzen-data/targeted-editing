/*jslint browser: true*/
/*global Tangram */
var picking = false;
map = (function () {
// (function () {
    // 'use strict';

    // defaults
    var map_start_location = [0, 0, 2]; // world
    var style_file = 'transit.yaml';

    /*** URL parsing ***/

    // leaflet-style URL hash pattern:
    // #[zoom],[lat],[lng]
    var url_hash = window.location.hash.slice(1).split('/');

    // location
    var defaultpos = true; // use default position
    
    // location is passed through url
    if (url_hash.length == 3) {
        var defaultpos = false;
        if (url_hash[1] > 180) { // parse hash as tile coordinates
            // example: http://localhost:9001/#15/5242/12663
            // add .5 to coords to center tile on screen
            map_start_location = [tile2lat(parseFloat(url_hash[2]) + .5, url_hash[0]), tile2long(parseFloat(url_hash[1]) + .5, url_hash[0]), url_hash[0]];
        }
        else { // parse hash as lat/lng coordinates
            map_start_location = [url_hash[1],url_hash[2], url_hash[0]];
            // convert from strings
            map_start_location = map_start_location.map(Number);
        }
    }

    // normal case, eg: http://tangrams.github.io/nameless-maps/?roads#4/0/0
    var url_search = window.location.search.slice(1).split('/')[0];
    // console.log('url_search', url_search);
    if (url_search.length > 0) {
        style_file = url_search + ".yaml";
        // console.log('style_file', style_file);
    }

    /*** Map ***/

    var map = L.map('map',
        {"keyboardZoomOffset" : .05, "scrollWheelZoom": false }
    );
    map.setView(map_start_location.slice(0, 2), map_start_location[2]);

    var layer = Tangram.leafletLayer({
        scene: style_file,
        attribution: '<a href="https://mapzen.com/tangram" target="_blank">Tangram</a> | &copy; OSM contributors | <a href="https://mapzen.com/" target="_blank">Mapzen</a>'
    });

    window.layer = layer;
    var scene = layer.scene;
    window.scene = scene;
    var latlng = {};
    var popup = document.getElementById('popup'); // click-popup

    // setView expects format ([lat, long], zoom)
    var hash = new L.Hash(map);

    function updateKey(value) {
        keytext = value;

        for (layer in scene.config.layers) {
            if (layer == "earth") continue;
            scene.config.layers[layer].properties.key_text = value;
        }
        scene.rebuildGeometry();
        scene.requestRedraw();
    }

    function updateValue(value) {
        valuetext = value;

        for (layer in scene.config.layers) {
            if (layer == "earth") continue;
            scene.config.layers[layer].properties.value_text = value;
        }
        scene.rebuildGeometry();
        scene.requestRedraw();
    }

    // Feature selection
    function initFeatureSelection () {
        map.getContainer().addEventListener('mousemove', function (event) {
            picking = true;
            latlng = map.mouseEventToLatLng(event);

            var pixel = { x: event.clientX, y: event.clientY };

            scene.getFeatureAt(pixel).then(function(selection) {
                if (!selection || selection.feature == null || selection.feature.properties == null) {
                    picking = false;
                    popup.style.visibility = 'hidden';
                    return;
                }                
                var properties = selection.feature.properties;

                popup.style.left = (pixel.x + 0) + 'px';
                popup.style.top = (pixel.y + 0) + 'px';
                
                var url = 'https://www.openstreetmap.org/edit?';
                // enable iD to show properties sidebar for selected feature
                osm_type = 'node';
                osm_zoom = '19'
                if( selection.feature.properties.sort_key ) {
                    osm_type = 'way';
                    osm_zoom = Math.max( 17, map.getZoom() );
                }
                osm_id = selection.feature.properties.id;
                if( osm_id < 0 ) {
                    osm_type = 'relation'
                    osm_id = Math.abs( osm_id );
                    osm_zoom = Math.max( 16, map.getZoom() );
                }
                url += osm_type + '=' + osm_id;
                // and position the map so it's at a similar zoom to Tangram
                if (latlng) {
                    url += '#map=' + osm_zoom + '/' + latlng.lat + '/' + latlng.lng;
                }                
                // JOSM editor link
                var position = '19' + '/' + latlng.lat + '/' + latlng.lng;
                var josmUrl = 'http://www.openstreetmap.org/edit?editor=remote#map='+position;

                if ( // !properties.colour && 
                     (properties.kind == 'light_rail' || properties.kind == 'subway' || properties.kind == 'train' || properties.kind == 'tram')
                ) {
                    popup.innerHTML = '<span class="labelInner">' + 'You found a transit line to enhance!' + '</span><br>';
                    popup.appendChild(createEditLinkElement(url, 'iD', 'Edit with iD ➹'));
                    popup.appendChild(createEditLinkElement(josmUrl, 'JOSM', 'Edit with JOSM ➹'));
                    popup.style.visibility = 'visible';
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
            trackOutboundLink(url, 'editing_transit_colours', type);
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
        map.getContainer().addEventListener('click', function (event) {
            picking = true;
            latlng = map.mouseEventToLatLng(event);
            var pixel = { x: event.clientX, y: event.clientY };
            
            if( key.cmd || key.alt ) {
                window.open( mapzenTileURL(), '_blank' );
            } else {
                var url = 'https://www.openstreetmap.org/edit?';
                scene.getFeatureAt(pixel).then(function(selection) {
                    if (!selection || selection.feature == null || selection.feature.properties == null) {
                        picking = false;
                        popup.style.visibility = 'hidden';
                        return;
                    }
                    //console.log(selection.feature, selection.changed);
                    // enable iD to show properties sidebar for selected feature
                    osm_type = 'node';
                    osm_zoom = '19'
                    if( selection.feature.properties.sort_key ) {
                        osm_type = 'way';
                        osm_zoom = Math.max( 17, map.getZoom() );
                    }
                    osm_id = selection.feature.properties.id;
                    if( osm_id < 0 ) {
                        osm_type = 'relation'
                        osm_id = Math.abs( osm_id );
                        osm_zoom = Math.max( 16, map.getZoom() );
                    }
                    url += osm_type + '=' + osm_id;
                    // and position the map so it's at a similar zoom to Tangram
                    if (latlng) {
                        url += '#map=' + osm_zoom + '/' + latlng.lat + '/' + latlng.lng;
                    }
    
                    if( key.shift ) {
                        window.open(url, '_blank');
                    }//  else {
//                         var properties = selection.feature.properties;
// 
//                         var label = '';
//                         //console.log(properties);
//                         for (var x in properties) {
//                             var val = properties[x]
//                             label += "<span class='labelLine' key="+x+" value="+val+"'>"+x+" : "+val+"</span><br>"
//                         }
// 
//                         if (label != '') {
//                             popup.style.left = (pixel.x) + 'px';
//                             popup.style.top = (pixel.y) + 'px';
//                             popup.style.margin = '0px';
//                             popup.innerHTML = '<span class="labelInner">' + label + '</span>';
//                         }
// 
//                         // JOSM editor link
//                         var position = '19' + '/' + latlng.lat + '/' + latlng.lng;
//                         var josmUrl = 'http://www.openstreetmap.org/edit?editor=remote#map='+position;
//     
//                         popup.appendChild(createEditLinkElement( url, 'iD', 'Edit with iD ➹') );
//                         popup.appendChild(createEditLinkElement( josmUrl, 'JOSM', 'Edit with JOSM ➹') );
//                         popup.appendChild(createEditLinkElement( mapzenTileURL(), 'rawTile', 'View tile data ➹') );
//                         popup.style.visibility = 'visible';
//                     }
                });
            }
        });
    }

    function inIframe () {
        try {
            return window.self !== window.top;
        } catch (e) {
            return true;
        }
    }
    
    // Add map
    window.addEventListener('load', function () {
        // Scene initialized
        layer.on('init', function() {
            addGUI();
            initFeatureSelection();
            var camera = scene.config.cameras[scene.getActiveCamera()];
            // if a camera position is set in the scene file, use that
            if (defaultpos && typeof camera.position != "undefined") {
                map_start_location = [camera.position[1], camera.position[0], camera.position[2]]
            }
            map.setView([map_start_location[0], map_start_location[1]], map_start_location[2]);
        });
        if (!inIframe()) {
            map.scrollWheelZoom.enable();
        }
        layer.addTo(map);
    });

    return map;
}());