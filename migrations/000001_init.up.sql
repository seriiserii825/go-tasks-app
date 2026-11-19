CREATE SCHEMA if not exists todoapp;

CREATE TABLE todoapp.users (
    id SERIAL PRIMARY KEY,
    version BIGINT NOT NULL DEFAULT 1,
    full_name VARCHAR(100) NOT NULL CHECK(char_length(full_name) BETWEEN 3 AND 100),
    phone_number VARCHAR(15) CHECK(
      phone_number ~ '^\+[1-9]][0-9]{9,14}$'
    )
);
