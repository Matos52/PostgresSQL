-- 1. Vypíšte zoznam skladieb, ktoré neboli kúpené ani raz.
--     Pre overenie správnosti dopytu vedzte, že počet týchto skladieb je 1519.

SELECT t.name
FROM track t
INNER JOIN invoice_line il
    ON t.track_id = il.track_id
INNER JOIN invoice i
    ON i.invoice_id = il.invoice_id
WHERE