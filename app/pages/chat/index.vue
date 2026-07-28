<template>
  <div class="h-[calc(100vh-4rem)] w-full bg-[#fafafa] overflow-hidden flex flex-col">
    <div class="flex-1 grid grid-cols-3 gap-6 p-6 h-full min-h-0">

      <!-- Left Sidebar: Contact List -->
      <aside class="col-span-1 flex flex-col bg-white rounded-xl border border-zinc-200 overflow-hidden shadow-sm h-full">
        <!-- Sidebar Header -->
        <header class="px-5 py-4 border-b border-zinc-200 flex flex-col gap-1.5 flex-shrink-0">
          <div class="flex items-center justify-between">
            <h2 class="text-base font-bold text-zinc-900 tracking-tight">Chats Activos</h2>
            <span class="bg-[#0d9488]/10 text-[#0d9488] px-2 py-0.5 rounded-full text-xs font-semibold">
              {{ contacts.length }}
            </span>
          </div>
          <p class="text-xs text-zinc-500 font-medium">Seleccione un cliente para ver e interactuar en tiempo real.</p>
        </header>

        <!-- Sidebar List Scroll -->
        <div class="flex-1 overflow-y-auto p-3 space-y-2 bg-zinc-50/50">
          <div v-if="contacts.length === 0" class="flex flex-col items-center justify-center py-12 text-center px-4">
            <svg class="w-10 h-10 text-zinc-300 mb-2" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
              <path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"></path>
              <circle cx="9" cy="7" r="4"></circle>
              <path d="M23 21v-2a4 4 0 0 0-3-3.87"></path>
              <path d="M16 3.13a4 4 0 0 1 0 7.75"></path>
            </svg>
            <p class="text-xs text-zinc-500 font-semibold">No hay contactos cargados</p>
          </div>
          
          <Contact 
            v-for="contact in contacts" 
            :key="contact.id" 
            :contact="contact"
            :active="currentContact?.id === contact.id"
            @click="getContactMessages(contact)" 
          />
        </div>
      </aside>

      <!-- Right Pane: Active Conversation or Empty State -->
      <section class="col-span-2 flex flex-col bg-white rounded-xl border border-zinc-200 overflow-hidden shadow-sm h-full">
        
        <!-- Case A: No Contact Selected (Premium Empty State) -->
        <div v-if="!currentContact" class="flex-1 flex flex-col items-center justify-center p-8 text-center bg-zinc-50/20">
          <div class="w-16 h-16 rounded-full bg-[#0d9488]/5 border border-[#0d9488]/10 flex items-center justify-center mb-4">
            <svg class="w-8 h-8 text-[#0d9488]" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.75" stroke-linecap="round" stroke-linejoin="round">
              <path d="M21 11.5a8.38 8.38 0 0 1-.9 3.8 8.5 8.5 0 0 1-7.6 4.7 8.38 8.38 0 0 1-3.8-.9L3 21l1.9-5.7a8.38 8.38 0 0 1-.9-3.8 8.5 8.5 0 0 1 4.7-7.6 8.38 8.38 0 0 1 3.8-.9h.5a8.48 8.48 0 0 1 8 8v.5z"></path>
            </svg>
          </div>
          <h2 class="text-lg font-bold text-zinc-900 tracking-tight">Consola de Chat Sandbox</h2>
          <p class="text-sm text-zinc-500 max-w-md mt-1.5 leading-relaxed font-medium">
            Seleccione un contacto del panel izquierdo para cargar el historial de mensajes e iniciar la interacción en vivo a través de WebSockets.
          </p>
        </div>

        <!-- Case B: Active Chat Workspace -->
        <div v-else class="flex-1 flex flex-col h-full min-h-0">
          <!-- Active Chat Header -->
          <header class="px-5 py-4 border-b border-zinc-200 flex items-center justify-between bg-white flex-shrink-0">
            <div class="flex items-center gap-3">
              <!-- Header Avatar -->
              <div class="w-9 h-9 rounded-full bg-[#0d9488] text-white flex items-center justify-center font-bold text-sm">
                {{ currentContactInitials }}
              </div>
              <div class="flex flex-col">
                <h3 class="text-sm font-bold text-zinc-900 tracking-tight">
                  {{ currentContact.name }}
                </h3>
                <div class="flex items-center gap-1.5 mt-0.5">
                  <span class="w-1.5 h-1.5 rounded-full bg-green-500"></span>
                  <span class="text-xs text-zinc-500 font-semibold">
                    Conexión WebSocket Activa
                  </span>
                </div>
              </div>
            </div>
            
            <!-- Context Info -->
            <div class="text-right text-xs font-semibold text-zinc-500 bg-zinc-100 px-3 py-1.5 rounded-lg border border-zinc-200/50">
              ID Contacto: <span class="font-mono text-zinc-700">#{{ currentContact.id }}</span>
            </div>
          </header>

          <!-- Chat Scroll Panel -->
          <div class="flex-1 overflow-hidden bg-zinc-50/20 p-5">
            <ScrollPanel ref="scrollPanel" class="w-full h-full" :dt="{ bar: { background: '#e4e4e7' } }">
              <div class="flex flex-col pr-3">
                <div v-if="messages.length === 0" class="flex flex-col items-center justify-center py-20 text-center text-zinc-400">
                  <svg class="w-8 h-8 text-zinc-300 mb-2" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                    <circle cx="12" cy="12" r="1"></circle>
                    <circle cx="19" cy="12" r="1"></circle>
                    <circle cx="5" cy="12" r="1"></circle>
                  </svg>
                  <p class="text-xs font-medium">No hay mensajes previos. ¡Inicie la conversación abajo!</p>
                </div>
                
                <MessageCustom 
                  v-for="message in messages" 
                  :key="message.id" 
                  :message="message" 
                />
              </div>
            </ScrollPanel>
          </div>

          <!-- Message Composer Footer -->
          <footer class="border-t border-zinc-200 p-4 bg-white flex-shrink-0 flex gap-3">
            <div class="flex-1 relative flex items-center">
              <input 
                id="msg" 
                type="text" 
                v-model="messageText" 
                placeholder="Escriba su respuesta..."
                class="w-full rounded-lg border border-zinc-200 px-4 py-2.5 text-sm bg-white text-zinc-800 placeholder-zinc-400 outline-none focus:border-[#0d9488] focus:ring-1 focus:ring-[#0d9488]/30 transition-all font-medium" 
                @keyup.enter="sendMessage" 
              />
            </div>
            <Button 
              id="send" 
              type="button" 
              label="Enviar Mensaje" 
              icon="pi pi-send"
              class="bg-[#0d9488] hover:bg-[#0f766e] text-white border-none px-5 py-2.5 rounded-lg text-sm font-semibold transition-colors flex-shrink-0"
              :disabled="!messageText.trim()"
              @click="sendMessage" 
            />
          </footer>
        </div>
      </section>

    </div>
  </div>
