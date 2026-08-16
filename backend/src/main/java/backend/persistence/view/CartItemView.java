package backend.persistence.view;

import backend.persistence.entity.CartItem;
import com.blazebit.persistence.view.EntityView;
import com.blazebit.persistence.view.IdMapping;

@EntityView(CartItem.class)
public interface CartItemView {
    @IdMapping
    Long getId();

    ProductView getProduct();

    Integer getQuantity();
}
