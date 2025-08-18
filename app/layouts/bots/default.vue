<template>
    <DefaultLayout>
        <NuxtPage />
        <div class="grid grid-cols-3 gap-4">
            <div>
                <Bot v-for="bot in bots" :key="bot.id" :bot="bot" @click="handleBotClick(bot)" />
            </div>
            <div class="col-span-2">

            </div>
        </div>
    </DefaultLayout>
</template>
<script>
import DefaultLayout from '~/layouts/default.vue';
import Bot from '~/components/Bot.vue';

export default {
    components: {
        DefaultLayout,
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
                console.error('Error fetching bots:', error);
            }
        },
        handleBotClick(bot) {
            this.$router.push({ path: `/bots/${bot.name}` });
        }
    },
};
</script>
