<style scoped>
@import "https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css";
@import "https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css";
@import "https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js";
@import "../main/webapp/styles/styles.css";
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
    <div v-if="showAll">
      <!--Put your code here !-->
      <v-virtual-scroll
        :items="groups.groups"
        :item-height="75"
        max-height="80vh"
      >
        <template v-slot:default="{ item }">
          <v-list-item>
            <v-list-item-content>
              <v-btn depressed height="75" class="mr-4" @click="goToChat(item)">
                {{ item.name.string }}
              </v-btn>
            </v-list-item-content>
          </v-list-item>
        </template>
      </v-virtual-scroll>
    </div>
    <div class="mt-5" v-else>
      <nav class="navbar navbar-light bg-light" style="border-radius: 10px">
        <div class="container-fluid pull-left">
          <v-btn color="primary" @click="goBack">
            <i class="fa fa-arrow-left"></i>
          </v-btn>
          <div style="width: 100%">
            <p style="text-align: left">
              {{ this.currentGroup }}
            </p>
          </div>
        </div>
      </nav>
    </div>
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
    showAll: true,
    currentGroup: "",
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
    async goToChat(chatId) {
      try {
        console.log(chatId.groupId.string);
        console.log(chatId.name.string);
        let formData = new FormData();
        formData.append("username", store.state.username);
        let url = "/user/chat/" + chatId.groupId.string;
        const response = await Vue.axios.post(url, formData);
        console.log(response.data.success);
        console.log(this.groups.groups);
        this.showAll = false;
        this.currentGroup = chatId.name.string;
        console.log(this.showAll);
      } catch (error) {
        console.log("There was an error fetching the groups:", error);
      }
    },
    async goBack() {
      this.showAll = true;
      //await this.fetchGroups();
    },
  },
  async mounted() {
    await this.fetchGroups();
  },
};
</script>
