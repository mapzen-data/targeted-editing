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


  -- gallery totals
-- Total galleries?
insert into collections (query_name, value) values ('art_gallery_total', (select sum(value) from collections where query_name = 'art_gallery_points' or query_name = 'art_gallery_polygons'));

-- Total galleries with addresses?
insert into collections (query_name, value) values ('art_gallery_with_address_total', (select sum(value) from collections where query_name = 'art_gallery_points_with_housenumber' or query_name = 'art_gallery_polygons_with_housenumber'));

-- Total galleries with website?
insert into collections (query_name, value) values ('art_gallery_with_website_total', (select sum(value) from collections where query_name = 'art_gallery_points_with_website' or query_name = 'art_gallery_polygons_with_website'));

-- Total galleries with phone number?
insert into collections (query_name, value) values ('art_gallery_with_phone_number_total', (select sum(value) from collections where query_name = 'art_gallery_points_with_phone' or query_name = 'art_gallery_polygons_with_phone'));

-- Total galleries with hours?
insert into collections (query_name, value) values ('art_gallery_with_hours_total', (select sum(value) from collections where query_name = 'art_gallery_points_with_hours' or query_name = 'art_gallery_polygons_with_hours'));

-- Total galleries with accessibility information?
insert into collections (query_name, value) values ('art_gallery_with_wheelchair_total', (select sum(value) from collections where query_name = 'art_gallery_points_with_wheelchair' or query_name = 'art_gallery_polygons_with_wheelchair'));

-- Total galleries with fee information?
insert into collections (query_name, value) values ('art_gallery_with_fee_total', (select sum(value) from collections where query_name = 'art_gallery_points_with_fee' or query_name = 'art_gallery_polygons_with_fee'));

-- Percent galleries with address?
insert into collections (query_name, value) values ('art_gallery_with_address_pct', (((select value from collections where query_name = 'art_gallery_with_address_total')/(select value from collections where query_name = 'art_gallery_total')) *100));

-- Percent galleries with website?
insert into collections (query_name, value) values ('art_gallery_with_website_pct', (((select value from collections where query_name = 'art_gallery_with_website_total')/(select value from collections where query_name = 'art_gallery_total')) *100));
  
-- Percent galleries with phone?
insert into collections (query_name, value) values ('art_gallery_with_phone_pct', (((select value from collections where query_name = 'art_gallery_with_phone_number_total')/(select value from collections where query_name = 'art_gallery_total')) *100));

-- Percent galleries with hours?
insert into collections (query_name, value) values ('art_gallery_with_hours_pct', (((select value from collections where query_name = 'art_gallery_with_hours_total')/(select value from collections where query_name = 'art_gallery_total')) *100));

-- Percent galleries with accessibility information?
insert into collections (query_name, value) values ('art_gallery_with_wheelchair_pct', (((select value from collections where query_name = 'art_gallery_with_wheelchair_total')/(select value from collections where query_name = 'art_gallery_total')) *100));

-- Percent galleries with fee information?
insert into collections (query_name, value) values ('art_gallery_with_fee_pct', (((select value from collections where query_name = 'art_gallery_with_fee_total')/(select value from collections where query_name = 'art_gallery_total')) *100));

-- QUERIES FOR LIBRARIES


  -- library points
-- How many library points are there?
insert into collections (query_name, value) values ('library_points', (select count(*) from planet_osm_point where ((amenity = 'library' or building = 'library' or tags ? 'library') and (osm_id > 0))));

-- How many library points have addresses?
insert into collections (query_name, value) values ('library_points_with_housenumber', (select count(*) from planet_osm_point where ((amenity = 'library' or building = 'library' or tags ? 'library') and (osm_id > 0 and "addr:housenumber" is not null))));

-- How many library points have websites?
insert into collections (query_name, value) values ('library_points_with_website', (select count(*) from planet_osm_point where ((amenity = 'library' or building = 'library' or tags ? 'library') and (osm_id > 0 and (tags ?| array ['website','url'])))));

-- How many library points have phone numbers?
insert into collections (query_name, value) values ('library_points_with_phone', (select count(*) from planet_osm_point where ((amenity = 'library' or building = 'library' or tags ? 'library') and (osm_id > 0 and (tags ? 'phone')))));

-- How many library points have opening hours?
insert into collections (query_name, value) values ('library_points_with_hours', (select count(*) from planet_osm_point where ((amenity = 'library' or building = 'library' or tags ? 'library') and (osm_id > 0 and (tags ? 'opening_hours' or tags ? 'operating_hours')))));

