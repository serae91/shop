package backend.shop_api.user.usecase.update;

import backend.shop_entities.shop_user.ShopUserUpdateView;
import com.blazebit.persistence.view.EntityViewManager;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import jakarta.persistence.EntityManager;
import jakarta.transaction.Transactional;

@ApplicationScoped
public class UserUpdateService {
    @Inject
    EntityManager entityManager;
    @Inject
    EntityViewManager entityViewManager;

    @Transactional
    public void updateUser(final ShopUserUpdateView userUpdateView) {
        entityViewManager.save(entityManager, userUpdateView);
    }
}
