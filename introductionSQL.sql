-- DROP TABLE IF EXISTS person, color;



-- CREATE TABLE color (
-- color_id INT GENERATED ALWAYS AS IDENTITY,
-- color_name VARCHAR NOT NULL
-- );

CREATE TABLE person (
    id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(20) NOT NULL,
    surname VARCHAR(20) NOT NULL,
    age INT NOT NULL,
    birth_date DATE,
    address VARCHAR (25),
    identification_number UUID NOT NULL UNIQUE,
    salary DECIMAL(18,2) DEFAULT 5000.0,
    CHECK(salary > 0)
);

