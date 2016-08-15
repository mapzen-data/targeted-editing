# nyr-fitness
New Year's Resolutions - Fitness POIs

* https://mapzen-data.github.io/targeted-editing/te-fitness-centres/map
* https://mapzen.com/blog/new-years-resolutions-fitness/
* https://mapzen.com/blog/targeted-editing-retrospective/

## Parts

* Map - [map/index.html](map/index.html)
* Scene file (powers the map) - [map/fitness.yaml](map/fitness.yaml)
* Map interactivity - [map/main.js](map/main.js)
* Queries
	* [queries/fitness_sql.sql](https://github.com/mapzen-data/targeted-editing/blob/gh-pages/queries/fitness_sql.sql) original queries
	* [queries/new_fitness_sql.sql](https://github.com/mapzen-data/targeted-editing/blob/gh-pages/queries/new_fitness_sql.sql)  reporting change since original blog post


### To run locally:

Download this repo, then start a web server in its directory:

    python -m SimpleHTTPServer 8000
    
If that doesn't work, try:

    python -m http.server 8000
    
Then navigate to: [http://localhost:8000](http://localhost:8000)
