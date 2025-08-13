<template>
    <div class="grid grid-flow-col grid-rows-3 gap-4">
        <div class="row-span-3 ...">
            Chats
            <Contact v-for="contact in contacts" :key="contact.id" :contact="contact"
                @click="getContactMessages(contact)" />
        </div>
        <div class="col-span-2 ...">02</div>
        <div class="col-span-2 row-span-2 ...">
            Mensajes
            <div class="flex flex-col">
                <div class="p-4 rounded-lg mb-2">
                    <MessageCustom v-for="message in messages" :key="message.id" :message="message" />
                </div>
                <input class="col-md-6" id="msg" type="text" placeholder="enter your message" v-model="messageText" />
                <button class="col-md-1 btn btn-primary" id="send" type="button" @click="sendMessage">send</button>
            </div>
        </div>
    </div>
</template>
<script>
import Contact from "./components/Contact.vue";
import MessageCustom from "./components/MessageCustom.vue";
import { getContactsByCompany } from "./helpers/Contact";
import { getMessagesByContact } from "./helpers/Message";
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
            messageText: ''
        }

    },
    mounted() {
        this.getContactsByCompany(1); // Fetch contacts for company with ID 1 on mount
    },
    methods: {
        // You can add methods here if needed
        getContactsByCompany(id) {
            getContactsByCompany(id).then(contacts => {
                this.contacts = contacts;
            });
        },
        getContactMessages(contact) {
            getMessagesByContact(contact.id).then(messages => {
                this.messages = messages;
            });

            this.connectWebSocket(contact.id);

            //return contact ? contact.messages : [];
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
                console.log('Received message:', message);
                if (message.type === 'CHAT_MESSAGE') {
                    const newMessage = {
                        id: this.messages.length + 1, // Simple ID generation
                        text: message.message
                    };
                    this.messages.push(newMessage);
                    console.log('New message added:', newMessage);
                    console.log('Current messages:', this.messages);
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
            this.ws.send(JSON.stringify({ type:"CHAT_MESSAGE",message: this.messageText,from: "COMPANY" }));
            this.messageText = ''; // Clear the input field after sending
        }

    }
}
</script>