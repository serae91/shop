package backend.interceptor;

import backend.config.ShopModeService;
import jakarta.annotation.Priority;
import jakarta.inject.Inject;
import jakarta.interceptor.AroundInvoke;
import jakarta.interceptor.Interceptor;
import jakarta.interceptor.InvocationContext;
import jakarta.ws.rs.ForbiddenException;

@ShopOnly
@Interceptor
@Priority(Interceptor.Priority.APPLICATION)
public class ShopOnlyInterceptor {

    @Inject
    ShopModeService shopModeService;

    @AroundInvoke
    Object checkShopMode(InvocationContext context) throws Exception {
        if (!shopModeService.isShop()) {
            throw new ForbiddenException("Shop is currently disabled");
        }

        return context.proceed();
    }
}
