# te-transit-colours
Targeted Editing - Transit Colours

* https://mapzen-data.github.io/targeted-editing/te-transit-colours/map
* https://mapzen.com/blog/targeted-editing-transit-colours/
* https://mapzen.com/blog/targeted-editing-retrospective/

## Parts

* Map - [map/index.html](map/index.html)
* Scene file (powers the map) - [map/transit.yaml](map/transit.yaml)
* Map interactivity - [map/main.js](map/main.js)
* Queries
	* [queries/transit_sql.sql](https://github.com/mapzen-data/targeted-editing/blob/gh-pages/queries/transit_sql.sql) original queries
	* [queries/new_transit_sql.sql](https://github.com/mapzen-data/targeted-editing/blob/gh-pages/queries/new_transit_sql.sql)  reporting change since original blog post
	
### To run locally:

Download this repo, then start a web server in its directory:

    python -m SimpleHTTPServer 8000
    
If that doesn't work, try:

    python -m http.server 8000
    
Then navigate to: [http://localhost:8000](http://localhost:8000)
