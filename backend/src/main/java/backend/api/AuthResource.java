package backend.api;

import backend.model.LoginRequest;
import backend.model.RegisterRequest;
import backend.model.UserInfo;
import backend.persistence.entity.User;
import backend.service.AuthService;
import io.smallrye.jwt.build.Jwt;
import jakarta.annotation.security.PermitAll;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import jakarta.ws.rs.Consumes;
import jakarta.ws.rs.GET;
import jakarta.ws.rs.POST;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.Produces;
import jakarta.ws.rs.WebApplicationException;
import jakarta.ws.rs.core.Context;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;
import jakarta.ws.rs.core.SecurityContext;
import lombok.extern.slf4j.Slf4j;
import org.eclipse.microprofile.config.inject.ConfigProperty;
import org.eclipse.microprofile.jwt.JsonWebToken;

import java.util.Map;
import java.util.Set;

@Slf4j
@Path("/auth")
@ApplicationScoped
public class AuthResource {

    @Inject
    AuthService authService;

    @ConfigProperty(name = "smallrye.jwt.sign.key")
    String jwtSecret;

    @ConfigProperty(name = "quarkus.profile")
    String profile;

    @POST
    @Path("/login")
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON)
    public Response login(final LoginRequest request) {
        log.info("Login request for user: {}", request.email());

        final User user = authService.authenticate(request.email(), request.password());

        if (user == null) {
            return Response.status(Response.Status.UNAUTHORIZED).build();
        }

        final String token = Jwt.claims()
                .issuer("shop")
                .subject(user.getUsername())
                .claim("id", user.getId())
                .groups(Set.of("user"))
                .expiresIn(3600)
                .signWithSecret(jwtSecret);

        boolean isProd = "prod".equals(profile);

        String sameSite = isProd ? "None" : "Lax";
        String secure = isProd ? "Secure; " : "";

        String cookieHeader = String.format(
                "token=%s; HttpOnly; Path=/; SameSite=%s; %sMax-Age=3600",
                token, sameSite, secure
        );

        log.info("Login successful for {}, Profile: {}", user.getUsername(), profile);

        return Response.ok(Map.of("token", token))
                .header("Set-Cookie", cookieHeader)
                .build();
    }

    @POST
    @Path("/logout")
    public Response logout() {
        boolean isProd = "prod".equals(profile);
        String sameSite = isProd ? "None" : "Lax";
        String secure = isProd ? "Secure; " : "";

        return Response.noContent()
                .header("Set-Cookie", String.format("token=; HttpOnly; Path=/; Max-Age=0; SameSite=%s; %s", sameSite, secure))
                .build();
    }

    @POST
    @Path("/register")
    @Produces(MediaType.APPLICATION_JSON)
    public Response register(final RegisterRequest request) {
        final User newUser = authService.createUser(request.username(), request.password());
        return Response.status(Response.Status.CREATED).entity(newUser).build();
    }

    @GET
    @Path("/me")
    @PermitAll
    @Produces(MediaType.APPLICATION_JSON)
    public UserInfo me(@Context final SecurityContext ctx) {
        if (!(ctx.getUserPrincipal() instanceof JsonWebToken jwt)) {
            throw new WebApplicationException(Response.Status.UNAUTHORIZED);
        }
        return new UserInfo(
                Long.valueOf(jwt.getClaim("id").toString()),
                jwt.getName(),
                jwt.getGroups() != null ? jwt.getGroups() : Set.of("user")
        );
    }
}