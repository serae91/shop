package backend.bl_api.auth.core;

import backend.bl_api.user.core.UserRepository;
import io.quarkus.elytron.security.common.BcryptUtil;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import jakarta.transaction.Transactional;
import jakarta.ws.rs.WebApplicationException;
import jakarta.ws.rs.core.Response;
import lombok.extern.slf4j.Slf4j;

import java.util.regex.Pattern;

@Slf4j
@ApplicationScoped
public class AuthService {
    private static final Pattern STRONG_PASSWORD =
            Pattern.compile("^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[^A-Za-z0-9]).{8,}$");

    @Inject
    UserRepository userRepository;

    public backend.bl_entities.bl_user.ShopUser authenticate(final String username, final String password) {
        final backend.bl_entities.bl_user.ShopUser user = userRepository.findByUsername(username);
        log.info("athentitcate in service sent username " + username + "sent password" + password + "found by name password " + user.getPasswordHash());

        if (user == null) {
            log.info("athentitcate in service, user not found");

            return null;
        }

        if (!BcryptUtil.matches(password, user.getPasswordHash())) {
            log.info("athentitcate in service, password does not match");

            return null;
        }

        return user;
    }

    @Transactional
    public backend.bl_entities.bl_user.ShopUser createUser(final String username, final String password) {

        if (username == null || username.isBlank()) {
            throw new WebApplicationException("Username required", 400);
        }

        if (userRepository.doesUsernameExist(username)) {
            throw new WebApplicationException("User already exists", 409);
        }

        if (!STRONG_PASSWORD.matcher(password).matches()) {
            throw new WebApplicationException(
                    "Password must be at least 8 characters long and contain upper, lower, number and special character",
                    Response.Status.BAD_REQUEST
            );
        }

        final backend.bl_entities.bl_user.ShopUser user = backend.bl_entities.bl_user.ShopUser.builder()
                .username(username)
                .passwordHash(BcryptUtil.bcryptHash(password))
                .build();

        userRepository.persist(user);

        return user;
    }
}
