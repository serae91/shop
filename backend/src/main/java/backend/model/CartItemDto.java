package backend.model;

public record CartItemDto(
        Long id,
        ProductDto product,
        Integer quantity
) {
}
