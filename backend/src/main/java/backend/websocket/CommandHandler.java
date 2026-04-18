package backend.websocket;

import backend.bl_api.chat.usecase.create.ChatCreateService;
import backend.bl_api.message.usecase.create.MessageCreateService;
import backend.bl_api.rel_chat_user_attr.core.ChatUserViewService;
import backend.bl_entities.bl_chat.ChatBox;
import backend.bl_entities.bl_message.BLMessageView;
import backend.bl_entities.bl_rel_chat_user_attr.ChatUserView;
import backend.bl_entities.bl_rel_chat_user_attr.ReminderStatus;
import backend.websocket.model.incoming.ReceiveChatWebSocketMessage;
import backend.websocket.model.incoming.ReceiveMessageWebSocketMessage;
import backend.websocket.model.incoming.ReceiveUpdatedChatWebSocketMessage;
import backend.websocket.model.outgoing.CreateChatWebSocketMessage;
import backend.websocket.model.outgoing.OutgoingWebSocketMessage;
import backend.websocket.model.outgoing.SendMessageWebSocketMessage;
import backend.websocket.model.outgoing.SwitchChatWebSocketMessage;
import io.quarkus.websockets.next.WebSocketConnection;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import lombok.extern.slf4j.Slf4j;

import java.util.List;

@Slf4j
@ApplicationScoped
public class CommandHandler {


    public void handleCommand(final OutgoingWebSocketMessage outgoingWebsocketMessage, final WebSocketConnection connection) {
        switch (outgoingWebsocketMessage) {
            default ->
                    throw new IllegalStateException("Unexpected OutgoingWebsocketMessage type: " + outgoingWebsocketMessage);
        }
    }

}
