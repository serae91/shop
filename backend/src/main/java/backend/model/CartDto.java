package backend.model;

import java.time.Instant;
import java.util.List;

public record CartDto(
        Long id,
        Instant createdAt,
        List<CartItemDto> cartItems
) {
}
