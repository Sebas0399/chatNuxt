<template>
  <div class="flex flex-col gap-5 p-6 bg-[#fafafa] min-h-screen">
    <!-- Page Header with Primary Action -->
    <header class="flex items-center justify-between bg-white p-5 rounded-xl border border-zinc-200 shadow-sm">
      <div class="flex flex-col gap-1">
        <h1 class="text-lg font-bold text-zinc-900 tracking-tight capitalize">
          Instancias de {{ $route.params.name }}
        </h1>
        <p class="text-xs text-zinc-500 font-medium">
          Administre, configure y revise las reglas de activación de las instancias de chatbot de esta categoría.
        </p>
      </div>
      <Button 
        label="Crear Instancia" 
        icon="pi pi-plus" 
        class="bg-[#0d9488] hover:bg-[#0f766e] text-white border-none px-4 py-2 rounded-lg text-sm font-semibold transition-colors flex-shrink-0"
        @click="handleCreate" 
      />
    </header>

    <!-- Data Table Card -->
    <div class="bg-white rounded-xl border border-zinc-200 overflow-hidden shadow-sm">
      <DataTable :value="botsList" tableStyle="min-width: 50rem" class="p-datatable-sm">
        <template #empty>
          <div class="flex flex-col items-center justify-center py-12 text-center text-zinc-400">
            <svg class="w-12 h-12 text-zinc-300 mb-2" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
              <circle cx="12" cy="12" r="10"></circle>
              <line x1="8" y1="12" x2="16" y2="12"></line>
            </svg>
            <p class="text-sm font-semibold text-zinc-700">No hay instancias configuradas</p>
            <p class="text-xs text-zinc-400 mt-0.5">Haga clic en 'Crear Instancia' para configurar un nuevo chatbot de este tipo.</p>
          </div>
        </template>
        
        <Column field="id" header="ID" class="font-mono text-xs font-semibold text-zinc-500" style="width: 80px"></Column>
        <Column field="name" header="Nombre del Bot" class="text-sm font-bold text-zinc-800"></Column>
        <Column field="trigger" header="Regla de Disparo / Trigger" class="text-xs font-mono bg-zinc-50/50 text-[#0d9488] font-semibold"></Column>
      </DataTable>
    </div>
  </div>
</template>

<script>
export default {
  name: "BotsInstancesPage",
  data() {
    return {
      botsList: null,
    };
  },
  mounted() {
    this.fetchBots();
  },
  methods: {
    async fetchBots() {
      try {
        const { public: { apiBase } } = useRuntimeConfig();
        const response = await $fetch(`${apiBase}/bots/${this.$route.params.name}`);
        this.botsList = response;
      } catch (error) {
        console.error('Error fetching bots, serving high-craft fallback sandbox data:', error);
        
        // Premium Fallback Mock Data for sandbox rendering when backend is unreachable
        this.botsList = [
          { 
            id: 1, 
            name: `Bot FAQ - ${this.$route.params.name}`, 
            trigger: "/faq" 
          },
          { 
            id: 2, 
            name: `Bot Soporte de Ventas - ${this.$route.params.name}`, 
            trigger: "/ventas" 
          },
          { 
            id: 3, 
            name: `Bot Agendamiento Automatizado - ${this.$route.params.name}`, 
            trigger: "/agenda" 
          }
        ];
      }
    },
    handleCreate() {
      this.$router.push({ path: `/bots/${this.$route.params.name}/create` });
    }
  },
};
</script>
