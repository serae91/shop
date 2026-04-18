import api from './api';

const path = '/auth';

export async function authLogin(username: string, password: string) {
  const response = await api.post(`${ path }/login`, {username, password}, {withCredentials: true});
  return response.data;
}

export async function authRegister(username: string, password: string) {
  const response = await api.post(`${ path }/register`, {username, password}, {withCredentials: true});
  return response.data;
}

export async function authLogout() {
  const response = await api.post(`${ path }/logout`, undefined, {withCredentials: true});
  return response.data;
}

export async function authMe() {
  const response = await api.get(`${ path }/me`, {withCredentials: true});
  return response.data;
}