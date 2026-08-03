CREATE SEQUENCE payments_sequence
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;

CREATE TABLE payments
(
    id             BIGINT PRIMARY KEY,
    order_id       BIGINT REFERENCES orders (id),
    provider       VARCHAR(50),
    status         VARCHAR(30),
    transaction_id TEXT
);