package backend.service;

import backend.model.CartDto;
import backend.model.mapper.CartMapper;
import backend.persistence.entity.Cart;
import backend.persistence.entity.CartItem;
import backend.persistence.entity.Product;
import backend.persistence.repository.CartItemRepository;
import backend.persistence.repository.CartRepository;
import backend.persistence.repository.ProductRepository;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
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

    public CartDto getCart() {

        final Cart cart = cartRepository.findByUser(currentUserService.getCurrentUser())
                .orElseGet(this::createCart);
        return cartMapper.toDto(cart);
    }

    @Transactional
    public CartDto addItem(final Long productId, final int quantity) {

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
            System.out.println("Created new cart item");
        } else {

            item.setQuantity(item.getQuantity() + quantity);
            cartItemRepository.persist(item);
            System.out.println("Increased cart item quantity");
        }

        return cartMapper.toDto(cart);
    }

    @Transactional
    public CartDto updateQuantity(final Long productId, final int quantity) {
        System.out.println("updateQuantity");

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

        return cartMapper.toDto(cart);
    }

    @Transactional
    public CartDto removeItem(String email, Long productId) {

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

        return cartMapper.toDto(cart);
    }

    private Cart createCart() {
        final Cart cart = new Cart();
        cart.setUser(currentUserService.getCurrentUser());

        cartRepository.persist(cart);

        return cart;
    }
}
