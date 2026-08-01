package backend.persistence.repository;

import backend.persistence.entity.User;
import io.quarkus.hibernate.orm.panache.PanacheRepository;
import jakarta.enterprise.context.ApplicationScoped;

import java.util.Optional;

@ApplicationScoped
public class UserRepository implements PanacheRepository<User> {
    public Optional<User> findByEmail(final String email) {
        return find("email", email).singleResultOptional();
    }

    public boolean doesUsernameExist(final String username) {
        final User user = find("username", username).firstResult();
        return user != null;
    }
}
