package backend.api;

import backend.model.UserInfo;
import io.quarkus.security.identity.SecurityIdentity;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import jakarta.ws.rs.GET;
import jakarta.ws.rs.Path;
import org.eclipse.microprofile.jwt.JsonWebToken;

@Path("/users")
@ApplicationScoped
public class UserResource {

    @Inject
    SecurityIdentity identity;

    @Inject
    JsonWebToken jwt;

    @GET
    @Path("/me")
    public UserInfo me() {

        return new UserInfo(
                jwt.getSubject(),
                identity.getPrincipal().getName(),
                identity.getRoles()
        );
    }
}