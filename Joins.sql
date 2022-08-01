-- SELECT
--     ar.name,
--     al.title
-- FROM
--     artist ar
-- INNER JOIN album al
--     ON ar.artist_id = al.artist_id;

-- SELECT
--     name,
--     title
-- FROM artist a
-- INNER JOIN album al ON (a.artist_id = al.artist_id);

-- SELECT * FROM artist ar
-- INNER JOIN album al ON (ar.artist_id = al.artist_id) AND ar.name = 'U2';

-- SELECT * FROM artist ar, album al
-- WHERE (ar.artist_id = al.artist_id) AND ar.name = 'U2';



--------------------HOMEWORK-------------------------------

-- 3.

-- SELECT track.name, media_type.name, media_type.media_type_id FROM media_type
-- INNER JOIN track
-- ON media_type.media_type_id = track.media_type_id
-- WHERE media_type.media_type_id = 3;

-- 4.

-- SELECT track.name, track.composer, track.milliseconds/1000 AS seconds FROM track
-- INNER JOIN playlist_track
-- ON track.track_id = playlist_track.track_id
-- INNER JOIN playlist
-- ON playlist_track.playlist_id = playlist.playlist_id
-- WHERE playlist.playlist_id = '5' AND track.composer IS NOT NULL
-- ORDER BY track.name;

-- 5.

-- SELECT DISTINCT album.title FROM album
-- INNER JOIN track
-- ON album.album_id = track.album_id
-- INNER JOIN genre
-- ON track.genre_id = genre.genre_id
-- WHERE genre.genre_id = '10'

-- 6.

-- SELECT track.name, artist.name, album.title, invoice.total,
--        customer.first_name || ' ' || customer.last_name AS customer_name
-- FROM track, artist, album, invoice, customer
-- INNER JOIN album ON

-- 7.

-- SELECT customer.first_name || ' ' || customer.last_name AS full_name, customer.city
-- FROM customer
-- INNER JOIN employee
-- ON customer.city = employee.city;

-- 8.

-- SELECT employee.first_name || ' ' || employee.last_name AS full_name
-- FROM employee
-- WHERE reports_to = '1';

-- 9. NEFUNGUJE

-- SELECT DISTINCT artist.name FROM artist
-- INNER JOIN album
-- ON artist.artist_id = album.artist_id
-- WHERE (album.artist_id != album.album_id);

-- 10. NEFUNGUJE

-- SELECT track.name, track.composer FROM track
-- INNER JOIN playlist_track
-- ON track.track_id = playlist_track.track_id
-- INNER JOIN playlist
-- ON playlist.playlist_id = playlist_track.playlist_id
-- WHERE playlist.playlist_id = '17'

-- 11. NEFUNGUJE

-- SELECT DISTINCT customer.first_name || ' ' || customer.last_name AS full_name FROM customer
-- INNER JOIN invoice
-- ON customer.customer_id = invoice.customer_id
-- WHERE EXTRACT(year FROM invoice_date) != 2012;

-- 12. NEFUNGUJE

-- INSERT INTO customer(first_name)
-- VALUES ('Matej')

-- SELECT customer.customer_id ,customer.first_name, customer.last_name FROM customer
-- INNER JOIN invoice
-- ON customer.customer_id = invoice.customer_id;

-- 13.

SELECT employee.first_name, employee.last_name, employee.birth_date FROM employee
INNER JOIN

    -----------------GITHUBMISKA------------------------

-- SELECT * FROM category CROSS JOIN links
-- WHERE category_id = id;
--
-- SELECT * FROM category c CROSS JOIN links l
-- WHERE c.last_update = l.last_update;
-- SELECT * FROM category, links;

SELECT c.customer_id,
	i.customer_id,
	first_name,
	last_name,
	total,
	invoice_date
FROM
	customer as c
INNER JOIN invoice as i
    ON i.customer_id =
       c.customer_id
ORDER BY invoice_date;

SELECT name, title
FROM artist a
    INNER JOIN album al
        ON (a.artist_id = al.artist_id);

SELECT *
FROM artist ar
    INNER JOIN album al
        ON (ar.artist_id = al.artist_id) AND ar.name = 'U2';

SELECT * FROM artist ar, album al
WHERE ar.artist_id = al.artist_id AND ar.name = 'U2';

-- 3
-- select a.name, b.*
-- from track b,media_type a
-- where b.media_type_id = a.media_type_id
--   and b.media_type_id = 3;

select a.name, b.*
    from track b
    join media_type a
        on b.media_type_id = a.media_type_id
where a.name = 'Protected MPEG-4 video file';
--Protected MPEG-4 video file // media_type_id 3

-- 4
select t.name,
       t.composer,
       t.milliseconds / 1000 as seconds
from playlist_track plt
    INNER JOIN playlist p
        ON plt.playlist_id = p.playlist_id AND p.name = '90’s Music'
    INNER JOIN track t
        ON plt.track_id = t.track_id
WHERE composer IS NOT NULL
ORDER BY t.name;

select t.name, t.composer, t.milliseconds / 1000 as seconds
from playlist_track pt, playlist p, track t
where pt.playlist_id = p.playlist_id
    and p.name = '90’s Music'
    and pt.track_id = t.track_id
    and composer is not null