-- How many library points have wheelchair accessibility information?
insert into collections (query_name, value) values ('library_points_with_wheelchair', (select count(*) from planet_osm_point where ((amenity = 'library' or building = 'library' or tags ? 'library') and (osm_id > 0 and (tags ? 'wheelchair')))));

-- How many library points have fee information?
insert into collections (query_name, value) values ('library_points_with_fee', (select count(*) from planet_osm_point where ((amenity = 'library' or building = 'library' or tags ? 'library') and (osm_id > 0 and (tags ? 'fee')))));

  -- library polygons
-- How many library polygons are there?
insert into collections (query_name, value) values ('library_polygons', (select count(*) from planet_osm_polygon where ((amenity = 'library' or building = 'library' or tags ? 'library') and (osm_id > 0))));

-- How many library polygons have addresses?
insert into collections (query_name, value) values ('library_polygons_with_housenumber', (select count(*) from planet_osm_polygon where ((amenity = 'library' or building = 'library' or tags ? 'library') and (osm_id > 0 and "addr:housenumber" is not null))));

-- How many library polygons have websites?
insert into collections (query_name, value) values ('library_polygons_with_website', (select count(*) from planet_osm_polygon where ((amenity = 'library' or building = 'library' or tags ? 'library') and (osm_id > 0 and (tags ?| array ['website','url'])))));

-- How many library polygons have phone numbers?
insert into collections (query_name, value) values ('library_polygons_with_phone', (select count(*) from planet_osm_polygon where ((amenity = 'library' or building = 'library' or tags ? 'library') and (osm_id > 0 and (tags ? 'phone')))));

-- How many library polygons have opening hours?
insert into collections (query_name, value) values ('library_polygons_with_hours', (select count(*) from planet_osm_polygon where ((amenity = 'library' or building = 'library' or tags ? 'library') and (osm_id > 0 and (tags ? 'opening_hours' or tags ? 'operating_hours')))));

-- How many library polygons have wheelchair accessibility information?
insert into collections (query_name, value) values ('library_polygons_with_wheelchair', (select count(*) from planet_osm_polygon where ((amenity = 'library' or building = 'library' or tags ? 'library') and (osm_id > 0 and (tags ? 'wheelchair')))));

-- How many library polygons have fee information?
insert into collections (query_name, value) values ('library_polygons_with_fee', (select count(*) from planet_osm_polygon where ((amenity = 'library' or building = 'library' or tags ? 'library') and (osm_id > 0 and (tags ? 'fee')))));

  -- library totals
-- Total libraries?
insert into collections (query_name, value) values ('library_total', (select sum(value) from collections where query_name = 'library_points' or query_name = 'library_polygons'));

-- Total libraries with addresses?
insert into collections (query_name, value) values ('library_with_address_total', (select sum(value) from collections where query_name = 'library_points_with_housenumber' or query_name = 'library_polygons_with_housenumber'));

-- Total libraries with website?
insert into collections (query_name, value) values ('library_with_website_total', (select sum(value) from collections where query_name = 'library_points_with_website' or query_name = 'library_polygons_with_website'));

-- Total libraries with phone number?
insert into collections (query_name, value) values ('library_with_phone_number_total', (select sum(value) from collections where query_name = 'library_points_with_phone' or query_name = 'library_polygons_with_phone'));

-- Total libraries with hours?
insert into collections (query_name, value) values ('library_with_hours_total', (select sum(value) from collections where query_name = 'library_points_with_hours' or query_name = 'library_polygons_with_hours'));

-- Total libraries with accessibility information?
insert into collections (query_name, value) values ('library_with_wheelchair_total', (select sum(value) from collections where query_name = 'library_points_with_wheelchair' or query_name = 'library_polygons_with_wheelchair'));

-- Total libraries with fee information?
insert into collections (query_name, value) values ('library_with_fee_total', (select sum(value) from collections where query_name = 'library_points_with_fee' or query_name = 'library_polygons_with_fee'));

-- Percent libraries with address?
insert into collections (query_name, value) values ('library_with_address_pct', (((select value from collections where query_name = 'library_with_address_total')/(select value from collections where query_name = 'library_total')) *100));

-- Percent libraries with website?
insert into collections (query_name, value) values ('library_with_website_pct', (((select value from collections where query_name = 'library_with_website_total')/(select value from collections where query_name = 'library_total')) *100));
  
