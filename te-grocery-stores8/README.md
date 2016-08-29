# te-grocery-stores
New Year's Resolutions - Grocery POIs

* https://mapzen-data.github.io/targeted-editing/te-grocery-stores/map
* https://mapzen.com/blog/new-years-resolutions-groceries
* https://mapzen.com/blog/targeted-editing-retrospective/

## Parts

* Map - [map/index.html](map/index.html)
* Scene file (powers the map) - [map/grocery.yaml](map/grocery.yaml)
* Map interactivity - [map/main.js](map/main.js)
* Queries
	* [queries/grocery_sql.sql](https://github.com/mapzen-data/targeted-editing/blob/gh-pages/queries/grocery_sql.sql) original queries
	* [queries/new_grocery_sql.sql](https://github.com/mapzen-data/targeted-editing/blob/gh-pages/queries/new_grocery_sql.sql)  reporting change since original blog post


### To run locally:

Download this repo, then start a web server in its directory:

    python -m SimpleHTTPServer 8000
    
If that doesn't work, try:

    python -m http.server 8000
    
Then navigate to: [http://localhost:8000](http://localhost:8000)
