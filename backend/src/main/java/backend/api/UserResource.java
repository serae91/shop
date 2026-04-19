package backend.api;

import backend.security.CurrentUser;
import backend.service.UserUpdateService;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import jakarta.ws.rs.GET;
import jakarta.ws.rs.Path;

@ApplicationScoped
@Path("/user")
public class UserResource {
    @Inject
    CurrentUser currentUser;
    @Inject
    UserUpdateService userUpdateService;

    @GET
    @Path("hi")
    public String hi() {
        return "hi";
    }
}
