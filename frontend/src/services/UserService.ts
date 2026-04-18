import api from './api';

const path = '/user';

export async function getCurrentUserInfo() {
  return (await api.get(`${ path }/info`)).data;
}

export async function getFilteredUsers(query: string = '') {
  return (await api.get(`${ path }/filtered?query=${ query }`)).data;
}
