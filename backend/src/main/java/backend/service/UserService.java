package backend.service;

import backend.persistence.entity.User;
import backend.persistence.repository.UserRepository;
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

    public User getUserById(final Long userId) {
        return userRepository.findById(userId);
    }

}

