# te-school-polygons
Targeted Editing - School Polygons 

* https://mapzen.com/blog/targeted-editing-school-polygons/
* https://mapzen.com/blog/targeted-editing-campus-mapping/

## Parts

* Small map for blog posts - [map/embed.html](map/embed.html)
* Big map - [map/index.html](map/index.html)
* Scene file (powers the map) - [map/schools.yaml](map/schools.yaml)
* Map interactivity - [map/main.js](map/main.js)
* Pie chart - [graphics/pie-chart.html](graphics/pie-chart.html)


### To run locally:

Download this repo, then start a web server in its directory:

    python -m SimpleHTTPServer 8000
    
If that doesn't work, try:

    python -m http.server 8000
    
Then navigate to: [http://localhost:8000](http://localhost:8000)
