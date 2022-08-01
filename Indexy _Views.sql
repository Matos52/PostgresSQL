--------------INDEX-----------------

CREATE INDEX idx_track_composer
ON track(composer ASC);

-- EXPLAIN SELECT name, composer FROM track
-- WHERE composer = 'U2'

-- DROP INDEX idx_track_composer;

--------------VIEW-----------------

create or replace view savings as(
select t.track_id, t.name, t.album_id, t.media_type_id, t.genre_id,
       t.composer, t.milliseconds, t.bytes, trunc(t.unit_price*0.9,2) as unit_price
from track t
inner join album al on t.album_id = al.album_id
inner join artist a on a.artist_id = al.artist_id
where a.name = 'U2');

drop view savings;

-- 1.
-- Vytvorte pohľad full_track_list, ktorý vypíše všetky skladby obchodu.
-- Do zoznamu zahrňte aj akciové skladby z pohľadu savings.
-- Skladby vo výslednom zozname neduplikujte - tzn.,
-- že skladby, ktoré sú zľavnené, sa budú v zozname nachádzať len raz s akciovou cenou.
-- Výsledný zoznam usporiadajte vzostupne podľa názvu skladby.

CREATE OR REPLACE full_track_list AS(

)

-- 2.
-- Vytvorte pohľad stats, ktorý bude zobrazovať štatistické údaje o zisku spoločnosti za
--     jednotlivé obdobia zoradený od najnovšieho záznamu po najstarší.
--     Vo výsledku zobrazte 3 stĺpce: rok, mesiac a zisk v danom mesiaci vyjadrený
--     súčtom všetkých vystavených faktúr v danom období.

CREATE OR REPLACE stats AS(
    SELECT EXTRACT(year FROM )
)
