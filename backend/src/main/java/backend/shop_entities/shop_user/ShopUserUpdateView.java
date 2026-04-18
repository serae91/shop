package backend.shop_entities.shop_user;

import com.blazebit.persistence.view.EntityView;
import com.blazebit.persistence.view.IdMapping;
import com.blazebit.persistence.view.UpdatableEntityView;

@EntityView(ShopUser.class)
@UpdatableEntityView
public interface ShopUserUpdateView {
    @IdMapping
    Long getId();
}
