package backend.model.mapper;

import backend.model.CartDto;
import backend.model.CartItemDto;
import backend.persistence.entity.Cart;
import backend.persistence.entity.CartItem;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;

@ApplicationScoped
public class CartMapper {


    @Inject
    ProductMapper productMapper;


    public CartDto toDto(Cart cart) {

        return new CartDto(
                cart.getId(),
                cart.getCreatedAt(),
                cart.getCartItems()
                        .stream()
                        .map(this::toDto)
                        .toList()
        );
    }


    private CartItemDto toDto(CartItem item) {

        return new CartItemDto(
                item.getId(),
                productMapper.toDto(item.getProduct()),
                item.getQuantity()
        );
    }
}
