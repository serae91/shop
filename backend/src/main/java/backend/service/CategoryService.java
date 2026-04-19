package backend.service;

import backend.persistence.entity.Category;
import backend.persistence.view.CategoryView;
import com.blazebit.persistence.CriteriaBuilder;
import com.blazebit.persistence.CriteriaBuilderFactory;
import com.blazebit.persistence.view.EntityViewManager;
import com.blazebit.persistence.view.EntityViewSetting;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import jakarta.persistence.EntityManager;

import java.util.List;

@ApplicationScoped
public class CategoryService {
    @Inject
    CriteriaBuilderFactory criteriaBuilderFactory;
    @Inject
    EntityManager entityManager;
    @Inject
    EntityViewManager entityViewManager;

    public List<CategoryView> getCategories() {
        final CriteriaBuilder<Category> criteriaBuilder = criteriaBuilderFactory.create(entityManager, Category.class);
        return entityViewManager.applySetting(EntityViewSetting.create(CategoryView.class), criteriaBuilder).getResultList();
    }
}
