# name-that-building

Simple visualization of OpenStreetMap buildings that don't have names to encourage edits.

* http://indyhurt.github.io/name-that-building

## Parts

* Blog post - [index.html](index.html)
* Small map for blog post - [map/embed.html](map/embed.html)
* Big map - [map/index.html](map/index.html)
* Scene file (powers the map) - [map/buildings.yaml](map/buildings.yaml#L698-L801)
* Map interactivity - [map/main.js](map/main.js)
* Pie chart - [graphics/pie-chart.html](graphics/pie-chart.html)

### To run locally:

Download this repo, then start a web server in its directory:

    python -m SimpleHTTPServer 8000
    
If that doesn't work, try:

    python -m http.server 8000
    
Then navigate to: [http://localhost:8000](http://localhost:8000)