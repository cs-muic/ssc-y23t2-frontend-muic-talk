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
              <i class="fa fa-home"></i> &nbsp; Home
            </v-btn>
          </router-link>
          <router-link to="/schedule">
            <v-btn color="primary">
              <i class="fa fa-calendar"></i> &nbsp; Schedule
            </v-btn>
          </router-link>
          <router-link to="/chat">
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
      <v-card>
        <v-layout>
          <v-navigation-drawer floating permanent height="100%">
            <v-list density="compact" nav>
              <v-list-item>
                <v-btn
                  color="primary"
                  width="100%"
                  @click="
                    changePassword.show = false;
                    changeDisplayName.show = true;
                  "
                >
                  <i class="fa fa-user"></i> &nbsp; General
                </v-btn>
              </v-list-item>
              <v-list-item color="primary">
                <v-btn
                  color="primary"
                  width="100%"
                  @click="
                    changePassword.show = true;
                    changeDisplayName.show = false;
                  "
                >
                  <i class="fa fa-key"></i> &nbsp; Password
                </v-btn>
              </v-list-item>
            </v-list>
          </v-navigation-drawer>
          <v-main style="height: 50vh" class="p-3">
            <v-form ref="form" v-show="changeDisplayName.show" lazy-validation>
              <h4>General Settings</h4>
              <v-text-field
                v-model="changeDisplayName.newDisplayName"
                :rules="changeDisplayName.displayNameRules"
                label="New Display Name"
                required
              ></v-text-field>
              <v-btn
                color="primary"
                class="btn btn-primary"
                @click="submit_displayName"
              >
                <i class="fa fa-save"></i> &nbsp; Save
              </v-btn>
            </v-form>
            <v-form ref="form" v-show="changePassword.show" lazy-validation>
              <h4>Change Password</h4>
              <v-text-field
                v-model="changePassword.oldPassword"
                :rules="changePassword.passwordRules"
                label="Old Password"
                required
              ></v-text-field>
              <v-text-field
                v-model="changePassword.newPassword"
                :rules="changePassword.passwordRules"
                label="New Password"
                required
              ></v-text-field>
              <v-btn
                color="primary"
                class="btn btn-primary"
                @click="submit_password"
              >
                <i class="fa fa-save"></i> &nbsp; Save
              </v-btn>
            </v-form>
          </v-main>
        </v-layout>
      </v-card>
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
    changeDisplayName: {
      show: true,
      newDisplayName: "",
      displayNameRules: [(v) => !!v || "Display Name is required"],
      success: false,
      error: false,
      message: "",
    },
    changePassword: {
      show: false,
      oldPassword: "",
      newPassword: "",
      passwordRules: [(v) => !!v || "Password is required"],
      success: false,
      error: false,
      message: false,
    },
  }),
  methods: {
    async logout() {
      let response = await Vue.axios.get("/api/logout");
      if (response.data.success) {
        this.$router.push("/login");
      }
    },
    async submit_displayName() {
      if (this.$refs.form.validate()) {
        //submit to backend to authenticate
        let formData = new FormData();
        formData.append("username", this.username);
        formData.append(
          "newDisplayName",
          this.changeDisplayName.newDisplayName
        );
        let response = await Vue.axios.post("/user/displayName", formData);
        if (response.data.success) {
          this.displayName = this.changeDisplayName.newDisplayName;
          this.changeDisplayName.success = true;
          this.changeDisplayName.message = response.data.message;
          this.changeDisplayName.error = false;
        } else {
          this.changeDisplayName.error = true;
          this.changeDisplayName.success = false;
          this.changeDisplayName.message = response.data.message;
        }
      }
    },
    async submit_password() {
      if (this.$refs.form.validate()) {
        //submit to backend to authenticate
        let formData = new FormData();
        formData.append("username", this.username);
        formData.append("oldPassword", this.changePassword.oldPassword);
        formData.append("newPassword", this.changePassword.newPassword);
        let response = await Vue.axios.post("/user/password", formData);
        if (response.data.success) {
          this.changePassword.oldPassword = "";
          this.changePassword.newPassword = "";
          this.changeDisplayName.success = true;
          this.changeDisplayName.message = response.data.message;
          this.changeDisplayName.error = false;
        } else {
          this.changePassword.oldPassword = "";
          this.changePassword.newPassword = "";
          this.changeDisplayName.error = true;
          this.changeDisplayName.success = false;
          this.changeDisplayName.message = response.data.message;
        }
      }
    },
  },
};
</script>