order by t.name;

select t.name, t.composer, t.milliseconds / 1000 as seconds
from track t, (
    select * from playlist_track pt, playlist p
    where pt.playlist_id = p.playlist_id and p.name = '90’s Music'
) ppt
where ppt.track_id = t.track_id
      and composer is not null
order by t.name;

-- MATEJ

-- SELECT t.name, t.composer, ROUND(t.milliseconds/1000,2) AS seconds
-- FROM track t
-- INNER JOIN playlist_track plt
-- ON plt.track_id = t.track_id
-- INNER JOIN playlist p
-- ON p.playlist_id = plt.playlist_id
-- WHERE p.playlist_id = 5 AND t.composer IS NOT NULL;

--5
select distinct a.title, g.name as genre
from album a
    inner join track t
        on a.album_id = t.album_id
    inner join genre g
        on t.genre_id = g.genre_id
where g.name = 'Soundtrack';

--efektivnejsie, vybera najprv len soundtrack a az potom pripaja albumy
select distinct a.title, g.name as genre
from track t
    inner join genre g
        on g.genre_id = t.genre_id
        and g.name = 'Soundtrack'
    inner join album a
        on t.album_id = a.album_id;

select distinct a.title, g.name as genre
from album a, track t, genre g
where a.album_id = t.album_id
    and t.genre_id = g.genre_id
    and g.name = 'Soundtrack';

--MATEJ

-- SELECT DISTINCT a.title FROM album a
-- INNER JOIN track t
-- ON a.album_id = t.album_id
-- INNER JOIN genre g
-- ON g.genre_id = t.genre_id
-- WHERE g.name = 'Soundtrack';

--Vypíšte objednávku na základe jej id s jej položkami v tvare:
-- *číslo objednávky,
-- *názov skladby,
-- názov jej interpreta (nie skladateľa),
-- *názov albumu,
-- *jednotková cena,
-- *meno zákazníka (v jednom stĺpci kombinácia mena a priezviska)
--6
select
    i.invoice_id,
    t.name,
    artist.name,
    a.title,
    il.unit_price,
    c.first_name || ' ' || c.last_name as full_name
from invoice i
    join customer c
        on c.customer_id = i.customer_id
    join invoice_line il
        on i.invoice_id = il.invoice_id
    join track t
        on t.track_id = il.track_id
    join album a
        on a.album_id = t.album_id
    join artist
        on artist.artist_id = a.artist_id
where i.invoice_id = 5;

select
    i.invoice_id,
    t.name,
    artist.name,
    a.title,
    il.unit_price,
    c.first_name || ' ' || c.last_name as full_name
from invoice i, customer c, invoice_line il, track t, album a, artist
where c.customer_id = i.customer_id
    and i.invoice_id = il.invoice_id
    and t.track_id = il.track_id
    and a.album_id = t.album_id
    and artist.artist_id = a.artist_id
    and i.invoice_id = 5;

--7
select * from employee e
    where reports_to IS NULL; --toto je ten jeden, ktory nema sefa

select c.* from customer c
    inner join employee e
    on c.city = e.city
    and reports_to IS NULL;

--MATEJ

-- SELECT c.first_name || ' ' || c.last_name AS full_name FROM customer c
-- INNER JOIN employee e
-- ON c.city = e.city
-- WHERE e.reports_to IS NULL;

--8
select b.* from employee a
     left join employee b
         on a.employee_id = b.reports_to
where a.reports_to is null;

select * from employee e
    where e.reports_to = 1;

--MATEJ

-- SELECT a.* FROM employee a
-- LEFT JOIN employee b
-- ON a.employee_id = b.employee_id
-- WHERE a.reports_to IS NULL;


--9 Zistite, ktorí artisti nevydali ani jeden album.
-- Vypíšte ich mená. Pre overenie správnosti vedze, že ich počet je 71.
select
    alb.artist_id,art.artist_id,
    alb.name from artist alb
    left join album art
        on alb.artist_id = art.artist_id
where art.artist_id is null;
--order by b.artist_id nulls first;

--MATEJ

SELECT ar.name, ar.artist_id, al.artist_id FROM artist ar
LEFT JOIN album al
ON ar.artist_id = al.artist_id
WHERE al.artist_id IS NULL;


--10
-- Vypíšte zoznam všetkých skladieb (ich názvy spolu s názvom skladateľa),
-- ktoré nepatria do playlistu 'Heavy Metal Classic'.
-- Pre overenie správnosti je počet týchto skladieb 3477
-- (všetky skladby - zoznam skladieb playlistu)
-- nespravne riesenie:
-- select distinct t.track_id, t.name, t.composer from track t
--     join playlist_track pt on t.track_id = pt.track_id
--     join playlist p on p.playlist_id = pt.playlist_id
-- WHERE p.name != 'Heavy Metal Classic';

select distinct t2.track_id, t2.name, t2.composer
from track t
inner join playlist_track pt on t.track_id = pt.track_id
inner join playlist p on pt.playlist_id = p.playlist_id and p.name = 'Heavy Metal Classic'
right join track t2 on t.track_id = t2.track_id
where t.track_id is null;


