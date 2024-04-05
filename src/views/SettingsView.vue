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
    <div class="row justify-content-md-center">
      <div class="col col-sm-12 col-md-6 mt-5 mb-4">
        <h2 class="text-center mb-4">Account Settings</h2>
        <div class="container-fluid md-4">
          <div class="user-profile pull-left" style="column-gap: 20px">
            <img
              src="../assets/images/default_img.png"
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
                    deleteAccount.show = false;
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
                    deleteAccount.show = false;
                  "
                >
                  <i class="fa fa-key"></i> &nbsp; Password
                </v-btn>
              </v-list-item>
              <v-list-item>
                <v-btn
                  color="error"
                  width="100%"
                  @click="
                    changePassword.show = false;
                    changeDisplayName.show = false;
                    deleteAccount.show = true;
                  "
                >
                  <i class="fa fa-trash"></i> &nbsp; Delete Account
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
              <div
                class="alert alert-danger mt-5"
                role="alert"
                v-show="changeDisplayName.error"
              >
                {{ changeDisplayName.message }}
              </div>
              <div
                class="alert alert-success mt-5"
                role="alert"
                v-show="changeDisplayName.success"
              >
                {{ changeDisplayName.message }}
              </div>
            </v-form>
            <v-form ref="form" v-show="changePassword.show" lazy-validation>
              <h4>Change Password</h4>
              <v-text-field
                type="password"
                v-model="changePassword.oldPassword"
                :rules="changePassword.passwordRules"
                label="Old Password"
                required
              ></v-text-field>
              <v-text-field
                type="password"
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
              <div
                class="alert alert-danger mt-5"
                role="alert"
                v-show="changePassword.error"
              >
                {{ changePassword.message }}
              </div>
              <div
                class="alert alert-success mt-5"
                role="alert"
                v-show="changePassword.success"
              >
                {{ changePassword.message }}
              </div>
            </v-form>
            <v-form ref="form" v-show="deleteAccount.show" lazy-validation>
              <h4>Delete Account</h4>
              <strong>This action cannot be undone!</strong>
              <v-text-field
                type="password"
                v-model="deleteAccount.password"
                :rules="deleteAccount.passwordRules"
                label="Confirm Password"
                required
              ></v-text-field>
              <v-btn
                color="error"
                class="btn btn-primary"
                @click="submit_deleteAccount"
              >
                <i class="fa fa-trash"></i> &nbsp; Delete
              </v-btn>
              <div
                class="alert alert-danger mt-5"
                role="alert"
                v-show="deleteAccount.error"
              >
                {{ deleteAccount.message }}
              </div>
            </v-form>
          </v-main>
        </v-layout>
      </v-card>
    </div>
    <div>
      <!-- Bye Bye message -->
      <transition name="fade">
        <div v-if="showByeBye" class="bye-bye-message-overlay">
          <div class="bye-bye-message">
            <h4>BYE BYE</h4>
          </div>
        </div>
      </transition>
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
    deleteAccount: {
      show: false,
      password: "",
      passwordRules: [(v) => !!v || "Password is required"],
      error: false,
      message: false,
    },
    showByeBye: false,
  }),
  methods: {
    async logout() {
      let response = await Vue.axios.get("/api/logout");
      if (response.data.success) {
        this.$router.push("/login");
      }
    },
    async submit_displayName() {
      let formData = new FormData();
      formData.append("username", this.username);
      formData.append("displayName", this.changeDisplayName.newDisplayName);
      let response = await Vue.axios.post("/api/user/displayName", formData);
      if (response.data.success) {
        this.displayName = this.changeDisplayName.newDisplayName;
        store.state.name = this.displayName;
        this.changeDisplayName.success = true;
        this.changeDisplayName.message = response.data.message;
        this.changeDisplayName.error = false;
      } else {
        this.changeDisplayName.error = true;
        this.changeDisplayName.success = false;
        this.changeDisplayName.message = response.data.message;
      }
    },
    async submit_password() {
      let formData = new FormData();
      formData.append("username", this.username);
      formData.append("oldPassword", this.changePassword.oldPassword);
      formData.append("newPassword", this.changePassword.newPassword);
      let response = await Vue.axios.post("/api/user/password", formData);
      if (response.data.success) {
        console.log("yay");
        this.changePassword.oldPassword = "";
        this.changePassword.newPassword = "";
        this.changePassword.success = true;
        this.changePassword.message = response.data.message;
        this.changePassword.error = false;
      } else {
        console.log("aw");
        this.changePassword.oldPassword = "";
        this.changePassword.newPassword = "";
        this.changePassword.error = true;
        this.changePassword.success = false;
        this.changePassword.message = response.data.message;
      }
    },
    async submit_deleteAccount() {
      let formData = new FormData();
      formData.append("username", this.username);
      formData.append("password", this.deleteAccount.password);
      let verifyResponse = await Vue.axios.post(
        "/api/user/password/verify",
        formData
      );
      if (verifyResponse.data.success) {
        let deleteResponse = await Vue.axios.post("/api/user/delete", formData);
        if (deleteResponse.data.success) {
          this.showByeBye = true; // Show "BYE BYE" message
          setTimeout(() => {
            this.$router.push("/login");
          }, 2000); // Redirect to login page after 2 seconds
        } else {
          this.deleteAccount.error = true;
          this.deleteAccount.message = verifyResponse.data.message;
        }
      } else {
        this.deleteAccount.error = true;
        this.deleteAccount.message = verifyResponse.data.message;
      }
    },
  },
};
</script>

<style scoped>
/* Add new styles for smooth transition */
.fade-enter-active,
.fade-leave-active {
  transition: opacity 0.5s ease;
}

.fade-enter, .fade-leave-to /* .fade-leave-active in <2.1.8 */ {
  opacity: 0;
}

.bye-bye-message-overlay {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background-color: rgba(
    255,
    255,
    255,
    0.8
  ); /* White background with opacity */
  z-index: 9999; /* Ensure it's above other content */
  display: flex;
  justify-content: center;
  align-items: center;
}

.bye-bye-message h4 {
  font-size: 4rem;
  color: #550a8a;
  font-family: "Arial", sans-serif;
  font-weight: bold;
  text-transform: uppercase;
}
</style>
