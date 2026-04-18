package backend.websocket;

import backend.websocket.model.outgoing.OutgoingWebSocketMessage;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import io.quarkus.websockets.next.HandshakeRequest;
import io.quarkus.websockets.next.OnClose;
import io.quarkus.websockets.next.OnOpen;
import io.quarkus.websockets.next.OnTextMessage;
import io.quarkus.websockets.next.WebSocket;
import io.quarkus.websockets.next.WebSocketConnection;
import io.smallrye.jwt.auth.principal.DefaultJWTParser;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import lombok.extern.slf4j.Slf4j;
import org.eclipse.microprofile.config.inject.ConfigProperty;
import org.eclipse.microprofile.jwt.JsonWebToken;

@Slf4j
@WebSocket(path = "/websocket")
@ApplicationScoped
public class ShopWebSocket {

    @Inject
    ObjectMapper objectMapper;

    @Inject
    CommandHandler commandHandler;

    @ConfigProperty(name = "smallrye.jwt.sign.key")
    String jwtSecret;

    @OnOpen
    public void onOpen(final WebSocketConnection connection, final HandshakeRequest request) {
        final String cookieHeader = request.header("cookie");

        final String token = extractToken(cookieHeader);

        if (token == null) {
            log.error("WS Connect rejected: No token-Cookie available in header: {}", cookieHeader);
            connection.closeAndAwait();
            return;
        }

        try {
            final DefaultJWTParser parser = new DefaultJWTParser();
            final JsonWebToken jwt = parser.verify(token, jwtSecret);

            final Long userId = Long.valueOf(jwt.getClaim("id").toString());


            log.info("WebSocket connected: User {} (ID: {})", jwt.getName(), userId);
        } catch (final Exception e) {
            log.error("WS Auth Error: {}", e.getMessage());
            connection.closeAndAwait();
        }
    }

    @OnTextMessage
    public void onMessage(final String message, final WebSocketConnection connection) {
        try {
            final OutgoingWebSocketMessage outgoingWebsocketMessage = objectMapper.readValue(message, OutgoingWebSocketMessage.class);
            commandHandler.handleCommand(outgoingWebsocketMessage, connection);
        } catch (JsonProcessingException jpe) {
            log.error("Invalid JSON received: {}", message);
            jpe.printStackTrace();
        }
    }

    @OnClose
    public void onClose(final WebSocketConnection connection) {
        log.info("Client disconnected: {}", connection.id());
    }

    private String extractToken(String header) {
        if (header == null || header.isBlank()) return null;

        final String[] cookies = header.split(";");
        for (String cookie : cookies) {
            String trimmed = cookie.trim();
            if (trimmed.startsWith("token=")) {
                String tokenValue = trimmed.substring(6);
                return tokenValue.isBlank() ? null : tokenValue;
            }
        }
        return null;
    }
}