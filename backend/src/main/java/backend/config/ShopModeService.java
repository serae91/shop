package backend.config;

import backend.interceptor.ShopMode;
import jakarta.enterprise.context.ApplicationScoped;
import org.eclipse.microprofile.config.inject.ConfigProperty;

@ApplicationScoped
public class ShopModeService {

    @ConfigProperty(name = "shop.mode", defaultValue = "CATALOG")
    ShopMode configuredMode;

    public boolean isShop() {
        System.out.println(configuredMode);
        return ShopMode.SHOP.equals(configuredMode);
    }
}
