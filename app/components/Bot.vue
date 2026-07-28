<template>
  <div 
    class="flex items-center gap-4 p-4 rounded-lg cursor-pointer transition-all duration-200 border"
    :class="[
      active 
        ? 'bg-[#0d9488]/5 border-[#0d9488] text-[#0d9488] shadow-sm' 
        : 'bg-white border-zinc-200 hover:bg-zinc-50 hover:border-zinc-300 text-zinc-800'
    ]"
  >
    <!-- Dynamic Category Icon based on name -->
    <div 
      class="w-10 h-10 rounded-lg flex items-center justify-center border flex-shrink-0"
      :class="[
        active 
          ? 'bg-[#0d9488]/10 border-[#0d9488]/20 text-[#0d9488]' 
          : 'bg-zinc-100 border-zinc-200 text-zinc-500'
      ]"
    >
      <svg class="w-5 h-5" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
        <!-- Support / Soporte -->
        <g v-if="normalizedName === 'soporte'">
          <circle cx="12" cy="12" r="10"></circle>
          <circle cx="12" cy="12" r="4"></circle>
          <line x1="4.93" y1="4.93" x2="9.17" y2="9.17"></line>
          <line x1="14.83" y1="9.17" x2="19.07" y2="4.93"></line>
          <line x1="14.83" y1="14.83" x2="19.07" y2="19.07"></line>
          <line x1="9.17" y1="14.83" x2="4.93" y2="19.07"></line>
        </g>
        <!-- Sales / Ventas -->
        <g v-else-if="normalizedName === 'ventas'">
          <circle cx="9" cy="21" r="1"></circle>
          <circle cx="20" cy="21" r="1"></circle>
          <path d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6"></path>
        </g>
        <!-- Scheduling / Agendamiento -->
        <g v-else-if="normalizedName === 'agendamiento'">
          <rect x="3" y="4" width="18" height="18" rx="2" ry="2"></rect>
          <line x1="16" y1="2" x2="16" y2="6"></line>
          <line x1="8" y1="2" x2="8" y2="6"></line>
          <line x1="3" y1="10" x2="21" y2="10"></line>
        </g>
        <!-- Fallback Generic Bot -->
        <g v-else>
          <rect x="3" y="11" width="18" height="11" rx="2" ry="2"></rect>
          <path d="M12 2v4M8 5h8"></path>
          <circle cx="12" cy="8" r="2"></circle>
        </g>
      </svg>
    </div>

    <!-- Title and Description -->
    <div class="flex-1 min-w-0 flex flex-col gap-0.5">
      <h3 class="font-bold text-sm truncate capitalize" :class="active ? 'text-[#0d9488]' : 'text-zinc-800'">
        {{ bot.name }}
      </h3>
      <p class="text-xs text-zinc-500 truncate font-medium">
        {{ descriptionText }}
      </p>
    </div>
  </div>
</template>

<script>
export default {
  name: "BotCategoryCard",
  props: {
    bot: {
      type: Object,
      default: () => ({})
    },
    active: {
      type: Boolean,
      default: false
    }
  },
  computed: {
    normalizedName() {
      return (this.bot.name || '').toLowerCase().trim();
    },
    descriptionText() {
      const name = this.normalizedName;
      if (name === 'soporte') return 'Atención al cliente y FAQs.';
      if (name === 'ventas') return 'Pipelines de ventas y leads.';
      if (name === 'agendamiento') return 'Reservas y calendarios.';
      return 'Automatizaciones generales.';
    }
  }
}
</script>
