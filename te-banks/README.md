# Banks
Simple visualization of OpenStreetMap banks and ATMs to encourage edits.

* https://mapzen-data.github.io/targeted-editing/te-banks/map
* https://mapzen.com/blog/new-years-resolutions-money/

## Parts

* Map - [map/index.html](map/index.html)
* Scene file (powers the map) - [map/bank.yaml](map/bank.yaml)
* Map interactivity - [map/main.js](map/main.js)

### To run locally:

Download this repo, then start a web server in its directory:

    python -m SimpleHTTPServer 8000
    
If that doesn't work, try:

    python -m http.server 8000
    
Then navigate to: [http://localhost:8000](http://localhost:8000)
