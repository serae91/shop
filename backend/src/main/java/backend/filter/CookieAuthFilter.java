package backend.filter;

import io.quarkus.security.identity.SecurityIdentity;
import io.quarkus.security.runtime.QuarkusSecurityIdentity;
import io.smallrye.jwt.auth.principal.DefaultJWTParser;
import jakarta.annotation.Priority;
import jakarta.ws.rs.Priorities;
import jakarta.ws.rs.container.ContainerRequestContext;
import jakarta.ws.rs.container.ContainerRequestFilter;
import jakarta.ws.rs.core.Cookie;
import jakarta.ws.rs.core.Response;
import jakarta.ws.rs.core.SecurityContext;
import jakarta.ws.rs.ext.Provider;
import org.eclipse.microprofile.config.inject.ConfigProperty;
import org.eclipse.microprofile.jwt.JsonWebToken;

import java.io.IOException;
import java.security.Principal;

@Provider
@Priority(Priorities.AUTHENTICATION)
public class CookieAuthFilter implements ContainerRequestFilter {
    @ConfigProperty(name = "smallrye.jwt.sign.key")
    String jwtSecret;

    @Override
    public void filter(final ContainerRequestContext requestContext) throws IOException {
        String path = requestContext.getUriInfo().getPath();

        if (requestContext.getMethod().equalsIgnoreCase("OPTIONS") ||
                path.contains("auth/login") ||
                path.contains("auth/register") ||
                path.contains("favicon.ico") ||
                path.startsWith("public/")) {
            return;
        }

        Cookie cookie = requestContext.getCookies().get("token");

        if (cookie == null) {
            System.out.println("Cookie Auth Filter: No Cookie for Path: " + path);
            requestContext.abortWith(Response.status(Response.Status.UNAUTHORIZED).build());
            return;
        }

        String token = cookie.getValue();

        try {
            DefaultJWTParser manualParser = new DefaultJWTParser();
            final JsonWebToken jwt = manualParser.verify(token, jwtSecret);

            requestContext.setSecurityContext(new SecurityContext() {
                @Override
                public Principal getUserPrincipal() {
                    return jwt;
                }

                @Override
                public boolean isUserInRole(String role) {
                    return jwt.getGroups() != null && jwt.getGroups().contains(role);
                }

                @Override
                public boolean isSecure() {
                    return requestContext.getSecurityContext().isSecure();
                }

                @Override
                public String getAuthenticationScheme() {
                    return "JWT";
                }
            });

            QuarkusSecurityIdentity identity = QuarkusSecurityIdentity.builder()
                    .setPrincipal(jwt)
                    .addRoles(jwt.getGroups())
                    .build();
            requestContext.setProperty(SecurityIdentity.class.getName(), identity);

            System.out.println("Cookie Auth Filter: SUCCESS for " + path + " (User: " + jwt.getName() + ")");

        } catch (Exception e) {
            System.err.println("Cookie Auth Filter: Auth failed for " + path + " : " + e.getMessage());
            requestContext.abortWith(Response.status(Response.Status.UNAUTHORIZED).build());
        }
    }
}