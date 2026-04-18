package backend.bl_api.user.core;

import io.quarkus.hibernate.orm.panache.PanacheRepository;
import jakarta.enterprise.context.ApplicationScoped;

@ApplicationScoped
public class UserRepository implements PanacheRepository<backend.bl_entities.bl_user.ShopUser> {
    public backend.bl_entities.bl_user.ShopUser findByUsername(final String username) {
        return find("username", username).singleResult();
    }

    public boolean doesUsernameExist(final String username) {
        final backend.bl_entities.bl_user.ShopUser shopUser = find("username", username).firstResult();
        return shopUser != null;
    }
}
