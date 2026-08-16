package backend.service;

import backend.model.mapper.CartMapper;
import backend.persistence.entity.Cart;
import backend.persistence.entity.CartItem;
import backend.persistence.entity.Product;
import backend.persistence.repository.CartItemRepository;
import backend.persistence.repository.CartRepository;
import backend.persistence.repository.ProductRepository;
import backend.persistence.view.CartView;
import com.blazebit.persistence.CriteriaBuilder;
import com.blazebit.persistence.CriteriaBuilderFactory;
import com.blazebit.persistence.view.EntityViewManager;
import com.blazebit.persistence.view.EntityViewSetting;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import jakarta.persistence.EntityManager;
import jakarta.transaction.Transactional;

@ApplicationScoped
public class CartService {

    @Inject
    CurrentUserService currentUserService;

    @Inject
    ProductRepository productRepository;

    @Inject
    CartRepository cartRepository;

    @Inject
    CartItemRepository cartItemRepository;

    @Inject
    CartMapper cartMapper;

    @Inject
    EntityManager entityManager;

    @Inject
    EntityViewManager entityViewManager;

    @Inject
    CriteriaBuilderFactory criteriaBuilderFactory;

    public CartView getCart() {

        final Cart cart = cartRepository.findByUser(currentUserService.getCurrentUser())
                .orElseGet(this::createCart);
        return getById(cart.getId());
    }

    @Transactional
    public CartView addItem(final Long productId, final int quantity) {

        final Product product = productRepository.findByIdOptional(productId)
                .orElseThrow();

        final Cart cart = cartRepository.findByUser(currentUserService.getCurrentUser())
                .orElseGet(this::createCart);

        final CartItem item = cartItemRepository
                .findByCartAndProduct(cart, product)
                .orElse(null);

        if (item == null) {

            final CartItem newItem = new CartItem();
            newItem.setCart(cart);
            newItem.setProduct(product);
            newItem.setQuantity(quantity);

            cart.getCartItems().add(newItem);
            cartItemRepository.persist(newItem);

        } else {
            item.setQuantity(item.getQuantity() + quantity);
        }

        return getById(cart.getId());
    }

    @Transactional
    public CartView updateQuantity(final Long productId, final int quantity) {

        final Product product = productRepository.findByIdOptional(productId)
                .orElseThrow();

        final Cart cart = cartRepository.findByUser(currentUserService.getCurrentUser())
                .orElseThrow();

        final CartItem item = cartItemRepository
                .findByCartAndProduct(cart, product)
                .orElseThrow();

        if (quantity <= 0) {

            cart.getCartItems().remove(item);
            cartItemRepository.delete(item);

        } else {

            item.setQuantity(quantity);
            cartItemRepository.persist(item);

        }

        return getById(cart.getId());
    }

    @Transactional
    public CartView removeItem(String email, Long productId) {

        Cart cart = cartRepository.findByUser(currentUserService.getCurrentUser())
                .orElseThrow();

        CartItem item = cart.getCartItems()
                .stream()
                .filter(cartItem ->
                        cartItem.getProduct().getId().equals(productId)
                )
                .findFirst()
                .orElseThrow();

        cart.getCartItems().remove(item);

        cartItemRepository.delete(item);

        return getById(cart.getId());
    }

    private Cart createCart() {
        final Cart cart = new Cart();
        cart.setUser(currentUserService.getCurrentUser());

        cartRepository.persist(cart);

        return cart;
    }

    private CartView getById(final Long id) {
        CriteriaBuilder<Cart> criteriaBuilder = criteriaBuilderFactory.create(entityManager, Cart.class);
        criteriaBuilder.where("id").eq(id);
        return entityViewManager.applySetting(EntityViewSetting.create(CartView.class), criteriaBuilder).getSingleResult();
    }
}
