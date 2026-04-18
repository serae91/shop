package backend.shop_api.user.core;

import backend.shop_entities.shop_user.ShopUser;
import com.blazebit.persistence.CriteriaBuilderFactory;
import com.blazebit.persistence.view.EntityViewManager;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import jakarta.persistence.EntityManager;

@ApplicationScoped
public class UserService {

    @Inject
    UserRepository userRepository;
    @Inject
    EntityManager entityManager;
    @Inject
    EntityViewManager entityViewManager;
    @Inject
    CriteriaBuilderFactory criteriaBuilderFactory;

    public ShopUser getUserById(final Long userId) {
        return userRepository.findById(userId);
    }

}

