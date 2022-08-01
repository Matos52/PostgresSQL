-- Aká bola tržba z objednávok v máji 2013?
-- Pre overenie správnosti bola táto tržba $37.62.
select sum(i.total)
from invoice i
where EXTRACT(MONTH from i.invoice_date) = 5
    and EXTRACT(YEAR from i.invoice_date) = 2013;

select sum(i.total)
from invoice i
where i.invoice_date BETWEEN '2013-05-01' AND '2013-05-31';

-- Vypíšte prehľadovo, koľkých zákazníkov má obchod
-- z jednotlivých krajín.
-- Výsledok usporiadajte od krajiny s najväčším počtom
-- registrovaných zákazníkov po krajinu s najmenším počtom zákazníkov.
-- Pre overenie správnosti dopytu viete, že najviac zákazníkov
-- pochádza z USA
select max(counts.c) from (
    select country, count(*) as c
                    from customer
                    group by country
                    order by count(*) desc
) as counts;

-- Koľko skladieb sa nachádza v albume War?
-- Pre overenie správnosti ich je 10
select count(*) from track t, album a
where t.album_id = a.album_id
    and a.title = 'War';

-- Zistite celkový čas prehrávania albumu “War” od “U2” v
-- minútach a sekundách.
-- Pre kontrolu správnosti, je celkový čas albumu 42 minút a 9 sekúnd.
select
    sum(t.milliseconds / 1000.0 / 60) as minutes,
    mod(sum(t.milliseconds) / 1000.0, 60) as seconds
from track t
join album a on t.album_id = a.album_id
    and a.title = 'War'
join artist at on at.artist_id = a.artist_id
    and at.name = 'U2';

-- 1. Vypíšte sumárne zisky z predaja po jednotlivých rokoch.
-- Pre overenie správnosti dopytu viete, že celkový zisk z predaja v roku 2009 bol $449.46.
-- Zisk je stĺpec total.

--MATEJ

SELECT EXTRACT(year FROM i.invoice_date) AS year, SUM(i.total) FROM invoice i
GROUP BY year;

-- 2.
-- Vypíšte sumárne, koľko skladieb sa nachádza v jednotlivých playlistoch.
-- Pre overenie správnosti vedzte, že v playliste TV Shows sa nachádza 213 skladieb a v playliste
-- Audiobooks sa nenachádza žiadna skladba (počet je 0).
-- Výsledný zoznam usporiadajte vzostupne podľa názvu playlistu.

SELECT playlist_id ,COUNT(track_id) FROM playlist_track
GROUP BY playlist_id
ORDER BY playlist_id;

-- 3.
-- Zistite čas v sekundách najdlhšej skladby,
-- najkratšej skladby a priemerný čas skladieb albumu War od U2.

select max(a.milliseconds/1000) as longest_song,
       min(a.milliseconds/1000) as shortest_song,
       avg(a.milliseconds/1000) as average_song
from track a
    inner join album al
        on al.album_id = a.album_id
        and al.title = 'War'
    inner join artist at
        on at.artist_id = al.artist_id
        and at.name = 'U2';

--MATEJ

-- SELECT max(t.milliseconds/1000) as longest,
--         min(t.milliseconds/1000) as shortest,
--         avg(t.milliseconds/1000) as average
-- FROM track t
-- INNER JOIN album al
-- ON t.album_id = al.album_id AND al.title = 'War'
-- INNER JOIN artist ar
-- ON al.artist_id = ar.artist_id AND ar.name = 'U2';

--4 Zistite, koľko bolo spolu predaných skladieb z albumu War od U2.
select sum(quantity)
from invoice_line il
    join track t on il.track_id = t.track_id
    join album a on a.album_id = t.album_id
        and a.title = 'War'
where composer = 'U2';

--MATEJ

-- SELECT SUM(quantity) FROM invoice_line il
-- INNER JOIN track t
-- ON t.track_id = il.track_id
-- INNER JOIN album al
-- ON al.album_id = t.album_id AND al.title = 'War';



--5 Vypíšte zisky z predaja podľa jednotlivých krajín za rok 2012.
-- Zoznam zoraďte podľa zisku od najvyšších po najnižšie.
-- Pre overenie správnosti najvyššie zisky v roku 2012 boli dosiahnuté predajom
-- v USA a najnižšie v Holandsku.

select billing_country,
      sum(total) Zisk
from invoice i
where extract(year from i.invoice_date) = 2012
group by billing_country
order by Zisk desc, billing_country;

