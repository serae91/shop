package backend.bl_api.user.usecase.update;

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
    public void updateUser(final BLUserUpdateView userUpdateView) {
        entityViewManager.save(entityManager, userUpdateView);
    }
}
