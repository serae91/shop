package backend.persistence.view;

import backend.persistence.entity.Cart;
import com.blazebit.persistence.view.EntityView;
import com.blazebit.persistence.view.IdMapping;

import java.time.Instant;
import java.util.List;

@EntityView(Cart.class)
public interface CartView {
    @IdMapping
    Long getId();

    Instant getCreatedAt();

    List<CartItemView> getCartItems();
}
