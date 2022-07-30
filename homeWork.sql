-- CREATE TABLE links (
--     id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
--     url VARCHAR(250) NOT NULL,
--     name VARCHAR(50) NOT NULL,
--     last_update TIMESTAMP DEFAULT now() -- current_timestamp
-- );
--
-- INSERT INTO
--     links(url, name)
-- VALUES
--     ('https://www.google.com','Google'),
--     ('https://www.yahoo.com','Yahoo'),
--     ('https://www.bing.com','Bing');

-- INSERT INTO links
-- VALUES(DEFAULT, 'http://kpi.fei.tuke.sk', 'KPI homepage', '2022-06-01')
-- RETURNING id;

-- UPDATE links
-- SET last_update = '2020-08-01',
--     name = 'Bing page'
-- WHERE id = 3;

-- DELETE FROM links
-- WHERE id = 1;
--
-- select * from links;

-- ALTER TABLE links RENAME TO urls;

-- INSERT INTO
--     urls(url, name)
-- VALUES
--     ('https://www.microsoft.com','Microsoft');

-- select * from urls;

-- DELETE FROM urls
-- WHERE id = 2;

select * from urls;



UPDATE customer
set sex = 'F'
WHERE first_name IN ('Helena', 'Kara', 'Fernanda', 'Jenifer', 'Kathy', 'Heather',
                     'Julia', 'Martha', 'Ellie', 'Madalena', 'Hannah', 'Camille',
                     'Isabelle', 'Emma', 'Puja');

SELECT * FROM customer;