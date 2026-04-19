CREATE SEQUENCE wish_list_items_sequence
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;

CREATE TABLE wish_list_items
(
    id         BIGINT PRIMARY KEY,
    user_id    BIGINT REFERENCES users (id),
    product_id BIGINT REFERENCES products (id)
);