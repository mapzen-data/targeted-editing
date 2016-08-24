drop table if exists collections;
create table collections (query_name text, value real);

-- QUERIES FOR GALLERIES

-- How many gallery points are there?
insert into collections (query_name, value) values ('art_gallery_points', (select count(*) from planet_osm_point where (tourism in ('gallery', 'art_gallery', 'Art Gallery', 'Art_gallery') or amenity in ('gallery', 'art_gallery', 'arts_gallery', 'contemporary_art_gallery') or (tags ? 'gallery') or building in ('gallery', 'art_gallery')) and (osm_id > 0)));

-- How many gallery polygons are there?
insert into collections (query_name, value) values ('art_gallery_polygons', (select count(*) from planet_osm_polygon where (tourism in ('gallery', 'art_gallery', 'Art Gallery', 'Art_gallery') or amenity in ('gallery', 'art_gallery', 'arts_gallery', 'contemporary_art_gallery') or (tags ? 'gallery') or building in ('gallery', 'art_gallery')) and (osm_id > 0)));


-- QUERIES FOR LIBRARIES

-- How many library points are there?
insert into collections (query_name, value) values ('library_points', (select count(*) from planet_osm_point where (amenity = 'library' or building = 'library' or tags ? 'library') and (osm_id > 0)));

-- How many library polygons are there?
insert into collections (query_name, value) values ('library_polygons', (select count(*) from planet_osm_polygon where (amenity = 'library' or building = 'library' or tags ? 'library') and (osm_id > 0)));

-- QUERIES FOR MUSEUMS 

-- How many museum points are there?
insert into collections (query_name, value) values ('museum_points', (select count(*) from planet_osm_point where (tourism = 'museum' or amenity = 'museum' or building = 'museum' or (tags ? 'museum' and tags -> 'museum' != 'gallery')) and (osm_id > 0)));

-- How many museum polygons are there?
insert into collections (query_name, value) values ('museum_polygons', (select count(*) from planet_osm_olygons where (tourism = 'museum' or amenity = 'museum' or building = 'museum' or (tags ? 'museum' and tags -> 'museum' != 'gallery')) and (osm_id > 0)));

select * from collections;

