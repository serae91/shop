package backend.shop_api.user.core;

import backend.shop_entities.user.User;
import io.quarkus.hibernate.orm.panache.PanacheRepository;
import jakarta.enterprise.context.ApplicationScoped;

@ApplicationScoped
public class UserRepository implements PanacheRepository<User> {
    public User findByEmail(final String email) {
        return find("email", email).singleResult();
    }

    public boolean doesUsernameExist(final String username) {
        final User user = find("username", username).firstResult();
        return user != null;
    }
}