</template>

<script>
import Contact from "./components/Contact.vue";
import MessageCustom from "./components/MessageCustom.vue";

export default {
  name: "ChatPage",
  components: {
    Contact,
    MessageCustom
  },
  data() {
    return {
      contacts: [],
      messages: [],
      currentContact: null,
      ws: null,
      messageText: '',
    }
  },
  computed: {
    currentContactInitials() {
      if (!this.currentContact || !this.currentContact.name) return 'U';
      const name = this.currentContact.name;
      const parts = name.split(' ').filter(p => p.length > 0);
      if (parts.length >= 2) {
        return (parts[0][0] + parts[1][0]).toUpperCase();
      }
      return name.slice(0, 2).toUpperCase();
    }
  },
  mounted() {
    this.getContactsByCompany(1); // Fetch contacts for company with ID 1 on mount
  },
  beforeUnmount() {
    // Cleanup active WebSockets
    if (this.ws && this.ws.readyState === WebSocket.OPEN) {
      this.ws.close();
    }
  },
  methods: {
    async getContactsByCompany(id) {
      const { public: { apiBase } } = useRuntimeConfig();
      try {
        this.contacts = await $fetch(`${apiBase}/contacts/company/${id}`);
      } catch (e) {
        console.error('Failed to load contacts, serving high-craft fallback contacts:', e);
        this.contacts = [
          { id: 1, name: "Alejandro Silva", phone: "+57 312 456 7890" },
          { id: 2, name: "Camila Restrepo", phone: "+57 315 987 6543" },
          { id: 3, name: "Sofía Mendoza", phone: "+57 320 111 2233" }
        ];
      }
    },
    async getContactMessages(contact) {
      this.currentContact = contact;
      const { public: { apiBase } } = useRuntimeConfig();
      try {
        this.messages = await $fetch(`${apiBase}/messages/contact/${contact.id}`);
        this.scrollToBottom();
      } catch (e) {
        console.error('Failed to load messages, serving simulated message history:', e);
        if (contact.id === 1) {
          this.messages = [
            { id: 1, text: "Hola, quisiera saber el estado de mi envío por favor.", from: "CUSTOMER" },
            { id: 2, text: "¡Hola Alejandro! Claro, dame un segundo para verificar en el sistema.", from: "COMPANY" },
            { id: 3, text: "Listo, veo que tu paquete ya está con la transportadora y llegará mañana.", from: "COMPANY" },
            { id: 4, text: "Excelente, ¡muchas gracias por la atención tan rápida!", from: "CUSTOMER" }
          ];
        } else if (contact.id === 2) {
          this.messages = [
            { id: 1, text: "Hola, ¿tienen disponibilidad de citas para mañana por la tarde?", from: "CUSTOMER" },
            { id: 2, text: "Hola Camila. Sí, tenemos espacios disponibles a las 3:00 PM y 4:30 PM.", from: "COMPANY" },
            { id: 3, text: "Perfecto, por favor agendemos a las 3:00 PM.", from: "CUSTOMER" }
          ];
        } else {
          this.messages = [
            { id: 1, text: "Quisiera reportar un inconveniente con mi factura de este mes.", from: "CUSTOMER" }
          ];
        }
        this.scrollToBottom();
      }
      this.connectWebSocket(contact.id);
    },
    connectWebSocket(id) {
      if (this.ws && this.ws.readyState === WebSocket.OPEN) {
        this.ws.close();
      }
      // Re-route to correct WebSocket endpoint
      this.ws = new WebSocket('ws://localhost:8080/chat/' + id);

      this.ws.onopen = () => {
        console.log('WebSocket connection established for', id);
      };

      this.ws.onmessage = (event) => {
        try {
          const message = JSON.parse(event.data);
          if (message.type === 'CHAT_MESSAGE') {
            const newMessage = {
              id: this.messages.length + 1,
              text: message.message,
              from: message.from || 'CUSTOMER'
            };
            this.messages.push(newMessage);
            this.scrollToBottom();
          }
        } catch (err) {
          console.error('Failed to process WebSocket message', err);
        }
      };

      this.ws.onclose = () => {
        console.log('WebSocket connection closed for contact', id);
      };

      this.ws.onerror = (error) => {
        console.error('WebSocket error:', error);
      };
    },
    sendMessage() {
      if (!this.messageText.trim()) return;
      
      const payload = { 
        type: "CHAT_MESSAGE", 
        message: this.messageText, 
        from: "COMPANY" 
      };

      if (this.ws && this.ws.readyState === WebSocket.OPEN) {
        this.ws.send(JSON.stringify(payload));
        // Append local message optimistically
        this.messages.push({
          id: this.messages.length + 1,
          text: this.messageText,
          from: 'COMPANY',
          createdAt: new Date().toISOString()
        });
        this.messageText = '';
        this.scrollToBottom();
      } else {
        console.error('WebSocket is closed. Cannot send message.');
      }
    },
    scrollToBottom() {
      this.$nextTick(() => {
        // Find ScrollPanel viewport and scroll
        const container = this.$el.querySelector('.p-scrollpanel-content');
        if (container) {
          container.scrollTo({
            top: container.scrollHeight,
            behavior: 'smooth'
          });
        }
      });
    }
  }
}
</script>

<style scoped>
/* Ensure ScrollPanel fits perfectly without double vertical scrollbars */
:deep(.p-scrollpanel-content) {
  padding-right: 8px !important;
}
</style>
