drop table if exists collections;
create table collections (query_name text, value real);

-- QUERIES FOR GALLERIES

  -- gallery points
-- How many gallery points are there?
insert into collections (query_name, value) values ('art_gallery_points', (select count(*) from planet_osm_point where ((tourism in ('gallery', 'art_gallery', 'Art Gallery', 'Art_gallery') or amenity in ('gallery', 'art_gallery', 'arts_gallery', 'contemporary_art_gallery') or (tags ? 'gallery') or building in ('gallery', 'art_gallery')) and (osm_id > 0))));

-- How many gallery points have addresses?
insert into collections (query_name, value) values ('art_gallery_points_with_housenumber', (select count(*) from planet_osm_point where ((tourism in ('gallery', 'art_gallery', 'Art Gallery', 'Art_gallery') or amenity in ('gallery', 'art_gallery', 'arts_gallery', 'contemporary_art_gallery') or (tags ? 'gallery') or building in ('gallery', 'art_gallery')) and (osm_id > 0 and "addr:housenumber" is not null))));

-- How many gallery points have websites?
insert into collections (query_name, value) values ('art_gallery_points_with_website', (select count(*) from planet_osm_point where ((tourism in ('gallery', 'art_gallery', 'Art Gallery', 'Art_gallery') or amenity in ('gallery', 'art_gallery', 'arts_gallery', 'contemporary_art_gallery') or (tags ? 'gallery') or building in ('gallery', 'art_gallery')) and (osm_id > 0 and (tags ?| array ['website','url'])))));

-- How many gallery points have phone numbers?
insert into collections (query_name, value) values ('art_gallery_points_with_phone', (select count(*) from planet_osm_point where ((tourism in ('gallery', 'art_gallery', 'Art Gallery', 'Art_gallery') or amenity in ('gallery', 'art_gallery', 'arts_gallery', 'contemporary_art_gallery') or (tags ? 'gallery') or building in ('gallery', 'art_gallery')) and (osm_id > 0 and (tags ? 'phone')))));

-- How many gallery points have opening hours?
insert into collections (query_name, value) values ('art_gallery_points_with_hours', (select count(*) from planet_osm_point where ((tourism in ('gallery', 'art_gallery', 'Art Gallery', 'Art_gallery') or amenity in ('gallery', 'art_gallery', 'arts_gallery', 'contemporary_art_gallery') or (tags ? 'gallery') or building in ('gallery', 'art_gallery')) and (osm_id > 0 and (tags ? 'opening_hours' or tags ? 'operating_hours')))));

-- How many gallery points have wheelchair accessibility information?
insert into collections (query_name, value) values ('art_gallery_points_with_wheelchair', (select count(*) from planet_osm_point where ((tourism in ('gallery', 'art_gallery', 'Art Gallery', 'Art_gallery') or amenity in ('gallery', 'art_gallery', 'arts_gallery', 'contemporary_art_gallery') or (tags ? 'gallery') or building in ('gallery', 'art_gallery')) and (osm_id > 0 and (tags ? 'wheelchair')))));

-- How many gallery points have fee information?
insert into collections (query_name, value) values ('art_gallery_points_with_fee', (select count(*) from planet_osm_point where ((tourism in ('gallery', 'art_gallery', 'Art Gallery', 'Art_gallery') or amenity in ('gallery', 'art_gallery', 'arts_gallery', 'contemporary_art_gallery') or (tags ? 'gallery') or building in ('gallery', 'art_gallery')) and (osm_id > 0 and (tags ? 'fee')))));

  -- gallery polygons
-- How many gallery polygons are there?
insert into collections (query_name, value) values ('art_gallery_polygons', (select count(*) from planet_osm_polygon where ((tourism in ('gallery', 'art_gallery', 'Art Gallery', 'Art_gallery') or amenity in ('gallery', 'art_gallery', 'arts_gallery', 'contemporary_art_gallery') or (tags ? 'gallery') or building in ('gallery', 'art_gallery')) and (osm_id > 0))));

