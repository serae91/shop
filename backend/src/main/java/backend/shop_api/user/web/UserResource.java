package backend.bl_api.user.web;

import backend.bl_api.auth.core.CurrentUser;
import backend.bl_api.user.core.UserService;
import backend.bl_api.user.usecase.update.UserUpdateService;
import backend.filter.CookieAuthFilterProtected;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import jakarta.ws.rs.DefaultValue;
import jakarta.ws.rs.GET;
import jakarta.ws.rs.PATCH;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.QueryParam;

import java.util.Set;

@CookieAuthFilterProtected
@ApplicationScoped
@Path("/user")
public class UserResource {
    @Inject
    UserService userService;
    @Inject
    CurrentUser currentUser;
    @Inject
    UserUpdateService userUpdateService;

    @GET
    @Path("/info")
    public BLUserView getCurrentUserInfo() {
        System.out.println("UserResource: reached /user/info");
        return userService.getCurrentUserInfo(currentUser.getUserId());
    }

    @GET
    @Path("/filtered")
    public Set<BLUserView> getFilteredUsers(@QueryParam("query") @DefaultValue("") final String query) {
        return userService.getFilteredUsers(query, currentUser.getUserId());
    }

    @PATCH
    @Path("/update")
    public void updateUser(final BLUserUpdateView userUpdateView) {
        userUpdateService.updateUser(userUpdateView);
    }
}