-- Percent libraries with phone?
insert into collections (query_name, value) values ('library_with_phone_pct', (((select value from collections where query_name = 'library_with_phone_number_total')/(select value from collections where query_name = 'library_total')) *100));

-- Percent libraries with hours?
insert into collections (query_name, value) values ('library_with_hours_pct', (((select value from collections where query_name = 'library_with_hours_total')/(select value from collections where query_name = 'library_total')) *100));

-- Percent libraries with accessibility information?
insert into collections (query_name, value) values ('library_with_wheelchair_pct', (((select value from collections where query_name = 'library_with_wheelchair_total')/(select value from collections where query_name = 'library_total')) *100));

-- Percent libraries with fee information?
insert into collections (query_name, value) values ('library_with_fee_pct', (((select value from collections where query_name = 'library_with_fee_total')/(select value from collections where query_name = 'library_total')) *100));

-- QUERIES FOR MUSEUMS 

  -- museum points
-- How many museum points are there?
insert into collections (query_name, value) values ('museum_points', (select count(*) from planet_osm_point where ((tourism = 'museum' or amenity = 'museum' or building = 'museum' or (tags ? 'museum' and tags -> 'museum' != 'gallery')) and (osm_id > 0))));

-- How many museum points have addresses?
insert into collections (query_name, value) values ('museum_points_with_housenumber', (select count(*) from planet_osm_point where ((tourism = 'museum' or amenity = 'museum' or building = 'museum' or (tags ? 'museum' and tags -> 'museum' != 'gallery')) and (osm_id > 0 and "addr:housenumber" is not null))));

-- How many museum points have websites?
insert into collections (query_name, value) values ('museum_points_with_website', (select count(*) from planet_osm_point where ((tourism = 'museum' or amenity = 'museum' or building = 'museum' or (tags ? 'museum' and tags -> 'museum' != 'gallery')) and (osm_id > 0 and (tags ?| array ['website','url'])))));

-- How many museum points have phone numbers?
insert into collections (query_name, value) values ('museum_points_with_phone', (select count(*) from planet_osm_point where ((tourism = 'museum' or amenity = 'museum' or building = 'museum' or (tags ? 'museum' and tags -> 'museum' != 'gallery')) and (osm_id > 0 and (tags ? 'phone')))));

-- How many museum points have opening hours?
insert into collections (query_name, value) values ('museum_points_with_hours', (select count(*) from planet_osm_point where ((tourism = 'museum' or amenity = 'museum' or building = 'museum' or (tags ? 'museum' and tags -> 'museum' != 'gallery')) and (osm_id > 0 and (tags ? 'opening_hours' or tags ? 'operating_hours')))));

-- How many museum points have wheelchair accessibility information?
insert into collections (query_name, value) values ('museum_points_with_wheelchair', (select count(*) from planet_osm_point where ((tourism = 'museum' or amenity = 'museum' or building = 'museum' or (tags ? 'museum' and tags -> 'museum' != 'gallery')) and (osm_id > 0 and (tags ? 'wheelchair')))));

-- How many museum points have fee information?
insert into collections (query_name, value) values ('museum_points_with_fee', (select count(*) from planet_osm_point where ((tourism = 'museum' or amenity = 'museum' or building = 'museum' or (tags ? 'museum' and tags -> 'museum' != 'gallery')) and (osm_id > 0 and (tags ? 'fee')))));

  -- museum polygons
-- How many museum polygons are there?
insert into collections (query_name, value) values ('museum_polygons', (select count(*) from planet_osm_polygon where ((tourism = 'museum' or amenity = 'museum' or building = 'museum' or (tags ? 'museum' and tags -> 'museum' != 'gallery')) and (osm_id > 0))));

-- How many museum polygons have addresses?
insert into collections (query_name, value) values ('museum_polygons_with_housenumber', (select count(*) from planet_osm_polygon where ((tourism = 'museum' or amenity = 'museum' or building = 'museum' or (tags ? 'museum' and tags -> 'museum' != 'gallery')) and (osm_id > 0 and "addr:housenumber" is not null))));

-- How many museum polygons have websites?
insert into collections (query_name, value) values ('museum_polygons_with_website', (select count(*) from planet_osm_polygon where ((tourism = 'museum' or amenity = 'museum' or building = 'museum' or (tags ? 'museum' and tags -> 'museum' != 'gallery')) and (osm_id > 0 and (tags ?| array ['website','url'])))));

