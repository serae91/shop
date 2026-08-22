package backend.config;

import backend.interceptor.ShopMode;
import jakarta.enterprise.context.ApplicationScoped;
import org.eclipse.microprofile.config.inject.ConfigProperty;

@ApplicationScoped
public class ConfigService {

    @ConfigProperty(name = "shop.mode", defaultValue = "CATALOG")
    ShopMode configuredMode;

    public boolean isShop() {
        return ShopMode.SHOP.equals(configuredMode);
    }
}
