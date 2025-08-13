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

export default {
    components: {
        Contact,
        MessageCustom
    },
    data() {
        return {
            contacts: [
                { id: 1, name: 'Alice', messages: [{ id: 1, text: 'Hello!' }, { id: 2, text: 'How are you?' }, { id: 3, text: "Bien" }] },
                { id: 2, name: 'Bob', messages: [{ id: 1, text: 'Hi!' }, { id: 2, text: 'Let\'s meet.' }] },
                { id: 3, name: 'Charlie', messages: [{ id: 1, text: 'Good morning!' }, { id: 2, text: 'See you later.' }] }
            ],
            messages: [],
            currentContact: null,
            ws: null,
            messageText: ''
        }

    },
    methods: {
        // You can add methods here if needed
        getContactMessages(contact) {
            console.log('Selected contact ID:', contact);
            const contactFound = this.contacts.find(c => c.id === contact.id);
            this.messages = contactFound ? contactFound.messages : [];
            this.connectWebSocket(contact.name);

            //return contact ? contact.messages : [];
        },
        connectWebSocket(name) {
            // Close existing WebSocket connection if any
            if (this.ws && this.ws.readyState === WebSocket.OPEN) {
                this.ws.close();
            }

            this.ws = new WebSocket('ws://localhost:8080/chat/' + name);

            this.ws.onopen = () => {
                console.log('WebSocket connection established for', name);
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