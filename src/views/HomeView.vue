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
          <router-link to="/">
            <v-btn color="primary">
              <i class="fa fa-home"> &nbsp; Home</i>
            </v-btn>
          </router-link>
          <router-link to="/schedule">
            <v-btn color="primary">
              <i class="fa fa-calendar"> &nbsp; Schedule</i>
            </v-btn>
          </router-link>
          <router-link to="/chat">
            <v-btn color="primary">
              <i class="fa fa-comments"> &nbsp; Chats</i>
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
    <nav class="navbar navbar-light">
      <div class="container-fluid">
        <div class="user-profile pull-left">
          <img
            src="../main/webapp/Images/default_img.png"
            class="circle"
            alt="User profile picture"
          />
          <p>
            <strong>{{ displayName }}</strong> <br />
            {{ username }}
          </p>
        </div>
        <div class="pull-right">
          <router-link to="/settings">
            <v-btn color="primary">
              <i class="fa fa-cog"></i>
            </v-btn>
          </router-link>
        </div>
      </div>
    </nav>
    <div class="row">
      <div class="col-12"></div>
    </div>
    <div class="row">
      <div class="col-12">
        <table class="table">
          <tr style="vertical-align: middle">
            <td>
              <h3><strong>Groups</strong></h3>
            </td>
            <td style="padding-right: 12px">
              <div class="container-fliud pull-right">
                <v-btn color="primary" class="btn-w40">
                  <i class="fa fa-plus"></i>
                </v-btn>
                <v-btn color="primary" class="btn-w40">
                  <i class="fa fa-pencil"></i>
                </v-btn>
              </div>
            </td>
          </tr>
          <tr style="height: 100px"></tr>
          <tr style="vertical-align: middle">
            <td>
              <h3><strong>Friends</strong></h3>
            </td>
            <td style="padding-right: 12px">
              <div class="container-fliud pull-right">
                <v-btn color="primary" @click="addFriends = !addFriends">
                  <i class="fa fa-plus"></i>
                </v-btn>
                <div class="modal" tabindex="-1" v-if="addFriends === true">
                  <div class="modal-dialog w-50">
                    <div class="modal-content">
                      <header class="modal-header">
                        <slot name="header">
                          <strong> Add Friends! </strong>
                        </slot>
                        <button
                          type="button"
                          class="btn-close"
                          @click="addFriends = !addFriends"
                        ></button>
                      </header>

                      <section class="modal-body my-4">
                        <slot name="body">
                          <div class="row">
                            <div class="col">
                              <v-form id="add-friend-form" lazy-validation>
                                <v-text-field
                                  v-model="friendUser"
                                  label="Search for friend's username"
                                ></v-text-field>
                              </v-form>
                            </div>
                            <div class="col col-md-auto">
                              <v-btn
                                class="mt-3"
                                color="primary"
                                type="submit"
                                form="add-friend-form"
                                @click="sendFriendReq"
                              >
                                <i class="fa fa-plus"></i> &nbsp; Add
                              </v-btn>
                            </div>
                          </div>
                        </slot>
                      </section>
                    </div>
                  </div>
                </div>
                <!--Pop up for adding friends-->
                <v-btn color="primary">
                  <i class="fa fa-pencil"></i>
                </v-btn>
              </div>
            </td>
          </tr>
          <tr style="height: 100px"></tr>
        </table>
      </div>
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
    name: "Home",
    username: store.state.username,
    displayName: store.state.name,
    friendUser: "",
    addFriends: false,
    components: {},
  }),
  methods: {
    async logout() {
      let response = await Vue.axios.get("/api/logout");
      if (response.data.success) {
        this.$router.push("/login");
      }
    },
    showAddFriends() {
      console.log("Show add friends" + this.addFriends);
      this.addFriends = !this.addFriends;
      console.log("Show add friends" + this.addFriends);
    },
    async sendFriendReq() {
      let formData = new FormData();
      formData.append("username", this.username);
      formData.append("userToAdd", this.friendUser);
      let response = await Vue.axios.post("/user/add", formData);
      if (response.data.success) {
        this.addFriends = false;
        this.friendUser = "";
      }
    },
  },
};
</script>
