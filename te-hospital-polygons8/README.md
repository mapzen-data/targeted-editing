# te-hospital-polygons
Targeted Editing - Hospital Polygons

* https://mapzen-data.github.io/targeted-editing/te-hospital-polygons/map
* https://mapzen.com/blog/targeted-editing-hospital-polygons/
* https://mapzen.com/blog/targeted-editing-retrospective/

## Parts

* Map - [map/index.html](map/index.html)
* Scene file (powers the map) - [map/hospitals.yaml](map/hospitals.yaml)
* Map interactivity - [map/main.js](map/main.js)
* Queries
	* [queries/new_hospital_sql.sql](https://github.com/mapzen-data/targeted-editing/blob/gh-pages/queries/new_hospital_sql.sql)  reporting change since original blog post


### To run locally:

Download this repo, then start a web server in its directory:

    python -m SimpleHTTPServer 8000
    
If that doesn't work, try:

    python -m http.server 8000
    
Then navigate to: [http://localhost:8000](http://localhost:8000)

