# te-cycleways
Targeted Editing - Cycleways

* https://mapzen-data.github.io/targeted-editing/te-cycleways/map
* https://mapzen.com/blog/targeted-editing-cycleways/
* https://mapzen.com/blog/targeted-editing-retrospective/

## Parts

* Map - [map/index.html](map/index.html)
* Scene file (powers the map) - [map/cycleways.yaml](map/cycleways.yaml)
* Map interactivity - [map/main.js](map/main.js)
* Queries
	* [queries/bicycle_sql.sql](https://github.com/mapzen-data/targeted-editing/blob/gh-pages/queries/bicycle_sql.sql)
	* [queries/bicycle_sql.sql](https://github.com/mapzen-data/targeted-editing/blob/gh-pages/queries/bicycle_sql.sql) original queries
	* [queries/new_bicycle_sql.sql](https://github.com/mapzen-data/targeted-editing/blob/gh-pages/queries/new_bicycle_sql.sql)  reporting change since original blog post


### To run locally:

Download this repo, then start a web server in its directory:

    python -m SimpleHTTPServer 8000
    
If that doesn't work, try:

    python -m http.server 8000
    
Then navigate to: [http://localhost:8000](http://localhost:8000)
