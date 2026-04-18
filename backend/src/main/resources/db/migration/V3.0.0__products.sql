CREATE SEQUENCE products_sequence
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;

CREATE TABLE products
(
    id          BIGINT PRIMARY KEY,
    name        VARCHAR(150)   NOT NULL,
    description TEXT,
    price       NUMERIC(10, 2) NOT NULL,
    stock       INT            NOT NULL DEFAULT 0,
    category_id BIGINT REFERENCES categories (id),
    created_at  TIMESTAMP               DEFAULT NOW()
);