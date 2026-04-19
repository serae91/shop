package backend.persistence.view;

import backend.persistence.entity.User;
import com.blazebit.persistence.view.EntityView;
import com.blazebit.persistence.view.IdMapping;
import com.blazebit.persistence.view.UpdatableEntityView;

@EntityView(User.class)
@UpdatableEntityView
public interface UserUpdateView {
    @IdMapping
    Long getId();
}
