<template>

    <div class="p-4 rounded shadow border-current">
        <h2>{{ bot.name }}</h2>
    </div>
</template>
<script>
export default {
    props: {
        bot: {
            type: Object,
            default: () => ({})
        }
    }
}
</script>