CREATE SEQUENCE order_item_sequence
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;

CREATE TABLE order_item
(
    id                 BIGINT        PRIMARY KEY,
    order_id           BIGINT        REFERENCES shop_order(id) ON DELETE CASCADE,
    product_id         BIGINT        REFERENCES product(id),
    quantity           INTEGER       NOT NULL CHECK (quantity > 0),
    price_at_purchase  NUMERIC(10,2) NOT NULL CHECK (price_at_purchase >= 0)
);