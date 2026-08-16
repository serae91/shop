package backend.service;

import backend.persistence.entity.User;
import backend.persistence.repository.UserRepository;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import jakarta.transaction.Transactional;
import org.eclipse.microprofile.jwt.JsonWebToken;

import java.util.Objects;
import java.util.Optional;
import java.util.UUID;

@ApplicationScoped
public class CurrentUserService {

    @Inject
    JsonWebToken jwt;

    @Inject
    UserRepository userRepository;

    @Transactional
    public User getCurrentUser() {

        final UUID keycloakId = getValidatedKeycloakId();

        final Optional<User> existing =
                userRepository.findByKeycloakId(keycloakId);

        return existing.map(this::getUpdatedUser).orElseGet(() -> getNewUser(keycloakId));

    }

    private UUID getValidatedKeycloakId() {
        try {
            return UUID.fromString(jwt.getSubject());
        } catch (IllegalArgumentException e) {
            throw new IllegalStateException(
                    "Keycloak subject is not a valid UUID",
                    e
            );
        }
    }

    private User getUpdatedUser(final User user) {
        if (hasChanged(user)) {
            setFields(user);
        }

        return user;
    }

    private User getNewUser(final UUID keycloakId) {
        final User user = new User();

        user.setKeycloakId(keycloakId);
        setFields(user);

        userRepository.persist(user);

        return user;
    }

    private boolean hasChanged(final User user) {
        final String username = jwt.getClaim("preferred_username");
        final String email = jwt.getClaim("email");

        return !Objects.equals(username, user.getUsername())
                || !Objects.equals(email, user.getEmail());
    }

    private void setFields(final User user) {
        user.setUsername(jwt.getClaim("preferred_username"));
        user.setEmail(jwt.getClaim("email"));
    }

    public void printClaims() {
        for (String claimName : jwt.getClaimNames()) {
            System.out.println(
                    claimName + " = " + jwt.getClaim(claimName)
            );
        }
    }
}