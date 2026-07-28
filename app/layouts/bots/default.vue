<template>
  <div class="grid grid-cols-3 h-[calc(100vh-4rem)] bg-[#fafafa] overflow-hidden flex-1">
    
    <!-- Left Column: Bot Categories Sidebar -->
    <aside class="col-span-1 border-r border-zinc-200 bg-white flex flex-col h-full overflow-y-auto p-6 gap-5 flex-shrink-0">
      <div class="flex flex-col gap-1">
        <h2 class="text-base font-bold text-zinc-900 tracking-tight">Categorías de Bot</h2>
        <p class="text-xs text-zinc-500 font-medium">Seleccione un tipo de bot para gestionar y desplegar instancias.</p>
      </div>
      
      <div class="flex flex-col gap-3">
        <Bot 
          v-for="bot in bots" 
          :key="bot.id" 
          :bot="bot" 
          :active="$route.params.name === bot.name"
          @click="handleBotClick(bot)" 
        />
      </div>
    </aside>

    <!-- Right Column (Slot Contents) -->
    <main class="col-span-2 overflow-y-auto bg-[#fafafa] h-full flex flex-col">
      <!-- If we are on the base /bots page, show a welcome empty state, otherwise Slot renders the child -->
      <div v-if="!$route.params.name" class="flex-1 flex flex-col items-center justify-center p-8 text-center bg-zinc-50/10">
        <div class="w-16 h-16 rounded-full bg-[#0d9488]/5 border border-[#0d9488]/10 flex items-center justify-center mb-4">
          <svg class="w-8 h-8 text-[#0d9488]" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.75" stroke-linecap="round" stroke-linejoin="round">
            <rect x="3" y="3" width="18" height="18" rx="2" ry="2"></rect>
            <line x1="9" y1="3" x2="9" y2="21"></line>
          </svg>
        </div>
        <h2 class="text-lg font-bold text-zinc-900 tracking-tight">Consola de Control de Bots</h2>
        <p class="text-sm text-zinc-500 max-w-xs mt-1.5 leading-relaxed font-medium">
          Seleccione una categoría de bot de la izquierda para ver, crear y probar instancias de chatbot activas.
        </p>
      </div>
      <slot v-else />
    </main>

  </div>
</template>

<script>
import Bot from '~/components/Bot.vue';

export default {
  name: "BotsLayout",
  components: {
    Bot,
  },
  data() {
    return {
      bots: null,
      itemsBot: null
    }
  },
  mounted() {
    this.fetchBots();
  },
  methods: {
    async fetchBots() {
      try {
        const { public: { apiBase } } = useRuntimeConfig();
        const response = await $fetch(`${apiBase}/botTypes`);
        this.bots = response;
      } catch (error) {
        console.error('Error fetching bot types, serving premium fallback categories:', error);
        this.bots = [
          { id: 1, name: "soporte" },
          { id: 2, name: "ventas" },
          { id: 3, name: "agendamiento" }
        ];
      }
    },
    handleBotClick(bot) {
      this.$router.push({ path: `/bots/${bot.name}` });
    }
  },
};
</script>
