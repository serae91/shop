package backend.shop_entities.order;

public enum OrderStatus {
    PENDING,
    PAYMENT_PENDING,
    PAID,
    PAYMENT_FAILED,
    PROCESSING,
    SHIPPED,
    OUT_FOR_DELIVERY,
    DELIVERED,
    CANCELED,
    RETURNED,
    REFUNDED
}
