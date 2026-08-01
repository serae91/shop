package backend.model.mapper;

import backend.model.ProductDto;
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
                product.getPrice(),
                product.getProductImage() != null
                        ? product.getProductImage().getUrl()
                        : null
        );
    }
}
