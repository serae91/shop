export type WebsocketMessage = WebSocketMessageIncoming | WebSocketMessageOutgoing;

export type WebSocketMessageIncoming =
  | ReceiveMessage;

type ReceiveMessage = { type: 'RECEIVE_MESSAGE'; };

type WebSocketMessageOutgoing =
  | SendMessage;

type SendMessage = { type: 'SEND_MESSAGE'; chatId: number; }