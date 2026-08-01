package backend.persistence.repository;

import backend.persistence.entity.Cart;
import backend.persistence.entity.CartItem;
import backend.persistence.entity.Product;
import io.quarkus.hibernate.orm.panache.PanacheRepository;
import jakarta.enterprise.context.ApplicationScoped;

import java.util.Optional;

@ApplicationScoped
public class CartItemRepository implements PanacheRepository<CartItem> {

    public Optional<CartItem> findByCartAndProduct(Cart cart, Product product) {
        return find(
                "cart = ?1 and product = ?2",
                cart,
                product
        ).firstResultOptional();
    }
}
