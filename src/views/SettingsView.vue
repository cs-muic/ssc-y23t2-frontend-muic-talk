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
    <div class="row justify-content-md-center">
      <div class="col col-sm-12 col-md-6 mt-5 mb-4">
        <h2 class="text-center mb-4">Account Settings</h2>
        <div class="container-fluid md-4">
          <div class="user-profile pull-left" style="column-gap: 20px">
            <img
              src="../main/webapp/Images/default_img.png"
              class="circle"
              style="height: 160px; width: 160px"
              alt="User profile picture"
            />
            <h4>
              <strong>{{ displayName }}</strong> <br />
              {{ username }}
            </h4>
          </div>
        </div>
      </div>
      <div class="row justify-content-md-center">
        <div class="col col-sm-12 col-md-6"></div>
      </div>
      <div class="row collapsible justify-content-md-center">
        <div class="container col col-sm-12 col-md-6 mb-4">
          <div class="container-fliud">
            <a class="btn btn-primary disabled"
              ><i class="fa fa-user"></i> General Settings</a
            >
            <a class="btn btn-primary" type="button" href="#"
              ><i class="fa fa-key"></i> Change Password</a
            >
          </div>
        </div>
        <div class="row justify-content-md-center">
          <div class="container col col-sm-12 col-md-6 mb-4">
            <form action="/user/edit?username=${username}" method="post">
              <div class="input-group mb-4 input-group-md">
                <span
                  class="input-group-text"
                  id="displayName"
                  style="width: 40px"
                  ><i class="fa fa-user"></i
                ></span>
                <input
                  type="text"
                  class="form-control py-2"
                  name="displayName"
                  placeholder="Display Name"
                  aria-label="Display Name"
                  aria-describedby="displayName"
                  autocomplete="off"
                  value="${displayName}"
                />
              </div>
              <div class="d-grid gap-2">
                <button class="btn btn-primary" type="submit">
                  <i class="fa fa-save"></i> &nbsp; Save
                </button>
              </div>
            </form>
          </div>
        </div>
      </div>
      <div
        class="row collapsible justify-content-md-center"
        style="display: none"
      >
        <div class="container col col-sm-12 col-md-6 mb-4">
          <div class="container-fliud">
            <a class="btn btn-primary" type="button" href="#"
              ><i class="fa fa-user"></i> General Settings</a
            >
            <a class="btn disabled btn-primary"
              ><i class="fa fa-key"></i> Change Password</a
            >
          </div>
        </div>
        <div class="row justify-content-md-center">
          <div class="container col-sm-12 col-md-6 mb-4">
            <form action="/user/password?username=${username}" method="post">
              <div class="input-group mb-4 input-group-md">
                <span
                  class="input-group-text"
                  id="oldPassword"
                  style="width: 40px"
                  ><i class="fa fa-key"></i
                ></span>
                <input
                  type="password"
                  class="form-control py-2"
                  name="oldPassword"
                  placeholder="Current Password"
                  aria-label="oldPassword"
                  aria-describedby="oldPassword"
                  autocomplete="off"
                  value="${password}"
                />
              </div>
              <div class="input-group mb-4 input-group-md">
                <span class="input-group-text" id="password" style="width: 40px"
                  ><i class="fa fa-key"></i
                ></span>
                <input
                  type="password"
                  class="form-control py-2"
                  name="password"
                  placeholder="New Password"
                  aria-label="Password"
                  aria-describedby="password"
                  autocomplete="off"
                  value="${password}"
                />
              </div>
              <div class="d-grid gap-2">
                <button class="btn btn-primary" type="submit">
                  <i class="fa fa-save"></i> &nbsp; Save
                </button>
              </div>
            </form>
          </div>
        </div>
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
  },
};
</script>
