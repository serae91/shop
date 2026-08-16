package backend.model.mapper;

import backend.model.ProductDto;
import backend.model.ProductImageDto;
import backend.persistence.entity.Product;
import jakarta.enterprise.context.ApplicationScoped;

@ApplicationScoped
public class ProductMapper {


    public ProductDto toDto(Product product) {

        if (product == null) {
            return null;
        }

        return new ProductDto(
                product.getId(),
                product.getName(),
                product.getDescription(),
                product.getPrice(),
                product.getStock(),
                product.getCategory(),
                product.getCreatedAt(),
                product.getProductImage() != null
                        ? new ProductImageDto(product.getProductImage().getId(), product.getProductImage().getUrl())
                        : null
        );
    }
}
