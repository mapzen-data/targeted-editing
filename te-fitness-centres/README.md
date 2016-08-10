# nyr-fitness
New Year's Resolutions - Fitness POIs

* https://mapzen-data.github.io/targeted-editing/te-fitness-centres/map

## Parts

* Blog post - [index.html](index.html)
* Small map for blog post - [map/embed.html](map/embed.html)
* Big map - [map/index.html](map/index.html)
* Scene file (powers the map) - [map/fitness.yaml](map/fitness.yaml#L698-L747)
* Map interactivity - [map/main.js](map/main.js)


### To run locally:

Download this repo, then start a web server in its directory:

    python -m SimpleHTTPServer 8000
    
If that doesn't work, try:

    python -m http.server 8000
    
Then navigate to: [http://localhost:8000](http://localhost:8000)
