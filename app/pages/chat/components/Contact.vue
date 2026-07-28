<template>
  <div 
    class="flex items-center gap-3 p-3 rounded-lg cursor-pointer transition-all duration-200 border"
    :class="[
      active 
        ? 'bg-[#0d9488]/10 border-[#0d9488]/20 text-[#0d9488]' 
        : 'bg-white border-zinc-100 hover:bg-zinc-50 hover:border-zinc-200 text-zinc-800'
    ]"
  >
    <!-- Avatar with Initials -->
    <div 
      class="w-10 h-10 rounded-full flex items-center justify-center font-semibold text-sm relative flex-shrink-0"
      :class="[
        active 
          ? 'bg-[#00796B] text-white' 
          : 'bg-zinc-100 text-zinc-600'
      ]"
    >
      {{ initials }}
      
      <!-- Online Indicator Dot -->
      <span class="absolute bottom-0 right-0 w-3 h-3 rounded-full border-2 border-white bg-green-500"></span>
    </div>

    <!-- Contact Metadata -->
    <div class="flex-1 min-w-0 flex flex-col gap-0.5">
      <div class="flex items-center justify-between gap-1">
        <h3 class="font-semibold text-sm truncate" :class="active ? 'text-zinc-900' : 'text-zinc-800'">
          {{ contact.name || 'Usuario Anónimo' }}
        </h3>
        <span class="text-xs text-zinc-400 font-medium flex-shrink-0">
          {{ lastActiveTime }}
        </span>
      </div>
      <p class="text-xs text-zinc-500 truncate font-medium">
        {{ contact.phone || 'Sin número registrado' }}
      </p>
    </div>
  </div>
</template>

<script>
export default {
  name: "ContactCard",
  props: {
    contact: {
      type: Object,
      default: () => ({})
    },
    active: {
      type: Boolean,
      default: false
    }
  },
  computed: {
    initials() {
      const name = this.contact.name || '';
      if (!name) return 'U';
      const parts = name.split(' ').filter(p => p.length > 0);
      if (parts.length >= 2) {
        return (parts[0][0] + parts[1][0]).toUpperCase();
      }
      return name.slice(0, 2).toUpperCase();
    },
    lastActiveTime() {
      // Return a realistic status or dynamic placeholder
      return 'Activo';
    }
  }
}
</script>
