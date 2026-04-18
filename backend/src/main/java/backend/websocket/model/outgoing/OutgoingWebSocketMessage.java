package backend.websocket.model.outgoing;

import com.fasterxml.jackson.annotation.JsonSubTypes;
import com.fasterxml.jackson.annotation.JsonTypeInfo;

@JsonTypeInfo(
        use = JsonTypeInfo.Id.NAME,
        include = JsonTypeInfo.As.PROPERTY,
        property = "type"
)
@JsonSubTypes({
        @JsonSubTypes.Type(value = HelloMessage.class, name = "Hello")
})
//Outgoing means outgoing from the client (so incoming to the server)
public interface OutgoingWebSocketMessage {
}
