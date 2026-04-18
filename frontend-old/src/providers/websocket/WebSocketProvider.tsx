import React, { createContext, type ReactNode, useCallback, useContext, useEffect, useMemo, useState } from 'react';
import { WebSocketService } from '../../services/WebSocketService.ts';
import { useAuth } from '../auth/AuthProvider.tsx'; // Importiere deinen AuthContext

export interface ProviderProps {
  children: ReactNode;
  connectionURL: string;
}

export type WebSocketContextType<T> = {
  connected: boolean;
  send: (data: T) => void;
  addMessageHandler: (fn: (msg: T) => void) => void;
  removeMessageHandler: (fn: (msg: T) => void) => void;
};

export const createWebSocketProvider = <T, >() => {
  const WebSocketContext = createContext<WebSocketContextType<T> | null>(null);

  const ShopWebSocketProvider = ({children, connectionURL}: ProviderProps) => {
    const [connected, setConnected] = useState(false);
    const [service, setService] = useState<WebSocketService<T> | null>(null);
    const {user, loading} = useAuth();

    useEffect(() => {

      if (loading || !user) {
        return;
      }

      const baseURL = import.meta.env.VITE_API_URL.replace(/^http/, 'ws');
      const ws = new WebSocketService<T>(`${ baseURL }/${ connectionURL }`);

      ws.onOpen(() => setConnected(true));
      ws.onClose(() => setConnected(false));

      ws.connect();
      setService(ws);

      return () => {
        ws.close();
        setService(null);
        setConnected(false);
      };
    }, [connectionURL, user, loading]);

    const addMessageHandler = useCallback((fn: (msg: T) => void) => {
      service?.onMessage(fn);
    }, [service]);

    const removeMessageHandler = useCallback((fn: (msg: T) => void) => {
      service?.removeMessageHandler(fn);
    }, [service]);

    const send = useCallback((msg: T) => {
      if (!service || !connected) return;
      service.send(msg);
    }, [service, connected]);

    const value = useMemo(() => ({
      connected,
      send,
      addMessageHandler,
      removeMessageHandler,
    }), [connected, send, addMessageHandler, removeMessageHandler]);

    return (
      <WebSocketContext.Provider value={ value }>
        { children }
      </WebSocketContext.Provider>
    );
  };

  const useWebSocket = () => {
    const context = useContext(WebSocketContext);
    if (!context) {
      throw new Error('useWebSocket must be used inside MessageWebSocketProvider');
    }
    return context;
  };

  return {webSocketProvider: ShopWebSocketProvider, useWebSocket};
};