import React, {
  createContext,
  type Dispatch,
  type ReactNode,
  type SetStateAction,
  useContext,
  useEffect,
  useState
} from 'react';
import type { ShopUserDto } from '../../dtos/ShopUserDto.ts';
import { getCurrentUserInfo } from '../../services/UserService.ts';
import type { IdDto } from '../../dtos/IdDto.ts';
import { authLogout, authMe } from '../../services/AuthService.ts';

type AuthContextType = {
  user: IdDto | null;
  loading: boolean;
  setUser: Dispatch<SetStateAction<IdDto | null>>;
  logout: () => void;
  currentUserInfo: ShopUserDto | null;
  setCurrentUserInfo: Dispatch<SetStateAction<ShopUserDto | null>>;
}

const AuthContext = createContext<AuthContextType | null>(null);

export const AuthProvider = ({children}: { children: ReactNode }) => {
  const [user, setUser] = useState<IdDto | null>(null);
  const [currentUserInfo, setCurrentUserInfo] = useState<ShopUserDto | null>(null);
  const [loading, setLoading] = useState(true);

  const logout = async () => {
    try {
      await authLogout();
      // localStorage.removeItem('authToken'); <-- ENTFÄLLT, da Cookie-basiert
    } catch (err) {
      console.error('Logout failed:', err);
    } finally {
      setUser(null);
      setCurrentUserInfo(null);
    }
  };

  useEffect(() => {
    const checkAuth = async () => {
      try {
        const data = await authMe();
        setUser(data);
      } catch (err) {
        // Ein 401 oder Netzwerkfehler landet hier
        console.log('AuthCheck: Nicht eingeloggt oder Server-Fehler');
        setUser(null);
      } finally {
        // Dieser Block wird IMMER ausgeführt, egal ob Erfolg oder Error
        setLoading(false);
      }
    };

    checkAuth();
  }, []);

  // 2. Details laden, sobald die ID bekannt ist
  useEffect(() => {
    if (user?.id) {
      getCurrentUserInfo()
        .then(setCurrentUserInfo)
        .catch(() => setCurrentUserInfo(null));
    } else {
      setCurrentUserInfo(null);
    }
  }, [user?.id]);

  return (
    <AuthContext.Provider value={ {user, loading, setUser, logout, currentUserInfo, setCurrentUserInfo} }>
      { children }
    </AuthContext.Provider>
  );
};

export const useAuth = () => {
  const context = useContext(AuthContext);
  if (!context) throw new Error('useAuth must be used inside <AuthProvider>');
  return context;
};

export default AuthProvider;
