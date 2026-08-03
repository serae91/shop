package backend.model;

import java.util.Set;

public record UserInfo(
        String id,
        String username,
        Set<String> roles
) {
}
