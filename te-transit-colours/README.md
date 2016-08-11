# te-transit-colours
Targeted Editing - Transit Colours

* https://mapzen.com/blog/targeted-editing-transit-colours/

## Parts

* Blog post - [index.html](index.html)
* Small map for blog post - [map/embed.html](map/embed.html)
* Big map - [map/index.html](map/index.html)
* Scene file (powers the map) - [map/transit.yaml](map/transit.yaml)
* Map interactivity - [map/main.js](map/main.js)

### To run locally:

Download this repo, then start a web server in its directory:

    python -m SimpleHTTPServer 8000
    
If that doesn't work, try:

    python -m http.server 8000
    
Then navigate to: [http://localhost:8000](http://localhost:8000)
