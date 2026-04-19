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
import jakarta.ws.rs.core.Context;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;
import jakarta.ws.rs.core.SecurityContext;
import lombok.extern.slf4j.Slf4j;
import org.eclipse.microprofile.config.inject.ConfigProperty;
import org.eclipse.microprofile.jwt.JsonWebToken;

import java.time.Duration;
import java.util.Map;
import java.util.Set;

@Slf4j
@Path("/auth")
@ApplicationScoped
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)
public class AuthResource {

    @Inject
    AuthService authService;

    @ConfigProperty(name = "smallrye.jwt.sign.key")
    String jwtSecret;

    @POST
    @Path("/login")
    @PermitAll
    public Response login(LoginRequest request) {

        log.info("Login attempt for {}", request.email());

        final User user = authService.authenticate(request.email(), request.password());

        if (user == null) {
            return Response.status(Response.Status.UNAUTHORIZED)
                    .entity(Map.of("error", "Invalid credentials"))
                    .build();
        }

        final String token = Jwt.issuer("shop")
                .subject(user.getUsername())
                .claim("id", user.getId())
                .groups(Set.of("user"))
                .expiresIn(Duration.ofHours(1))
                .signWithSecret(jwtSecret);

        return Response.ok(Map.of(
                "token", token,
                "type", "Bearer",
                "expiresIn", 3600
        )).build();
    }

    @POST
    @Path("/register")
    @PermitAll
    public Response register(RegisterRequest request) {

        final User newUser = authService.createUser(
                request.username(),
                request.password()
        );

        return Response.status(Response.Status.CREATED)
                .entity(newUser)
                .build();
    }

    @GET
    @Path("/me")
    public Response me(@Context SecurityContext ctx) {

        if (!(ctx.getUserPrincipal() instanceof JsonWebToken jwt)) {
            return Response.status(Response.Status.UNAUTHORIZED).build();
        }

        final UserInfo info = new UserInfo(
                Long.valueOf(jwt.getClaim("id").toString()),
                jwt.getName(),
                jwt.getGroups() != null ? jwt.getGroups() : Set.of("user")
        );

        return Response.ok(info).build();
    }
}