package backend.model;

public record UserInfo(
        Long id,
        String username,
        String email,
        String role
) {
}
