<template>
    <div>
        <Menubar :model="items">
            <template #start>
                <svg width="35" height="40" viewBox="0 0 35 40" fill="none" xmlns="http://www.w3.org/2000/svg"
                    class="h-8">
                    <path d="..." fill="var(--p-primary-color)" />
                    <path d="..." fill="var(--p-text-color)" />
                </svg>
            </template>
            <template #item="{ item, props, hasSubmenu }">
                <router-link v-if="item.route" v-slot="{ href, navigate }" :to="item.route" custom>
                    <a v-ripple :href="href" v-bind="props.action" @click="navigate">
                        <span :class="item.icon" />
                        <span>{{ item.label }}</span>
                    </a>
                </router-link>
                <a v-else v-ripple :href="item.url" :target="item.target" v-bind="props.action">
                    <span :class="item.icon" />
                    <span>{{ item.label }}</span>
                    <span v-if="hasSubmenu" class="pi pi-fw pi-angle-down" />
                </a>
            </template>
            <template #end>
                <div class="flex items-center gap-2">
                    <InputText placeholder="Search" type="text" class="w-32 sm:w-auto" />
                    <Avatar label="P" class="mr-2" shape="circle" @click="toggle" aria-haspopup="true"
                        aria-controls="overlay_menu" />
                    <Menu ref="menu" id="overlay_menu" :model="itemsMenu" :popup="true">
                        <template #item="{ item, props }">
                            <router-link v-if="item.route" v-slot="{ href, navigate }" :to="item.route" custom>
                                <a v-ripple :href="href" v-bind="props.action" @click="navigate">
                                    <span :class="item.icon" />
                                    <span class="ml-2">{{ item.label }}</span>
                                </a>
                            </router-link>
                            <a v-else v-ripple :href="item.url" :target="item.target" v-bind="props.action">
                                <span :class="item.icon" />
                                <span class="ml-2">{{ item.label }}</span>
                            </a>
                        </template>
                    </Menu>
                </div>
            </template>
        </Menubar>
        <slot />
    </div>
</template>
<script setup>
import { ref } from "vue";
import { useRouter } from 'vue-router';

const router = useRouter();
const menu = ref();

const items = ref([
    {
        label: 'Chat',
        icon: 'pi pi-palette',
        route: '/chat'
    },
     {
        label: 'Bots',
        icon: 'pi pi-palette',
        route: '/bots'
    },
    {
        label: 'Flows',
        icon: 'pi pi-palette',
        route: '/flows'
    },

]);
const itemsMenu = ref([
    {
        label: 'Perfil',
        items: [
            {
                label: 'Configuración',
                icon: 'pi pi-refresh',
                route: '/company'

            },
            {
                label: 'Salir',
                icon: 'pi pi-upload'
            }
        ]
    }
]);
const toggle = (event) => {
    menu.value.toggle(event);
};
</script>