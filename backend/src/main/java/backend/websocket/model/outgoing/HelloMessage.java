package backend.websocket.model.outgoing;

public record HelloMessage(String type) implements OutgoingWebSocketMessage {
}
