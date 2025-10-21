CREATE SEQUENCE product_sequence
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;

CREATE TABLE product
(
    id             BIGINT                 PRIMARY KEY,
    name           CHARACTER VARYING(150) NOT NULL UNIQUE,
    description    TEXT                   NOT NULL,
    price          NUMERIC(10,2)          NOT NULL CHECK (price >= 0),
    stock_quantity INTEGER                NOT NULL CHECK (stock_quantity >= 0),
    category_id    BIGINT                 REFERENCES category(id),
    created_at     TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at     TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);