-- How many museum polygons have phone numbers?
insert into collections (query_name, value) values ('museum_polygons_with_phone', (select count(*) from planet_osm_polygon where ((tourism = 'museum' or amenity = 'museum' or building = 'museum' or (tags ? 'museum' and tags -> 'museum' != 'gallery')) and (osm_id > 0 and (tags ? 'phone')))));

-- How many museum polygons have opening hours?
insert into collections (query_name, value) values ('museum_polygons_with_hours', (select count(*) from planet_osm_polygon where ((tourism = 'museum' or amenity = 'museum' or building = 'museum' or (tags ? 'museum' and tags -> 'museum' != 'gallery')) and (osm_id > 0 and (tags ? 'opening_hours' or tags ? 'operating_hours')))));

-- How many museum polygons have wheelchair accessibility information?
insert into collections (query_name, value) values ('museum_polygons_with_wheelchair', (select count(*) from planet_osm_polygon where ((tourism = 'museum' or amenity = 'museum' or building = 'museum' or (tags ? 'museum' and tags -> 'museum' != 'gallery')) and (osm_id > 0 and (tags ? 'wheelchair')))));

-- How many museum polygons have fee information?
insert into collections (query_name, value) values ('museum_polygons_with_fee', (select count(*) from planet_osm_polygon where ((tourism = 'museum' or amenity = 'museum' or building = 'museum' or (tags ? 'museum' and tags -> 'museum' != 'gallery')) and (osm_id > 0 and (tags ? 'fee')))));

  -- museum totals
-- Total museums?
insert into collections (query_name, value) values ('museum_total', (select sum(value) from collections where query_name = 'museum_points' or query_name = 'museum_polygons'));

-- Total museums with addresses?
insert into collections (query_name, value) values ('museum_with_address_total', (select sum(value) from collections where query_name = 'museum_points_with_housenumber' or query_name = 'museum_polygons_with_housenumber'));

-- Total museums with website?
insert into collections (query_name, value) values ('museum_with_website_total', (select sum(value) from collections where query_name = 'museum_points_with_website' or query_name = 'museum_polygons_with_website'));

-- Total museums with phone number?
insert into collections (query_name, value) values ('museum_with_phone_number_total', (select sum(value) from collections where query_name = 'museum_points_with_phone' or query_name = 'museum_polygons_with_phone'));

-- Total museums with hours?
insert into collections (query_name, value) values ('museum_with_hours_total', (select sum(value) from collections where query_name = 'museum_points_with_hours' or query_name = 'museum_polygons_with_hours'));

-- Total museums with accessibility information?
insert into collections (query_name, value) values ('museum_with_wheelchair_total', (select sum(value) from collections where query_name = 'museum_points_with_wheelchair' or query_name = 'museum_polygons_with_wheelchair'));

-- Total museums with fee information?
insert into collections (query_name, value) values ('museum_with_fee_total', (select sum(value) from collections where query_name = 'museum_points_with_fee' or query_name = 'museum_polygons_with_fee'));

-- Percent museums with address?
insert into collections (query_name, value) values ('museum_with_address_pct', (((select value from collections where query_name = 'museum_with_address_total')/(select value from collections where query_name = 'museum_total')) *100));

-- Percent museums with website?
insert into collections (query_name, value) values ('museum_with_website_pct', (((select value from collections where query_name = 'museum_with_website_total')/(select value from collections where query_name = 'museum_total')) *100));
  
-- Percent museums with phone?
insert into collections (query_name, value) values ('museum_with_phone_pct', (((select value from collections where query_name = 'museum_with_phone_number_total')/(select value from collections where query_name = 'museum_total')) *100));

-- Percent museums with hours?
insert into collections (query_name, value) values ('museum_with_hours_pct', (((select value from collections where query_name = 'museum_with_hours_total')/(select value from collections where query_name = 'museum_total')) *100));

-- Percent museums with accessibility information?
insert into collections (query_name, value) values ('museum_with_wheelchair_pct', (((select value from collections where query_name = 'museum_with_wheelchair_total')/(select value from collections where query_name = 'museum_total')) *100));

-- Percent museums with fee information?
insert into collections (query_name, value) values ('museum_with_fee_pct', (((select value from collections where query_name = 'museum_with_fee_total')/(select value from collections where query_name = 'museum_total')) *100));

select * from collections;

