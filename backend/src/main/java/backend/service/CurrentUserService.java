package backend.service;

import backend.persistence.entity.User;
import backend.persistence.repository.UserRepository;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import org.eclipse.microprofile.jwt.JsonWebToken;

import java.util.UUID;

@ApplicationScoped
public class CurrentUserService {

    @Inject
    JsonWebToken jwt;

    @Inject
    UserRepository userRepository;

    public UUID getUserKeycloakId() {
        return UUID.fromString(jwt.getSubject());
    }

    public User getCurrentUser() {
        return userRepository.findByKeycloakId(getUserKeycloakId()).orElseThrow();
    }


    public void printClaims() {
        for (String claimName : jwt.getClaimNames()) {
            System.out.println(
                    claimName + " = " + jwt.getClaim(claimName)
            );
        }
    }
}
