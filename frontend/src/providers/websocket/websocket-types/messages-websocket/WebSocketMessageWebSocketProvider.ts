import { createWebSocketProvider } from '../../WebSocketProvider.tsx';
import type { WebsocketMessage } from './message-types.ts';

export const {
  webSocketProvider: WebSocketMessageWebSocketProvider,
  useWebSocket: useWebsocketMessageWebSocket
} = createWebSocketProvider<WebsocketMessage>();