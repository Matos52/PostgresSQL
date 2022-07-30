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

select
    sum(i.total) as sum,
    extract(year from i.invoice_date) as year
from invoice i
group by year;

-- 2.
-- Vypíšte sumárne, koľko skladieb sa nachádza v jednotlivých playlistoch.
-- Pre overenie správnosti vedzte, že v playliste TV Shows sa nachádza 213 skladieb a v playliste
-- Audiobooks sa nenachádza žiadna skladba (počet je 0).
-- Výsledný zoznam usporiadajte vzostupne podľa názvu playlistu.

SELECT
    count(pt.track)
FROM playlist pl
GROUP BY pl.name;

-- 3.
-- Zistite čas v sekundách najdlhšej skladby,
-- najkratšej skladby a priemerný čas skladieb albumu War od U2.

select distinct a.name, a.milliseconds/1000 as seconds
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

-- 4. Zistite, koľko bolo spolu predaných skladieb z albumu War od U2.

SELECT t.name, al.title
FROM track t
INNER JOIN album al
ON al.album_id = t.album_id

-- 5. Vypíšte zisky z predaja podľa jednotlivých krajín za rok 2012.
-- Zoznam zoraďte podľa zisku od najvyšších po najnižšie.
-- Pre overenie správnosti najvyššie zisky v roku 2012 boli dosiahnuté
-- predajom v USA a najnižšie v Holandsku.





