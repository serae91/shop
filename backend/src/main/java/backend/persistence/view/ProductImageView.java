package backend.persistence.view;

import backend.persistence.entity.ProductImage;
import com.blazebit.persistence.view.EntityView;
import com.blazebit.persistence.view.IdMapping;

@EntityView(ProductImage.class)
public interface ProductImageView {
    @IdMapping
    Long getId();

    String getUrl();
}
