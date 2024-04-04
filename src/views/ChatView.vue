<style scoped>
@import "https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css";
@import "https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css";
@import "../assets/styles/styles.css";
</style>

<template>
  <div class="container mt-4">
    <nav class="navbar navbar-light bg-light">
      <div class="container-fluid">
        <a class="navbar-brand"><strong>MUIC Talk</strong></a>
        <div>
          <router-link to="/" class="mr-2">
            <v-btn color="primary">
              <i class="fa fa-home"></i> &nbsp; Home
            </v-btn>
          </router-link>
          <router-link to="/schedule" class="mr-2">
            <v-btn color="primary">
              <i class="fa fa-calendar"></i> &nbsp; Schedule
            </v-btn>
          </router-link>
          <router-link to="/chat" class="mr-2">
            <v-btn color="primary">
              <i class="fa fa-comments"></i> &nbsp; Chats
            </v-btn>
          </router-link>
        </div>
        <div>
          <v-btn color="primary" @click="logout">
            <i class="fa fa-sign-out"></i>
          </v-btn>
        </div>
      </div>
    </nav>
    <v-card height="85vh">
      <v-layout>
        <v-navigation-drawer floating permanent height="85vh">
          <v-list nav dense>
            <h3>Groups</h3>
            <v-list-item-group
              v-model="selectedGroupIndex"
              color="primary"
              @change="fetchChat"
            >
              <v-list-item
                v-for="item in this.groups.groups"
                :key="item.groupId.string"
              >
                <v-list-item-content>
                  <v-list-item-title
                    v-text="item.name.string"
                  ></v-list-item-title>
                </v-list-item-content>
              </v-list-item>
            </v-list-item-group>
          </v-list>
        </v-navigation-drawer>
        <v-main style="height: 85vh" class="p-3">
          <div
            class="container container-fluid"
            v-if="selectedGroupIndex === undefined"
            align="center"
            style="text-align: center"
          >
            <strong>Select a group to start chatting! :D</strong>
          </div>
          <div v-else>
            <nav
              class="navbar navbar-light bg-light"
              style="border-radius: 10px"
            >
              <div class="ml-2">
                <strong>{{ this.messages.groupName }}</strong>
              </div>
            </nav>
            <div style="position: relative">
              <v-card style="height: 65vh; border-radius: 10px">
                <v-navigation-drawer
                  permanent
                  width="100%"
                  style="flex-direction: column-reverse"
                >
                  <v-list nav dense disabled>
                    <v-list-item-group color="primary">
                      <v-list-item
                        v-for="item in this.messages.messages"
                        :key="item.messageId.string"
                      >
                        <v-list-item-content>
                          <v-list-item-title
                            v-text="item.sender.string"
                          ></v-list-item-title>
                          <v-list-item-subtitle
                            v-text="item.message.string"
                          ></v-list-item-subtitle>
                        </v-list-item-content>
                      </v-list-item>
                    </v-list-item-group>
                  </v-list>
                </v-navigation-drawer>
              </v-card>
            </div>
            <div
              class="row px-2"
              style="
                position: absolute;
                bottom: 0;
                width: 100%;
                border-radius: 10px;
              "
            >
              <div class="col">
                <v-form id="send-message" lazy-validation>
                  <v-text-field
                    v-model="messages.sendMessage"
                    label="Send a message"
                  ></v-text-field>
                </v-form>
              </div>
              <div class="col col-md-auto">
                <v-btn
                  class="mt-3"
                  color="primary"
                  type="submit"
                  form="send-message"
                  @click="sendMessage"
                >
                  <i class="fa fa-paper-plane"></i>
                </v-btn>
              </div>
            </div>
          </div>
        </v-main>
      </v-layout>
    </v-card>
  </div>
</template>

<script>
import Vue from "vue";
import VueRouter from "vue-router";
import store from "../store/index";
Vue.use(VueRouter);
export default {
  data: () => ({
    name: "Chat",
    username: store.state.username,
    displayName: store.state.name,
    groups: {
      groups: [],
      headers: [
        { text: "", value: "name" },
        { text: "", value: "" },
      ],
    },
    messages: {
      groupId: "",
      groupName: "",
      messages: [],
      sendMessage: "",
    },
    selectedGroupIndex: undefined,
    timer: null,
  }),
  methods: {
    async logout() {
      let response = await Vue.axios.get("/api/logout");
      if (response.data.success) {
        this.$router.push("/login");
      }
    },
    async fetchGroups() {
      try {
        let formData = new FormData();
        formData.append("username", store.state.username);
        const response = await Vue.axios.post("/user/groups", formData);
        this.groups.groups = response.data.groups;
        this.groups.groups.map(({ groupId }) => groupId.string).join(", ");
        this.groups.groups.map(({ name }) => name.string).join(", ");
        console.log(this.groups.groups);
      } catch (error) {
        console.log("There was an error fetching the groups:", error);
      }
    },
    async fetchChat() {
      try {
        if (this.selectedGroupIndex !== undefined) {
          console.log(this.selectedGroupIndex);
          let groupId =
            this.groups.groups[this.selectedGroupIndex].groupId.string;
          console.log(groupId);
          let formData = new FormData();
          formData.append("username", store.state.username);
          let url = "/user/chat/" + groupId;
          console.log(url);
          const response = await Vue.axios.post(url, formData);
          console.log(response.data.success);
          if (response.data.success) {
            this.messages.messages = response.data.chat;
            this.messages.groupId = groupId;
            this.messages.groupName =
              this.groups.groups[this.selectedGroupIndex].name.string;
          }
        }
      } catch (error) {
        console.log("There was an error fetching the groups:", error);
      }
    },
    async sendMessage() {
      let formData = new FormData();
      let url = "/user/chat/" + this.messages.groupId + "/send";
      formData.append("username", this.username);
      formData.append("message", this.messages.sendMessage);
      let response = await Vue.axios.post(url, formData);
      if (response.data.success) {
        this.messages.sendMessage = "";
      } else {
        alert("Failed to send message.");
      }
    },
    refresh() {
      this.timer = setInterval(() => {
        this.fetchChat();
      }, 1000);
    },
  },
  async mounted() {
    await this.fetchGroups();
    this.refresh();
  },
  beforeDestroy() {
    clearInterval(this.timer);
  },
};
</script>
