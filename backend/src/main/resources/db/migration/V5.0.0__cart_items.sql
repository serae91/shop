CREATE SEQUENCE cart_items_sequence
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;

CREATE TABLE cart_items
(
    id         BIGINT PRIMARY KEY,
    cart_id    BIGINT REFERENCES carts (id) ON DELETE CASCADE,
    product_id BIGINT REFERENCES products (id),
    quantity   INT NOT NULL DEFAULT 1
);