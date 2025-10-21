CREATE SEQUENCE product_image_sequence
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;

CREATE TABLE product_image
(
    id         BIGINT                 PRIMARY KEY,
    product_id BIGINT                 REFERENCES product(id),
    url        TEXT                   NOT NULL ,
    alt_text   CHARACTER VARYING(150) NOT NULL
);