package backend.api;

import backend.model.AddCartItemRequest;
import backend.model.CartDto;
import backend.model.UpdateCartItemRequest;
import backend.service.CartService;
import io.quarkus.security.Authenticated;
import io.quarkus.security.identity.SecurityIdentity;
import jakarta.inject.Inject;
import jakarta.ws.rs.Consumes;
import jakarta.ws.rs.DELETE;
import jakarta.ws.rs.GET;
import jakarta.ws.rs.POST;
import jakarta.ws.rs.PUT;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.PathParam;
import jakarta.ws.rs.Produces;
import jakarta.ws.rs.core.MediaType;

@Path("/cart")
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)
@Authenticated
public class CartResource {

    @Inject
    CartService cartService;

    @Inject
    SecurityIdentity identity;

    @GET
    public CartDto getCart() {
        return cartService.getCart(identity.getPrincipal().getName());
    }

    @POST
    @Path("/items")
    public CartDto addItem(AddCartItemRequest request) {
        return cartService.addItem(
                identity.getPrincipal().getName(),
                request.productId(),
                request.quantity()
        );
    }

    @PUT
    @Path("/items/{productId}")
    public CartDto updateItem(
            @PathParam("productId") Long productId,
            UpdateCartItemRequest request
    ) {
        return cartService.updateQuantity(
                identity.getPrincipal().getName(),
                productId,
                request.quantity()
        );
    }

    @DELETE
    @Path("/items/{productId}")
    public CartDto removeItem(@PathParam("productId") Long productId) {
        return cartService.removeItem(
                identity.getPrincipal().getName(),
                productId
        );
    }
}
