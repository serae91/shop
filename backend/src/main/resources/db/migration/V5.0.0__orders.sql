CREATE SEQUENCE orders_sequence
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;

CREATE TABLE orders
(
    id          BIGINT PRIMARY KEY,
    user_id     BIGINT REFERENCES users (id),
    status      VARCHAR(30) DEFAULT 'PENDING',
    total_price NUMERIC(10, 2),
    created_at  TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);