-- How many gallery polygons have addresses?
insert into collections (query_name, value) values ('art_gallery_polygons_with_housenumber', (select count(*) from planet_osm_polygon where ((tourism in ('gallery', 'art_gallery', 'Art Gallery', 'Art_gallery') or amenity in ('gallery', 'art_gallery', 'arts_gallery', 'contemporary_art_gallery') or (tags ? 'gallery') or building in ('gallery', 'art_gallery')) and (osm_id > 0 and "addr:housenumber" is not null))));

-- How many gallery polygons have websites?
insert into collections (query_name, value) values ('art_gallery_polygons_with_website', (select count(*) from planet_osm_polygon where ((tourism in ('gallery', 'art_gallery', 'Art Gallery', 'Art_gallery') or amenity in ('gallery', 'art_gallery', 'arts_gallery', 'contemporary_art_gallery') or (tags ? 'gallery') or building in ('gallery', 'art_gallery')) and (osm_id > 0 and (tags ?| array ['website','url'])))));

-- How many gallery polygons have phone numbers?
insert into collections (query_name, value) values ('art_gallery_polygons_with_phone', (select count(*) from planet_osm_polygon where ((tourism in ('gallery', 'art_gallery', 'Art Gallery', 'Art_gallery') or amenity in ('gallery', 'art_gallery', 'arts_gallery', 'contemporary_art_gallery') or (tags ? 'gallery') or building in ('gallery', 'art_gallery')) and (osm_id > 0 and (tags ? 'phone')))));

-- How many gallery polygons have opening hours?
insert into collections (query_name, value) values ('art_gallery_polygons_with_hours', (select count(*) from planet_osm_polygon where ((tourism in ('gallery', 'art_gallery', 'Art Gallery', 'Art_gallery') or amenity in ('gallery', 'art_gallery', 'arts_gallery', 'contemporary_art_gallery') or (tags ? 'gallery') or building in ('gallery', 'art_gallery')) and (osm_id > 0 and (tags ? 'opening_hours' or tags ? 'operating_hours')))));

-- How many gallery polygons have wheelchair accessibility information?
insert into collections (query_name, value) values ('art_gallery_polygons_with_wheelchair', (select count(*) from planet_osm_polygon where ((tourism in ('gallery', 'art_gallery', 'Art Gallery', 'Art_gallery') or amenity in ('gallery', 'art_gallery', 'arts_gallery', 'contemporary_art_gallery') or (tags ? 'gallery') or building in ('gallery', 'art_gallery')) and (osm_id > 0 and (tags ? 'wheelchair')))));

-- How many gallery polygons have fee information?
insert into collections (query_name, value) values ('art_gallery_polygons_with_fee', (select count(*) from planet_osm_polygon where ((tourism in ('gallery', 'art_gallery', 'Art Gallery', 'Art_gallery') or amenity in ('gallery', 'art_gallery', 'arts_gallery', 'contemporary_art_gallery') or (tags ? 'gallery') or building in ('gallery', 'art_gallery')) and (osm_id > 0 and (tags ? 'fee')))));



-- QUERIES FOR LIBRARIES

-- How many library points are there?
insert into collections (query_name, value) values ('library_points', (select count(*) from planet_osm_point where ((amenity = 'library' or building = 'library' or tags ? 'library') and (osm_id > 0))));

-- How many library polygons are there?
insert into collections (query_name, value) values ('library_polygons', (select count(*) from planet_osm_polygon where ((amenity = 'library' or building = 'library' or tags ? 'library') and (osm_id > 0))));

-- QUERIES FOR MUSEUMS 

-- How many museum points are there?
insert into collections (query_name, value) values ('museum_points', (select count(*) from planet_osm_point where ((tourism = 'museum' or amenity = 'museum' or building = 'museum' or (tags ? 'museum' and tags -> 'museum' != 'gallery')) and (osm_id > 0))));

-- How many museum polygons are there?
insert into collections (query_name, value) values ('museum_polygons', (select count(*) from planet_osm_polygon where ((tourism = 'museum' or amenity = 'museum' or building = 'museum' or (tags ? 'museum' and tags -> 'museum' != 'gallery')) and (osm_id > 0))));

select * from collections;

