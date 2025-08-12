<template>
    <div>
        <h2>{{ contact.name }}</h2>
    </div>
</template>
<script>
export default {
    props: {
        contact: {
            type: Object,
            default: () => ({})
        }
    }
}
</script>