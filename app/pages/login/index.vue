<template>
  <div class="min-h-screen flex items-center justify-center p-4 bg-[#fafafa]">
    <div class="w-full max-w-md bg-white border border-zinc-200 rounded-lg p-8 flex flex-col gap-6 shadow-sm">
      
      <!-- Brand & Header -->
      <header class="flex flex-col items-center text-center gap-3">
        <!-- Enterprise Teal Styled Icon representing "The Operational Canvas" -->
        <div class="w-12 h-12 rounded-lg bg-[#0d9488]/10 flex items-center justify-center border border-[#0d9488]/20">
          <svg class="w-6 h-6 text-[#0d9488]" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
            <path d="M21 15a2 2 0 0 1-2 2H7l-4 4V5a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2z"></path>
          </svg>
        </div>
        <div>
          <h1 class="text-xl font-bold text-zinc-900 tracking-tight">
            chat<span class="text-[#0d9488]">Nuxt</span>
          </h1>
          <p class="text-sm text-zinc-500 mt-1 font-medium">
            Ingrese sus credenciales para continuar
          </p>
        </div>
      </header>

      <!-- Form -->
      <form class="flex flex-col gap-5" @submit.prevent="login">
        <div class="flex flex-col gap-4">
          <FloatLabel variant="on">
            <InputText id="user" v-model="user" type="text" autocomplete="username" inputmode="email" class="w-full"
              :disabled="loading" ref="userRef" />
            <label for="user">Usuario</label>
          </FloatLabel>

          <FloatLabel variant="on">
            <Password v-model="pass" inputId="pass" :feedback="false" toggleMask autocomplete="current-password"
              class="w-full" :disabled="loading" />
            <label for="pass">Contraseña</label>
          </FloatLabel>
        </div>

        <Button type="submit" :label="loading ? 'Ingresando…' : 'Ingresar'" :loading="loading"
          :disabled="!canSubmit || loading" class="w-full" />
      </form>

      <!-- Polished Error Notification Block -->
      <div v-if="errorMessage" class="flex gap-3 bg-red-50 border border-red-200 rounded-lg p-3.5 text-sm text-red-700 animate-fadeIn">
        <svg class="w-5 h-5 text-red-500 flex-shrink-0" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
          <circle cx="12" cy="12" r="10"></circle>
          <line x1="12" y1="8" x2="12" y2="12"></line>
          <line x1="12" y1="16" x2="12.01" y2="16"></line>
        </svg>
        <div class="flex flex-col gap-0.5">
          <span class="font-semibold">Error al iniciar sesión</span>
          <span class="text-red-600/90 text-xs">{{ errorMessage }}</span>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { useRuntimeConfig } from '#app'
import { useAuthStore } from '@/stores/auth'

export default {
  name: 'LoginPage',

  data() {
    return {
      user: '',
      pass: '',
      loading: false,
      errorMessage: ''
    }
  },

  computed: {
    canSubmit() {
      return this.user.trim() !== '' && this.pass !== ''
    }
  },

  mounted() {
    // Focus the username field input text elements
    this.$nextTick(() => {
      const el =
        this.$refs.userRef?.$el?.querySelector?.('input') ||
        this.$refs.userRef?.$el ||
        this.$refs.userRef
      el?.focus?.()
    })
  },

  methods: {
    async login() {
      if (!this.canSubmit || this.loading) return
      this.loading = true
      this.errorMessage = ''

      try {
        const { public: { apiBase } } = useRuntimeConfig()

        const token = await $fetch(`${apiBase}/companies/login`, {
          method: 'POST',
          body: {
            username: this.user,
            password: this.pass
          }
        })

        const auth = useAuthStore()
        auth.login(token, this.user)

        this.$router.push('/')
      } catch (e) {
        this.errorMessage = e.message || 'Por favor, verifique sus credenciales e intente de nuevo.'
      } finally {
        this.loading = false
      }
    }
  }
}
</script>

<style scoped>
@keyframes fadeIn {
  from {
    opacity: 0;
    transform: translateY(2px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}
.animate-fadeIn {
  animation: fadeIn 0.2s ease-out forwards;
}
</style>
