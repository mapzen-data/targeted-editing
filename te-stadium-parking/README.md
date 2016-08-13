# te-stadium-parking
Targeted Editing - Tailgate Mania (for stadium parking)

* https://mapzen-data.github.io/targeted-editing/te-stadium-parking/map
* https://mapzen.com/blog/targeted-editing-tailgate-mania

## Parts

* Map - [map/index.html](map/index.html)
* Scene file (powers the map) - [map/stadiums.yaml](stadiums.yaml)
* Map interactivity - [map/main.js](map/main.js)


### To run locally:

Download this repo, then start a web server in its directory:

    python -m SimpleHTTPServer 8000
    
If that doesn't work, try:

    python -m http.server 8000
    
Then navigate to: [http://localhost:8000](http://localhost:8000)