--MATEJ
-- SELECT billing_country, SUM(total) AS Zisk FROM invoice
-- WHERE EXTRACT(year FROM invoice_date) = '2012'
-- GROUP BY billing_country
-- ORDER BY Zisk DESC;

--6 Koľko už minul dokopy nakupovaním Wyatt Girard?
-- Pre overenie správnosti vedzte, že Wyatt Girard minul nakupovaním $39.62.
select last_name,
      first_name,
      sum(quantity * t.unit_price) minul
from track t
    inner join invoice_line il on t.track_id = il.track_id
    inner join invoice i on il.invoice_id = i.invoice_id
    inner join customer c on i.customer_id = c.customer_id
        and c.last_name = 'Girard'
        and c.first_name = 'Wyatt'
group by last_name, first_name;

select last_name,
      first_name,
      sum(total) minul
from customer c
    inner join invoice i on c.customer_id = i.customer_id
        and c.last_name = 'Girard'
        and c.first_name = 'Wyatt'
group by last_name, first_name;

select last_name,
      first_name,
      sum(total) minul
from customer c, invoice i
    where c.customer_id = i.customer_id
        and c.last_name = 'Girard'
        and c.first_name = 'Wyatt'
group by last_name, first_name;

--7 Aký skladateľ (composer) je najobľúbenejší u zákazníka Wyatta Girarda?
-- (najobľúbenejší - kupoval ho najčastejšie).
-- Pre overenie vedzte, že skladby od trojice Mike Bordin, Billy Gould,
-- Mike Patton si kúpil najviackrát (3x).
select composer, count(composer) from invoice i
    inner join customer c
        on i.customer_id = c.customer_id
        and c.first_name = 'Wyatt'
        and c.last_name = 'Girard'
    inner join invoice_line il
        on i.invoice_id = il.invoice_id
    inner join track t
        on t.track_id = il.track_id
        and t.composer is not null
group by t.composer
order by sum(quantity) desc;

--8 Vypíšte sumárne zisky z predaja za jednotlivé mesiace a roky.
-- Pre overenie správnosti dopytu viete, že v apríli 2011 bol celkový zisk
-- z predaja $51.62.
select extract(year from invoice_date) rok,
       extract(month from invoice_date) mesiac,
       sum(total)
from invoice
group by rok, mesiac
order by rok, mesiac;

--9 Vypíšte všetky objednávky smerujúce do Veľkej Británie v mesiaci máj
-- 2013, ktoré boli vyššie ako $2.
-- O objednávke vypíšte len jej dátum a celkovú sumu.
-- Pre overenie správnosti vedzte, že v danom mesiaci boli len 2 objednávky.

select extract(year from invoice_date) as year,
       extract(month from invoice_date) as month,
       invoice_date,
       sum(quantity * unit_price)
from invoice
    inner join invoice_line il
    on invoice.invoice_id = il.invoice_id
where extract(year from invoice_date) = 2013
    and extract(month from invoice_date) = 5
    and billing_country = 'United Kingdom'
    and total > 2
group by invoice_date, year, month
order by year, month;

--10 Koľko jedinečných audio záznamov (a nie video)
-- bolo kúpených nemeckými zákazníkmi? A aký veľký obrat urobili?
-- Aby ste si overili svoj výsledok, tak nemeckí zákazníci spolu kúpili
-- 146 jedinečných skladieb za 144.54.

select count(i.invoice_id),
       sum(t.unit_price),
       c.country
from customer c
    inner join invoice i
        on c.customer_id = i.customer_id
        and country like 'Germany'
    inner join invoice_line il
        on i.invoice_id = il.invoice_id
    inner join track t
        on il.track_id = t.track_id
    inner join media_type mt
        on t.media_type_id = mt.media_type_id
        and mt.name like '%audio%'
group by c.country;

select count(i.invoice_id),
       sum(t.unit_price),
       c.country
from customer c, invoice i, invoice_line il, track t, media_type mt
    where c.customer_id = i.customer_id
    and i.invoice_id = il.invoice_id
    and il.track_id = t.track_id
    and t.media_type_id = mt.media_type_id
    and country like 'Germany'
    and mt.name like '%audio%'
group by c.country;

--11 Niektoré skladby v zozname všetkých skladieb majú rovnaké mená.
-- Zistite, ktoré to sú (počet výskytov skladieb s rovnakým menom
-- je väčší ako 1) a vypíšte o nich nasledovné informácie:
--   a. názov skladby
--   b. počet výskytov skladby
-- Výsledný zoznam usporiadajte v poradí od skladieb s najčastejším výskytom názvu po najmenej.
select t.name,
       count(t.name) as count
from track t
group by t.name
having count(t.name) > 1
order by count;





