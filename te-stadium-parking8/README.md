# te-stadium-parking
Targeted Editing - Tailgate Mania (for stadium parking)

* https://mapzen-data.github.io/targeted-editing/te-stadium-parking/map
* https://mapzen.com/blog/targeted-editing-tailgate-mania
* https://mapzen.com/blog/targeted-editing-retrospective/

## Parts

* Map - [map/index.html](map/index.html)
* Scene file (powers the map) - [map/stadiums.yaml](stadiums.yaml)
* Map interactivity - [map/main.js](map/main.js)
* Queries
	* [queries/stadium_parking.sql](https://github.com/mapzen-data/targeted-editing/blob/gh-pages/queries/stadium_parking.sql) original queries
	* [queries/new_stadium_parking.sql](https://github.com/mapzen-data/targeted-editing/blob/gh-pages/queries/new_stadium_parking.sql)  reporting change since original blog post

### To run locally:

Download this repo, then start a web server in its directory:

    python -m SimpleHTTPServer 8000
    
If that doesn't work, try:

    python -m http.server 8000
    
Then navigate to: [http://localhost:8000](http://localhost:8000)