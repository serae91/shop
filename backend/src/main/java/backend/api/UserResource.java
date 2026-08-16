package backend.api;

import backend.interceptor.ShopOnly;
import backend.model.UserInfo;
import backend.persistence.entity.User;
import backend.persistence.repository.UserRepository;
import io.quarkus.security.identity.SecurityIdentity;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import jakarta.ws.rs.GET;
import jakarta.ws.rs.NotFoundException;
import jakarta.ws.rs.Path;

import java.util.UUID;

@Path("/users")
@ApplicationScoped
public class UserResource {

    @Inject
    SecurityIdentity identity;

    @Inject
    UserRepository userRepository;

    @ShopOnly
    @GET
    @Path("/me")
    public UserInfo me() {

        final UUID keycloakId = UUID.fromString(identity.getPrincipal().getName());

        final User user = userRepository
                .findByKeycloakId(keycloakId)
                .orElseThrow(NotFoundException::new);

        return new UserInfo(
                user.getId(),
                user.getUsername(),
                user.getEmail(),
                user.getRole()
        );
    }
}