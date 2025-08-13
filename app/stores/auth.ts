// stores/auth.ts
import { defineStore } from 'pinia'

interface UserState {
  token: string | null
  username: string | null
}

export const useAuthStore = defineStore('auth', {
  state: (): UserState => ({
    token: null,
    username: null,
  }),
  actions: {
    login(token: string, username: string) {
      this.token = token
      this.username = username
      localStorage.setItem('token', token)
      localStorage.setItem('username', username)
    },
    logout() {
      this.token = null
      this.username = null
      localStorage.removeItem('token')
      localStorage.removeItem('username')
    },
    loadFromStorage() {
      this.token = localStorage.getItem('token')
      this.username = localStorage.getItem('username')
    }
  },
  getters: {
    isAuthenticated: (state) => !!state.token,
  },
})
