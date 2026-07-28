<template>
  <div 
    class="flex flex-col w-full gap-1 mb-2.5 animate-fadeIn"
    :class="isFromMe ? 'items-end' : 'items-start'"
  >
    <!-- Message Bubble -->
    <div 
      class="max-w-[75%] px-4 py-2.5 shadow-sm text-sm"
      :class="[
        isFromMe 
          ? 'bg-[#0d9488] text-white rounded-2xl rounded-tr-sm font-medium' 
          : 'bg-zinc-100 text-zinc-800 rounded-2xl rounded-tl-sm border border-zinc-200/50'
      ]"
    >
      <p class="margin-0 leading-relaxed whitespace-pre-wrap break-words">
        {{ message.text || message.message || '' }}
      </p>
    </div>

    <!-- Timestamp & Sender Meta -->
    <div class="flex items-center gap-1.5 px-1 text-xs text-zinc-400 font-medium">
      <span>{{ senderName }}</span>
      <span class="w-1 h-1 rounded-full bg-zinc-300"></span>
      <span>{{ formattedTime }}</span>
    </div>
  </div>
</template>

<script>
export default {
  name: "MessageCustom",
  props: {
    message: {
      type: Object,
      default: () => ({})
    }
  },
  computed: {
    isFromMe() {
      // Robust checking for various message payloads
      const sender = (this.message.from || this.message.sender || '').toUpperCase();
      return sender === 'COMPANY' || this.message.fromCompany === true || this.message.isMe === true;
    },
    senderName() {
      return this.isFromMe ? 'Tú (Soporte)' : 'Cliente';
    },
    formattedTime() {
      if (this.message.createdAt || this.message.time) {
        const d = new Date(this.message.createdAt || this.message.time);
        if (!isNaN(d.getTime())) {
          return d.toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' });
        }
      }
      return new Date().toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' });
    }
  }
}
</script>

<style scoped>
@keyframes fadeIn {
  from {
    opacity: 0;
    transform: translateY(1px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}
.animate-fadeIn {
  animation: fadeIn 0.15s ease-out forwards;
}
</style>
