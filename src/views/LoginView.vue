<template>
  <div class="login-background">
    <!-- MUIC Logo -->
    <div class="logo-container">
      <img src="../main/webapp/Images/MUIC_Logo.png" alt="MUIC Logo" />
    </div>
    <div class="container" v-if="show">
      <div class="row justify-content-md-center h-100">
        <div class="col-sm-12 col-md-4 my-auto">
          <div class="form-title">
            <div class="webapp-logo">
              <div>
                <img
                  src="../main/webapp/Images/MuicTALK_Logo.png"
                  alt="Webapp Logo"
                />
              </div>
              <div>
                <h2>Login</h2>
              </div>
            </div>
          </div>
          <v-form ref="form" v-model="valid" lazy-validation>
            <v-text-field
              v-model="username"
              :rules="usernameRules"
              label="Username"
              required
            ></v-text-field>
            <v-text-field
              type="password"
              v-model="password.password"
              :rules="passwordRules"
              label="Password"
              required
            ></v-text-field>

            <v-btn
              :disabled="!valid"
              color="btn btn-primary"
              class="btn btn-primary"
              @click="submit_login"
            >
              Login
            </v-btn>
          </v-form>
          <!-- Link to Sign Up -->
          <div class="mt-3">
            Don't have an account? <a @click="show = !show">Sign Up</a>
          </div>
        </div>
      </div>
    </div>
    <!--    Sign Up form!-->
    <div class="container" v-else>
      <div class="row justify-content-md-center h-100">
        <div class="col-sm-12 col-md-4 my-auto">
          <div class="form-title">
            <div class="webapp-logo">
              <div>
                <img
                  src="../main/webapp/Images/MuicTALK_Logo.png"
                  alt="Webapp Logo"
                />
              </div>
              <div>
                <h2>Sign Up</h2>
              </div>
            </div>
          </div>
          <v-form ref="form" v-model="valid" lazy-validation>
            <v-text-field
              v-model="username"
              :rules="usernameRules"
              label="Username"
              required
            ></v-text-field>
            <v-text-field
              v-model="displayName"
              :rules="displayNameRules"
              label="Display Name"
              required
            ></v-text-field>
            <v-text-field
              type="password"
              v-model="password.password"
              :rules="passwordRules"
              label="Password"
              required
            ></v-text-field>
            <v-btn
              :disabled="!valid"
              color="btn btn-primary"
              class="btn btn-primary"
              @click="submit_signup"
            >
              Sign Up
            </v-btn>
          </v-form>
          <!-- Link to Login -->
          <div class="mt-3">
            Already have an account? <a @click="show = !show">Login</a>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import Vue from "vue";
export default {
  data: () => ({
    valid: true,
    show: true,
    username: "",
    displayName: "",
    password: {
      password: "",
      confirm: "",
    },
    usernameRules: [(v) => !!v || "Username is required"],
    displayNameRules: [(v) => !!v || "Display Name is required"],
    passwordRules: [(v) => !!v || "Password is required"],
  }),
  methods: {
    async submit_login() {
      if (this.$refs.form.validate()) {
        //submit to backend to authenticate
        let formData = new FormData();
        formData.append("username", this.username);
        formData.append("password", this.password);
        let response = await Vue.axios.post("/api/login", formData);
        if (response.data.success) {
          this.$router.push("/");
        }
      }
    },
    async submit_signup() {
      if (this.$refs.form.validate()) {
        //submit to backend to authenticate
        let formData = new FormData();
        formData.append("username", this.username);
        formData.append("displayName", this.displayName);
        formData.append("password", this.password);
        let response = await Vue.axios.post("/user/create", formData);
        if (response.data.success) {
          this.show = !this.show;
          this.$router.push("/login");
        }
      }
    },
    reset() {
      this.$refs.form.reset();
    },
  },
};
</script>

<style>
@import "../main/webapp/styles/login-styles.css";
@import "https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css";
@import "https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css";
@import "../main/webapp/styles/styles.css";
@import "https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js";
</style>
