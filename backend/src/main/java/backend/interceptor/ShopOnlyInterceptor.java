package backend.interceptor;

import backend.config.ConfigService;
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
    ConfigService configService;

    @AroundInvoke
    Object checkShopMode(InvocationContext context) throws Exception {
        if (!configService.isShop()) {
            throw new ForbiddenException("Shop is currently disabled");
        }

        return context.proceed();
    }
}
