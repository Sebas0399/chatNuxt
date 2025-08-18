<template>
  <div class="min-h-screen flex items-center justify-center p-4">
    <div class="card w-full max-w-md flex flex-col gap-6 p-6">
      <header class="text-center">
        <h1 class="text-lg font-semibold">Login Page</h1>
        <p class="text-sm opacity-80">Ingrese sus credenciales para continuar</p>
      </header>

      <form class="flex flex-col gap-4" @submit.prevent="login">
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

      <p v-if="errorMessage" class="text-sm text-red-500">
        {{ errorMessage }}
      </p>
    </div>
  </div>
</template>

<script>
import { useRuntimeConfig } from '#app'
import { useAuthStore } from '@/stores/auth' // ajuste la ruta si difiere

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
    // Foco al input de usuario
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
        // Ajuste la firma si su store requiere un objeto en lugar de parámetros sueltos
        auth.login(token, this.user)

        this.$router.push('/')
      } catch (e) {
        this.errorMessage = e.message || 'Error al iniciar sesión. Por favor, intente de nuevo.'
        // console.error(e) // opcional
      } finally {
        this.loading = false
      }
    }
  }
}
</script>