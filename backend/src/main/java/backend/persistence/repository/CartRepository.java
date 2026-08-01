package backend.persistence.repository;

import backend.persistence.entity.Cart;
import backend.persistence.entity.CartItem;
import backend.persistence.entity.Product;
import backend.persistence.entity.User;
import io.quarkus.hibernate.orm.panache.PanacheRepository;
import jakarta.enterprise.context.ApplicationScoped;

import java.util.Optional;

@ApplicationScoped
public class CartRepository implements PanacheRepository<Cart> {

    public Optional<Cart> findByUser(User user) {
        return find("user", user).firstResultOptional();
    }

    public Optional<CartItem> findItem(Cart cart, Product product) {
        return getEntityManager()
                .createQuery("""
                        select ci
                        from CartItem ci
                        where ci.cart = :cart
                          and ci.product = :product
                        """, CartItem.class)
                .setParameter("cart", cart)
                .setParameter("product", product)
                .getResultStream()
                .findFirst();
    }
}
