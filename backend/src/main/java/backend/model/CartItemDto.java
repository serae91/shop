package backend.model;

public record CartItemDto(
        Long id,
        Integer quantity,
        ProductDto product
) {
}
