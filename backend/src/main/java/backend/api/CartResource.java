package backend.api;

import backend.interceptor.ShopOnly;
import backend.model.AddCartItemRequest;
import backend.model.UpdateCartItemRequest;
import backend.persistence.view.CartView;
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
@ShopOnly
@Authenticated
public class CartResource {

    @Inject
    CartService cartService;

    @Inject
    SecurityIdentity identity;

    @GET
    public CartView getCart() {
        return cartService.getCart();
    }

    @POST
    @Path("/items")
    public CartView addItem(AddCartItemRequest request) {
        System.out.println(request.productId() + " " + request.quantity());
        return cartService.addItem(
                request.productId(),
                request.quantity()
        );
    }

    @PUT
    @Path("/items/{productId}")
    public CartView updateItem(
            @PathParam("productId") Long productId,
            UpdateCartItemRequest request
    ) {
        return cartService.updateQuantity(
                productId,
                request.quantity()
        );
    }

    @DELETE
    @Path("/items/{productId}")
    public CartView removeItem(@PathParam("productId") Long productId) {
        return cartService.removeItem(
                identity.getPrincipal().getName(),
                productId
        );
    }
}
