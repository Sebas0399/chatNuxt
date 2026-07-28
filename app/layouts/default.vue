<template>
  <div class="min-h-screen bg-[#fafafa] flex flex-col font-sans antialiased text-zinc-800">
    <!-- Navigation Menubar Container -->
    <Menubar :model="items" class="bg-white border-b border-zinc-200 px-6 py-2.5 h-16 flex items-center justify-between shadow-sm relative z-50 flex-shrink-0">
      
      <!-- Brand Logo Custom Slot -->
      <template #start>
        <router-link to="/" class="flex items-center gap-3 mr-6 hover:opacity-90 transition-opacity">
          <!-- Highly Polished Conversational Node SVG Brand Logo -->
          <svg width="32" height="32" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" class="h-8 w-auto">
            <path d="M21 11.5a8.38 8.38 0 0 1-.9 3.8 8.5 8.5 0 0 1-7.6 4.7 8.38 8.38 0 0 1-3.8-.9L3 21l1.9-5.7a8.38 8.38 0 0 1-.9-3.8 8.5 8.5 0 0 1 4.7-7.6 8.38 8.38 0 0 1 3.8-.9h.5a8.48 8.48 0 0 1 8 8v.5z" stroke="#0d9488" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round" />
            <circle cx="9" cy="12" r="1.5" fill="#0d9488"/>
            <circle cx="13" cy="12" r="1.5" fill="#0d9488"/>
            <circle cx="17" cy="12" r="1.5" fill="#0d9488"/>
          </svg>
          <span class="text-base font-bold text-zinc-950 tracking-tight">
            chat<span class="text-[#0d9488]">Nuxt</span>
          </span>
        </router-link>
      </template>

      <!-- Custom Menubar Item Rendering -->
      <template #item="{ item, props, hasSubmenu }">
        <router-link v-if="item.route" v-slot="{ href, navigate, isActive }" :to="item.route" custom>
          <a 
            v-ripple 
            :href="href" 
            v-bind="props.action" 
            class="flex items-center gap-2 px-3 py-2 rounded-lg text-xs font-bold transition-all duration-150"
            :class="[
              isActive 
                ? 'bg-[#0d9488]/10 text-[#0d9488] font-bold' 
                : 'text-zinc-600 hover:bg-zinc-50 hover:text-zinc-900 font-semibold'
            ]"
            @click="navigate"
          >
            <span :class="[item.icon, isActive ? 'text-[#0d9488]' : 'text-zinc-400']" class="text-sm" />
            <span>{{ item.label }}</span>
          </a>
        </router-link>
        <a 
          v-else 
          v-ripple 
          :href="item.url" 
          :target="item.target" 
          v-bind="props.action"
          class="flex items-center gap-2 px-3 py-2 rounded-lg text-xs font-semibold text-zinc-600 hover:bg-zinc-50 hover:text-zinc-900 transition-all"
        >
          <span :class="item.icon" class="text-zinc-400 text-sm" />
          <span>{{ item.label }}</span>
          <span v-if="hasSubmenu" class="pi pi-fw pi-angle-down ml-1 text-zinc-400" />
        </a>
      </template>

      <!-- Right Column: Search bar, Avatar and Profile overlay Menu -->
      <template #end>
        <div class="flex items-center gap-3 pl-4">
          <!-- Search Inputs -->
          <div class="relative hidden sm:block">
            <span class="pi pi-search absolute left-3 top-1/2 -translate-y-1/2 text-zinc-400 text-xs"></span>
            <InputText 
              placeholder="Buscar..." 
              type="text" 
              class="w-48 pl-8 pr-3 py-1.5 text-xs bg-zinc-50 border border-zinc-200 rounded-lg text-zinc-800 placeholder-zinc-400 focus:bg-white focus:border-[#0d9488] focus:ring-1 focus:ring-[#0d9488]/20 transition-all font-medium" 
            />
          </div>

          <!-- Divider -->
          <span class="h-5 w-[1px] bg-zinc-200 hidden sm:block"></span>

          <!-- Profile Avatar Trigger -->
          <Avatar 
            label="P" 
            class="cursor-pointer border border-zinc-200 bg-zinc-100 hover:border-[#0d9488] transition-colors text-xs font-bold h-8 w-8 rounded-full" 
            shape="circle" 
            @click="toggle" 
            aria-haspopup="true"
            aria-controls="overlay_menu" 
          />
          
          <!-- Dropdown Profile Overlay Menu -->
          <Menu ref="menu" id="overlay_menu" :model="itemsMenu" :popup="true" class="shadow-md border border-zinc-200 rounded-lg py-1 bg-white z-50">
            <template #item="{ item, props }">
              <router-link v-if="item.route" v-slot="{ href, navigate }" :to="item.route" custom>
                <a 
                  v-ripple 
                  :href="href" 
                  v-bind="props.action" 
                  class="flex items-center gap-2 px-3 py-2 text-xs font-semibold text-zinc-700 hover:bg-zinc-50 hover:text-zinc-900 transition-colors"
                  @click="navigate"
                >
                  <span :class="item.icon" class="text-zinc-400" />
                  <span>{{ item.label }}</span>
                </a>
              </router-link>
              <a 
                v-else 
                v-ripple 
                :href="item.url" 
                :target="item.target" 
                v-bind="props.action"
                class="flex items-center gap-2 px-3 py-2 text-xs font-semibold text-zinc-700 hover:bg-zinc-50 hover:text-zinc-900 transition-colors"
              >
                <span :class="item.icon" class="text-zinc-400" />
                <span>{{ item.label }}</span>
              </a>
            </template>
          </Menu>
        </div>
      </template>

    </Menubar>

    <!-- Content Slot -->
    <div class="flex-1 flex flex-col min-h-0 relative z-10">
      <slot />
    </div>
  </div>
</template>

<script setup>
import { ref } from "vue";
import { useRouter } from 'vue-router';

const router = useRouter();
const menu = ref();

// Context-focused symbols instead of raw pi-palette
const items = ref([
  {
    label: 'Chat',
    icon: 'pi pi-comments',
    route: '/chat'
  },
  {
    label: 'Bots',
    icon: 'pi pi-server',
    route: '/bots'
  },
  {
    label: 'Flows',
    icon: 'pi pi-sitemap',
    route: '/flows'
  },
]);

const itemsMenu = ref([
  {
    label: 'Perfil',
    items: [
      {
        label: 'Configuración',
        icon: 'pi pi-cog',
        route: '/company'
      },
      {
        label: 'Salir',
        icon: 'pi pi-sign-out'
      }
    ]
  }
]);

const toggle = (event) => {
  menu.value.toggle(event);
};
</script>

<style>
/* Remove standard PrimeVue Menubar item container paddings to allow full height active states */
.p-menubar {
  border: none !important;
  border-radius: 0 !important;
}
.p-menubar .p-menubar-root-list {
  gap: 8px !important;
}
</style>
