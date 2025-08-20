<template>
      <div>
            <Button label="Create" @click="handleCreate" />
      </div>
      <div class="card">
            <DataTable :value="listBots" tableStyle="min-width: 50rem">
                  <Column field="name" header="Name"></Column>
                  <Column field="trigger" header="Trigger"></Column>
            </DataTable>
      </div>
</template>
<script>
export default {
      data() {
            return {
                  listBots: null,
            };
      },
      methods: {
            async listBots() {
                  try {
                        const { public: { apiBase } } = useRuntimeConfig();
                        const response = await $fetch(`${apiBase}/bots/${route.params.name}`);
                        this.listBots = response;
                  } catch (error) {
                        console.error('Error fetching bots:', error);
                  }
            },
            handleCreate() {
                  this.$router.push({ path: `/bots/${this.$route.params.name}/create` });
            }
      },

};
</script>