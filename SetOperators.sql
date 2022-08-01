-- 1. Vypíšte zoznam všetkých umelcov v databáze,
--     ktorý vznikne spojením záznamov z tabuľky Artist a Track.
--     Výsledný zoznam usporiadajte podľa abecedy.
-- Pre overenie správnosti vášho dopytu bude výsledný zoznam obsahovať 1080 záznamov.

SELECT a.name FROM artist a
UNION
SELECT t.composer FROM track t
ORDER BY name nulls first;

-- 2. Vypíšte zoznam zamestnancov a zákazníkov, ktorí pochádzajú z Kanady.
--     O týchto osobách vypíšte ich priezvisko, meno, adresu, mesto a krajinu.
--     Výpis rozšírte o stĺpec type, do ktorého v prípade zamestnancov vypíšte
--     reťazec "employee" a v prípade zákazníkov vypíšte reťazec "customer".
--     Výsledný zoznam usporiadajte vzostupne podľa priezviska a mena osoby.

SELECT first_name, last_name,'customer' AS type, address, city, country FROM customer
WHERE country = 'Canada'
UNION
SELECT first_name, last_name,'employee' AS type, address, city, country FROM employee
WHERE country = 'Canada';

-- 3. Zistite rozdiel medzi umelcami v tabuľke Artist (stĺpec name)
--     a v tabuľke Track (stĺpec composer).
--     Ak teda odčítate od artistov všetkých composerov, počet výsledkov je 228.

SELECT name FROM artist
EXCEPT
SELECT composer FROM track
ORDER BY name NULLS FIRST;

-- 4. BONUS: Vypíšte zoznam všetkých skladieb (ich názvy spolu s názvom skladateľa),
--     ktoré nepatria do playlistu 'Heavy Metal Classic'.
--     Pre overenie správnosti je počet týchto skladieb 3477.

SELECT name, composer FROM track
