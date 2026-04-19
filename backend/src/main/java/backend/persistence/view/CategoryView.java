package backend.persistence.view;

import backend.persistence.entity.Category;
import com.blazebit.persistence.view.EntityView;
import com.blazebit.persistence.view.IdMapping;

@EntityView(Category.class)
public interface CategoryView {
    @IdMapping
    Long getId();

    String getName();
}
