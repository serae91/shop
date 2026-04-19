package backend.persistence.view;

import backend.persistence.entity.Category;
import backend.persistence.entity.Product;
import com.blazebit.persistence.view.EntityView;
import com.blazebit.persistence.view.IdMapping;

import java.math.BigDecimal;
import java.time.Instant;

@EntityView(Product.class)
public interface ProductView {
    @IdMapping
    Long getId();

    String getName();

    String getDescription();

    BigDecimal getPrice();

    Integer getStock();

    Category getCategory();

    Instant getCreatedAt();

    ProductImageView getProductImage();
}
