package backend.shop_entities.payment;

public enum PaymentStatus {
    PENDING,
    PROCESSING,
    SUCCEEDED,
    FAILED,
    CANCELED,
    AUTHORIZED,
    CAPTURED,
    REFUNDED,
    PARTIALLY_REFUNDED,
    EXPIRED
}
