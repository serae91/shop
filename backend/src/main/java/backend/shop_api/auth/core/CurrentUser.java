package backend.bl_api.auth.core;

import jakarta.enterprise.context.RequestScoped;
import jakarta.ws.rs.WebApplicationException;
import jakarta.ws.rs.core.Context;
import jakarta.ws.rs.core.SecurityContext;
import org.eclipse.microprofile.jwt.JsonWebToken;

@RequestScoped
public class CurrentUser {

    // Wir injizieren den SecurityContext, den dein Filter mit setSecurityContext befüllt hat
    @Context
    SecurityContext securityContext;

    public Long getUserId() {
        // Hol das Principal aus dem Context
        java.security.Principal principal = securityContext.getUserPrincipal();

        if (!(principal instanceof JsonWebToken jwt)) {
            System.err.println("CurrentUser: Principal is not a JWT! Path: " +
                    (securityContext.getAuthenticationScheme()));
            throw new WebApplicationException("Nicht authentifiziert", 401);
        }

        final Object idClaim = jwt.getClaim("id");
        if (idClaim == null) {
            System.err.println("CurrentUser: ID Claim missing for user: " + jwt.getName());
            throw new WebApplicationException("User ID fehlt im Token", 403);
        }

        return Long.valueOf(idClaim.toString());
    }

    // Hilfsmethode, falls du mal den Namen brauchst
    public String getUsername() {
        return securityContext.getUserPrincipal().getName();
    }
}