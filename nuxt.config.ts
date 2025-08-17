// https://nuxt.com/docs/api/configuration/nuxt-config
import Aura from '@primeuix/themes/aura';

export default defineNuxtConfig({
  compatibilityDate: '2025-07-15',
  devtools: { enabled: true },
  modules: ['@primevue/nuxt-module', '@nuxtjs/tailwindcss', '@pinia/nuxt'],
  primevue: {
    options: {
      theme: {
        preset: Aura
      }
    }
  },
  runtimeConfig: {
    // The private keys which are only available within server-side
    apiSecret: '123',
    // Keys within public, will be also exposed to the client-side
    public: {
      apiBase: 'http://localhost:8080'
    }
  },
  vite: {
    server: {
      allowedHosts: [
        'ba5f809a9f64.ngrok-free.app' // dominio exacto que te da ngrok
      ]
    }
  }
  
})