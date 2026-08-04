CREATE SEQUENCE order_items_sequence
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;

CREATE TABLE order_items
(
    id            BIGINT PRIMARY KEY,
    order_id      BIGINT REFERENCES orders (id) ON DELETE CASCADE,
    product_id    BIGINT REFERENCES products (id),
    quantity      INT            NOT NULL,
    price_at_time NUMERIC(10, 2) NOT NULL
);