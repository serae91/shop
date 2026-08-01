package backend.model;

public record AddCartItemRequest(
        Long productId,
        Integer quantity
) {
}
