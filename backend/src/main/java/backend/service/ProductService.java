package backend.service;

import backend.persistence.entity.Product;
import backend.persistence.view.ProductView;
import com.blazebit.persistence.CriteriaBuilder;
import com.blazebit.persistence.CriteriaBuilderFactory;
import com.blazebit.persistence.view.EntityViewManager;
import com.blazebit.persistence.view.EntityViewSetting;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import jakarta.persistence.EntityManager;

import java.util.List;

@ApplicationScoped
public class ProductService {
    @Inject
    CriteriaBuilderFactory criteriaBuilderFactory;
    @Inject
    EntityManager entityManager;
    @Inject
    EntityViewManager entityViewManager;

    public List<ProductView> getProducts() {
        final CriteriaBuilder<Product> criteriaBuilder = criteriaBuilderFactory.create(entityManager, Product.class);
        return entityViewManager.applySetting(EntityViewSetting.create(ProductView.class), criteriaBuilder).getResultList();
    }
}
