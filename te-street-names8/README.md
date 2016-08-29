# te-street-names
Targeted Editing - Where the streets have no names 

* https://mapzen-data.github.io/targeted-editing/te-street-names/map
* https://mapzen.com/blog/targeted-editing-no-name-roads/
* https://mapzen.com/blog/targeted-editing-retrospective/
* 
## Parts

* Map - [map/index.html](map/index.html)
* Scene file (powers the map) - [map/roads.yaml](map/roads.yaml)
* Map interactivity - [map/main.js](map/main.js)
* Pie chart - [graphics/pie-chart.html](graphics/pie-chart.html)
* Queries
	* [queries/new_roads_sql.sql](https://github.com/mapzen-data/targeted-editing/blob/gh-pages/queries/new_roads_sql.sql)  reporting change since original blog post

### To run locally:

Download this repo, then start a web server in its directory:

    python -m SimpleHTTPServer 8000
    
If that doesn't work, try:

    python -m http.server 8000
    
Then navigate to: [http://localhost:8000](http://localhost:8000)


