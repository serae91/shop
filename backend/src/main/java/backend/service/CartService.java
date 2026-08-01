package backend.service;

import backend.model.CartDto;
import backend.model.mapper.CartMapper;
import backend.persistence.entity.Cart;
import backend.persistence.entity.CartItem;
import backend.persistence.entity.Product;
import backend.persistence.entity.User;
import backend.persistence.repository.CartItemRepository;
import backend.persistence.repository.CartRepository;
import backend.persistence.repository.ProductRepository;
import backend.persistence.repository.UserRepository;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import jakarta.transaction.Transactional;

@ApplicationScoped
@Transactional
public class CartService {

    @Inject
    UserRepository userRepository;

    @Inject
    ProductRepository productRepository;

    @Inject
    CartRepository cartRepository;

    @Inject
    CartItemRepository cartItemRepository;

    @Inject
    CartMapper cartMapper;

    public CartDto getCart(String email) {

        User user = userRepository.findByEmail(email)
                .orElseThrow();

        Cart cart = cartRepository.findByUser(user)
                .orElseGet(() -> createCart(user));

        return cartMapper.toDto(cart);
    }

    public CartDto addItem(String email, Long productId, int quantity) {

        User user = userRepository.findByEmail(email)
                .orElseThrow();

        Product product = productRepository.findByIdOptional(productId)
                .orElseThrow();

        Cart cart = cartRepository.findByUser(user)
                .orElseGet(() -> createCart(user));

        CartItem item = cartItemRepository
                .findByCartAndProduct(cart, product)
                .orElse(null);

        if (item == null) {

            item = new CartItem();
            item.setCart(cart);
            item.setProduct(product);
            item.setQuantity(quantity);

            cart.getCartItems().add(item);

        } else {

            item.setQuantity(item.getQuantity() + quantity);

        }

        return cartMapper.toDto(cart);
    }

    public CartDto updateQuantity(String email,
                                  Long productId,
                                  int quantity) {

        User user = userRepository.findByEmail(email)
                .orElseThrow();

        Product product = productRepository.findByIdOptional(productId)
                .orElseThrow();

        Cart cart = cartRepository.findByUser(user)
                .orElseThrow();

        CartItem item = cartItemRepository
                .findByCartAndProduct(cart, product)
                .orElseThrow();

        if (quantity <= 0) {

            cart.getCartItems().remove(item);
            cartItemRepository.delete(item);

        } else {

            item.setQuantity(quantity);

        }

        return cartMapper.toDto(cart);
    }

    @Transactional
    public CartDto removeItem(String email, Long productId) {

        User user = userRepository.findByEmail(email)
                .orElseThrow();

        Cart cart = cartRepository.findByUser(user)
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

    private Cart createCart(User user) {

        Cart cart = new Cart();
        cart.setUser(user);

        cartRepository.persist(cart);

        return cart;
    }
}