--MATEJ
--NEROZUMIEM


--11
select B.invoice_id, A.* from customer A
    left join invoice B
        on A.customer_id = B.customer_id
            and extract(year from B.invoice_date) = 2012
where invoice_id is null
--order by invoice_id nulls first;
order by A.last_name, A.first_name asc;

insert into customer (customer_id, first_name, last_name, email)
    values (100, 'Michaela', 'Bacikova', 'michaela.bacikova@tuke.sk');

--MATEJ

-- SELECT * FROM customer c
-- LEFT JOIN invoice i
-- ON c.customer_id = i.customer_id AND EXTRACT(year FROM invoice_date) = '2012'
-- WHERE invoice_id IS NULL;

--12
select a.customer_id, a.first_name, a.last_name from customer a
    left join invoice b
        on a.customer_id = b.customer_id
where invoice_id is null;

--MATEJ

-- INSERT INTO customer(customer_id, first_name, last_name, email)
-- VALUES (100, 'Matej', 'Regec', 'Matej.Regec@gmail.com');
--
-- SELECT a.customer_id, a.first_name, a.last_name FROM customer a
-- LEFT JOIN invoice i
-- ON a.customer_id = i.customer_id
-- WHERE i.invoice_id IS NULL;

--13
select a.employee_id, b.employee_id, a.first_name, a.last_name, a.birth_date, b.birth_date from employee a
left join employee b
on a.birth_date > b.birth_date
where b.employee_id is null;

--MATEJ

-- SELECT a.first_name, a.last_name, a.birth_date FROM employee a
-- LEFT JOIN employee b
-- ON a.birth_date > b.birth_date
-- WHERE b.birth_date IS NULL;


--14
select b.milliseconds / 1000 as b_seconds, b.* --c.*
from media_type a
        inner join track b
            on a.media_type_id = b.media_type_id
                   and a.name = 'Protected MPEG-4 video file'
        left join track c
            on b.milliseconds < c.milliseconds
where c.track_id is null;

--MATEJ

-- SELECT * FROM media_type mt
-- INNER JOIN track a
-- ON mt.media_type_id = a.media_type_id AND mt.media_type_id = 3
-- LEFT JOIN track b
-- ON b.milliseconds > a.milliseconds
-- WHERE b.milliseconds IS NULL;

--15
select b.name, a.title, at.name, b.milliseconds/1000 as seconds
from album a
    inner join track b
        on a.album_id = b.album_id
        and a.title = 'War'
    inner join artist at
        on at.artist_id = a.artist_id
        and at.name = 'U2'
    left join track c
        on b.milliseconds < c.milliseconds
        and b.album_id = c.album_id
where c.track_id is null;

--MATEJ

-- SELECT t.name, (t.milliseconds/1000) AS seconds, al.title, ar.name FROM track t
-- INNER JOIN album al
-- ON t.album_id = al.album_id AND al.title = 'War'
-- INNER JOIN artist ar
-- ON al.artist_id = ar.artist_id AND ar.name = 'U2'
-- LEFT JOIN track b
-- ON b.milliseconds > t.milliseconds AND t.album_id = b.album_id
-- WHERE b.track_id IS NULL;

--16
select distinct a.name, a.name, a.milliseconds/1000 as seconds
from track a
    inner join album al
        on al.album_id = a.album_id
        and al.title = 'War'
    inner join artist at
        on at.artist_id = al.artist_id
        and at.name = 'U2'
    left join track b on b.milliseconds > a.milliseconds
         and b.album_id = al.album_id
    left join track c ON c.milliseconds < a.milliseconds
         and c.album_id = al.album_id
where c.name is null or b.name is null;

--kto ma datum narodenia menej ako dnesny datum + 100
--nefunguje na prelome rokov
SELECT first_name || ' ' || last_name AS full_name, birth_date FROM employee
    WHERE EXTRACT(DAY FROM birth_date)
        BETWEEN EXTRACT(DAY FROM CURRENT_DATE)
        AND EXTRACT(DAY FROM CURRENT_DATE)+100;

--ide aj pri prelome rokov
SELECT first_name || ' ' || last_name AS full_name, birth_date FROM employee
    WHERE EXTRACT(DOY FROM birth_date)
        BETWEEN EXTRACT(DOY FROM CURRENT_DATE)
        AND EXTRACT(DOY FROM CURRENT_DATE)+100;

--MATEJ

-- SELECT DISTINCT t.name, (t.milliseconds/1000) AS seconds, al.title, ar.name FROM track t
-- INNER JOIN album al
-- ON t.album_id = al.album_id AND al.title = 'War'
-- INNER JOIN artist ar
-- ON al.artist_id = ar.artist_id AND ar.name = 'U2'
-- LEFT JOIN track b
-- ON b.milliseconds > t.milliseconds AND t.album_id = b.album_id
-- LEFT JOIN track c
-- ON c.milliseconds < t.milliseconds AND t.album_id = c.album_id
-- WHERE b.track_id IS NULL OR c.track_id IS NULL;