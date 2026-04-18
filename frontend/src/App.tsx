import './App.scss';
import { BrowserRouter, Route, Routes } from 'react-router-dom';
import RootRedirect from './routes/root-redirect/RootRedirect.tsx';
import { QueryClientProvider } from '@tanstack/react-query';
import { queryClient } from './services/queryClient.ts';
import {
  WebSocketMessageWebSocketProvider
} from './providers/websocket/websocket-types/messages-websocket/WebSocketMessageWebSocketProvider.ts';
import AuthProvider from './providers/auth/AuthProvider.tsx';
import { ModalProvider } from './providers/modal/ModalProvider.tsx';

function App() {

  return (
    <AuthProvider>
      <QueryClientProvider client={ queryClient }>
        <BrowserRouter>

          <WebSocketMessageWebSocketProvider connectionURL={ 'websocket' }>
            <ModalProvider>
              <Routes>

                <Route path="*" element={ <RootRedirect/> }/>
              </Routes>
            </ModalProvider>
          </WebSocketMessageWebSocketProvider>
        </BrowserRouter>
      </QueryClientProvider>
    </AuthProvider>
  );
}

export default App;
