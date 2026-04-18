package backend.shop_api.user.core;

import backend.shop_entities.shop_user.ShopUser;
import io.quarkus.hibernate.orm.panache.PanacheRepository;
import jakarta.enterprise.context.ApplicationScoped;

@ApplicationScoped
public class UserRepository implements PanacheRepository<ShopUser> {
    public ShopUser findByEmail(final String email) {
        return find("email", email).singleResult();
    }

    public boolean doesUsernameExist(final String username) {
        final ShopUser shopUser = find("username", username).firstResult();
        return shopUser != null;
    }
}
