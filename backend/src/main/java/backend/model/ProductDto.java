package backend.model;

import backend.persistence.entity.Category;

import java.math.BigDecimal;
import java.time.Instant;

public record ProductDto(
        Long id,
        String name,
        String description,
        BigDecimal price,
        Integer stock,
        Category category,
        Instant createdAt,
        ProductImageDto productImage
) {
}
