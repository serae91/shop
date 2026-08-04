CREATE SEQUENCE product_images_sequence
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;

CREATE TABLE product_images
(
    id         BIGINT PRIMARY KEY,
    product_id BIGINT REFERENCES products (id),
    url        TEXT NOT NULL
);