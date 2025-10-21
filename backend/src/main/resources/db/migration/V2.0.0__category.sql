CREATE SEQUENCE category_sequence
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;

CREATE TABLE category
(
    id        BIGINT                 PRIMARY KEY,
    name      CHARACTER VARYING(100) NOT NULL,
    parent_id BIGINT    REFERENCES category(id)
);