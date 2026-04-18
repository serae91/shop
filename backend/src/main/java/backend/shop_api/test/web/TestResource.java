package backend.shop_api.test.web;

import io.agroal.api.AgroalDataSource;
import jakarta.inject.Inject;
import jakarta.ws.rs.GET;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.Produces;
import jakarta.ws.rs.core.MediaType;

import java.sql.Connection;
import java.sql.SQLException;

@Path("/test")
@Produces(MediaType.TEXT_PLAIN)
public class TestResource {

    @Inject
    AgroalDataSource dataSource;

    @GET
    @Path("/checksecret")
    public String checkSecret() {
        String secret = System.getenv("JWT_SECRET");
        return secret == null ? "Secret not set" : "Secret is set";
    }

    @GET
    @Path("/debugjwt")
    public String debugJwt() {
        final String jwt = System.getenv("JWT_SECRET");
        if ("YWJjZGVmZ2hpamtsbW5vcHFyc3R1dnd4eXphc2RmZ2g=".equals(jwt)) {
            return "JWT ist default jwt";
        }
        return "JWT ist NOT default jwt";
    }

    @GET
    public String test() {
        try (Connection conn = dataSource.getConnection()) {
            return "DB connected: " + conn.getMetaData().getDatabaseProductName();
        } catch (SQLException e) {
            return "DB connection failed: " + e.getMessage();
        }
    }
}