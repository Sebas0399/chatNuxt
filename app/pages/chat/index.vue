<template>
    <div class="h-screen w-full">
        <div class="grid grid-cols-3 gap-4 h-full p-4">

            <!-- Lista de chats -->
            <aside class="col-span-0 flex flex-col rounded-lg border overflow-hidden">
                <header class="px-4 py-3 border-b font-semibold">
                    Chats
                </header>
                <div class="flex-1 overflow-auto p-2 space-y-1">
                    <Contact v-for="contact in contacts" :key="contact.id" :contact="contact"
                        class="cursor-pointer p-2 rounded hover:bg-opacity-20" @click="getContactMessages(contact)" />
                </div>
            </aside>

            <!-- Mensajes -->
            <section class="col-span-2 flex flex-col rounded-lg border overflow-hidden">
                <header class="px-4 py-3 border-b font-semibold">
                    Mensajes
                </header>

                <!-- Scroll de mensajes -->
                <div class="flex-1 overflow-hidden">
                    <ScrollPanel style="width: 100%; height: 100%">
                        <div class="p-4 space-y-2">
                            <MessageCustom v-for="message in messages" :key="message.id" :message="message" />
                        </div>
                    </ScrollPanel>
                </div>

                <!-- Input de mensaje -->
                <footer class="border-t p-3 flex gap-2">
                    <input id="msg" type="text" v-model="messageText" placeholder="Escriba su mensaje..."
                        class="flex-1 rounded border px-3 py-2" @keyup.enter="sendMessage" />
                    <Button id="send" type="button" label="Enviar" @click="sendMessage" />
                </footer>
            </section>

        </div>
    </div>
</template>
<script>
import Contact from "./components/Contact.vue";
import MessageCustom from "./components/MessageCustom.vue";
export default {
    components: {
        Contact,
        MessageCustom
    },
    data() {
        return {
            contacts: [
            ],
            messages: [],
            currentContact: null,
            ws: null,
            messageText: '',
        }

    },
    mounted() {
        this.getContactsByCompany(1); // Fetch contacts for company with ID 1 on mount
    },
    methods: {
        // You can add methods here if needed
        async getContactsByCompany(id) {
            const { public: { apiBase } } = useRuntimeConfig();
            try {
                this.contacts = await $fetch(`${apiBase}/contacts/company/${id}`);
            } catch (e) {
                console.error('Failed to load contacts', e);
            }
        },
        async getContactMessages(contact) {
            this.currentContact = contact;
            const { public: { apiBase } } = useRuntimeConfig();
            try {
                this.messages = await $fetch(`${apiBase}/messages/contact/${contact.id}`);
            } catch (e) {
                console.error('Failed to load messages', e);
                this.messages = [];
            }
            this.connectWebSocket(contact.id);
        },
        connectWebSocket(id) {
            // Close existing WebSocket connection if any
            if (this.ws && this.ws.readyState === WebSocket.OPEN) {
                this.ws.close();
            }
            this.ws = new WebSocket('ws://localhost:8080/chat/' + id);

            this.ws.onopen = () => {
                console.log('WebSocket connection established for', id);
            };

            this.ws.onmessage = (event) => {
                const message = JSON.parse(event.data);
                if (message.type === 'CHAT_MESSAGE') {
                    const newMessage = {
                        id: this.messages.length + 1, // Simple ID generation
                        text: message.message
                    };
                    this.messages.push(newMessage);
                    return;
                }

            };

            this.ws.onclose = () => {
                console.log('WebSocket connection closed for', name);
            };

            this.ws.onerror = (error) => {
                console.error('WebSocket error:', error);
            };
        },
        sendMessage() {
            this.ws.send(JSON.stringify({ type: "CHAT_MESSAGE", message: this.messageText, from: "COMPANY" }));
            this.messageText = ''; // Clear the input field after sending
        }

    }
}
</script>