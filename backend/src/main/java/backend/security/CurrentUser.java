package backend.security;

import jakarta.enterprise.context.RequestScoped;
import jakarta.inject.Inject;
import org.eclipse.microprofile.jwt.JsonWebToken;

@RequestScoped
public class CurrentUser {

    @Inject
    JsonWebToken jwt;

    public Long getUserId() {
        Object idClaim = jwt.getClaim("id");

        if (idClaim == null) {
            throw new SecurityException("User ID fehlt im Token");
        }

        return Long.valueOf(idClaim.toString());
    }

    public String getUsername() {
        return jwt.getName();
    }
}