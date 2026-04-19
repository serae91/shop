package backend.api;

import backend.persistence.view.ProductView;
import backend.service.ProductService;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import jakarta.ws.rs.GET;
import jakarta.ws.rs.Path;

import java.util.List;

@ApplicationScoped
@Path("/product")
public class ProductResource {
    @Inject
    ProductService productService;

    @GET
    @Path("/products")
    public List<ProductView> getList() {
        return productService.getProducts();
    }
}
