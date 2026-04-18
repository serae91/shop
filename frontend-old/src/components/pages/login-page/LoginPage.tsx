import { useNavigate } from 'react-router-dom';
import { useState } from 'react';
import { useAuth } from '../../../providers/auth/AuthProvider.tsx';
import { authLogin, authMe } from '../../../services/AuthService.ts';

const LoginPage = () => {
  const [username, setUsername] = useState('');
  const [password, setPassword] = useState('');
  const {setUser} = useAuth();
  const navigate = useNavigate();

  async function handleLogin() {
    try {
      // 1. Login ausführen. 
      // Das Backend sendet das Cookie, der Browser speichert es automatisch.
      await authLogin(username, password);

      // 2. Jetzt rufen wir /auth/me auf. 
      // Dank 'withCredentials: true' schickt Axios das Cookie automatisch mit.
      const loggedInUser = await authMe();

      if (loggedInUser) {
        setUser(loggedInUser); // Globalen State im AuthProvider setzen
        navigate('/inbox');
      }
    } catch (err) {
      console.error('Login or fetching user info failed:', err);
      alert('Login fehlgeschlagen. Bitte prüfe deine Daten.');
    }
  }


  return (
    <div>
      <h1>Login</h1>
      <input value={ username } onChange={ e => setUsername(e.target.value) } placeholder="Username"/>
      <input type="password" value={ password } onChange={ e => setPassword(e.target.value) } placeholder="Password"/>
      <button onClick={ handleLogin }>Login</button>
      <button onClick={ () => navigate('/register') }>Go to Register</button>
    </div>
  );
};

export default LoginPage;
