package backend.model;

import java.util.Set;

public record UserInfo(long id, String username, Set<String> roles) {
}
