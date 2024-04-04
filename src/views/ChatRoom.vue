<template>
  <div class="chat-room">
    <h3>Chat Messages</h3>
    <ul class="messages">
      <li v-for="message in messages" :key="message.id">
        {{ message.sender }}: {{ message.text }}
      </li>
    </ul>
    <form @submit.prevent="sendMessage">
      <input type="text" v-model="newMessage" placeholder="Type a message..." />
      <button type="submit">Send</button>
    </form>
  </div>
</template>

<script>
import SockJS from "sockjs-client";
import Stomp from "webstomp-client";
import axios from "axios";
import store from "@/store";

export default {
  data: () => ({
    name: "Schedule",
    username: store.state.username,
    displayName: store.state.name,
    newMessage: "",
    messages: [],
    stompClient: null,
  }),
  computed: {
    groupId() {
      return this.$route.params.groupid;
    },
  },
  methods: {
    connectToWebSocket() {
      const socket = new SockJS("http://localhost:8080/ws"); // Adjust with your actual WebSocket endpoint
      this.stompClient = Stomp.over(socket);
      this.stompClient.connect({}, () => {
        this.stompClient.subscribe(
          `/topic/messages/${this.groupId}`,
          (message) => {
            this.messages.push(JSON.parse(message.body));
          }
        );
      });
    },
    sendMessage() {
      console.log("Send message called", this.newMessage);
      if (this.newMessage.trim()) {
        const chatMessage = {
          // Assuming you're constructing your message object here
          text: this.newMessage,
          sender: "Username", // Example, replace with actual data as needed
        };
        // Make sure the path and the message format match what your backend expects
        this.stompClient.send(
          "/app/chat/${this.groupId}/sendMessage",
          {},
          JSON.stringify(chatMessage)
        );
        this.newMessage = ""; // Clear the message input after sending
      }
    },
    fetchChatMessages() {
      axios
        .get(`http://localhost:8080/api/chat/${this.groupId}`)
        .then((response) => {
          this.messages = response.data;
        })
        .catch((error) => {
          console.error(
            "There was an error fetching the chat messages:",
            error
          );
        });
    },
  },
  mounted() {
    this.connectToWebSocket();
    this.fetchChatMessages();
  },
};
</script>

<style scoped>
/* Add your styles here */
</style>
