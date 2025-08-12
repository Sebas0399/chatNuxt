<template>
    <div>
        <p>{{ message.text }}</p>
    </div>
</template>
<script>
export default {
    props: {
        message: {
            type: Object,
            default: () => ({})
        }
    },
    mounted() {
        console.log('Message component mounted with message:', this.message);
    }
}
</script>