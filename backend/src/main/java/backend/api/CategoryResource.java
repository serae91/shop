package backend.api;

import backend.persistence.view.CategoryView;
import backend.service.CategoryService;
import jakarta.annotation.security.PermitAll;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import jakarta.ws.rs.GET;
import jakarta.ws.rs.Path;

import java.util.List;

@ApplicationScoped
@Path("/category")
@PermitAll
public class CategoryResource {
    @Inject
    CategoryService categoryService;

    @GET
    @Path("/categories")
    public List<CategoryView> getCategories() {
        return categoryService.getCategories();
    }
}
