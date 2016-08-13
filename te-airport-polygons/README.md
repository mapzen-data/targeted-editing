# Airport Polygons
Simple visualization of OpenStreetMap airports that don't have polygons to encourage edits.

* https://mapzen-data.github.io/targeted-editing/te-airport-polygons/map
* https://mapzen.com/blog/targeted-editing-airport-polygons/

## Parts

* Map - [map/index.html](map/index.html)
* Scene file (powers the map) - [map/airports.yaml](map/airports.yaml)
* Map interactivity - [map/main.js](map/main.js)
* Pie chart - [graphics/pie-chart.html](graphics/pie-chart.html)

### To run locally:

Download this repo, then start a web server in its directory:

    python -m SimpleHTTPServer 8000
    
If that doesn't work, try:

    python -m http.server 8000
    
Then navigate to: [http://localhost:8000](http://localhost:8000)

