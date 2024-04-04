<template>
  <div class="background">
    <!-- MUIC Logo -->
    <div class="logo-container">
      <img src="../assets/images/MUIC_Logo.png" alt="MUIC Logo" />
    </div>
    <div class="container login-container" v-if="show">
      <div class="row justify-content-md-center h-100">
        <div class="col-sm-12 col-md-4 my-auto">
          <div class="form-title">
            <div class="webapp-logo">
              <img src="../assets/images/MuicTALK_Logo.png" alt="Webapp Logo" />
            </div>
            <h2>Login</h2>
          </div>
          <div class="alert alert-danger" role="alert" v-show="logInError.show">
            Failed to Log In: {{ logInError.message }}
          </div>
          <v-form ref="form" v-model="valid" lazy-validation>
            <v-text-field
              v-model="username"
              :rules="usernameRules"
              label="Username"
              required
            ></v-text-field>
            <v-text-field
              v-model="password.password"
              :rules="passwordRules"
              label="Password"
              required
              :append-icon="showPassword ? 'mdi-eye-off' : 'mdi-eye'"
              @click:append="togglePasswordVisibility"
              :append-icon-aria-label="
                showPassword ? 'Hide password' : 'Show password'
              "
              :type="showPassword ? 'text' : 'password'"
            ></v-text-field>
            <v-btn
              :disabled="!valid"
              color="primary"
              class="btn btn-primary"
              @click="submit_login"
              >Login</v-btn
            >
          </v-form>
          <!-- Link to Sign Up -->
          <div class="mt-3">
            Don't have an account?
            <span class="link" @click="show = !show">Sign Up</span>
          </div>
        </div>
      </div>
    </div>
    <!-- Sign Up form -->
    <div class="container login-container" v-else>
      <div class="row justify-content-md-center h-100">
        <div class="col-sm-12 col-md-4 my-auto">
          <div class="form-title">
            <div class="webapp-logo">
              <img src="../assets/images/MuicTALK_Logo.png" alt="Webapp Logo" />
            </div>
            <h2>Sign Up</h2>
          </div>
          <div
            class="alert alert-danger"
            role="alert"
            v-show="signUpError.show"
          >
            Failed to Sign Up: {{ signUpError.message }}
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
              v-model="password.password"
              :rules="passwordRules"
              label="Password"
              required
              :append-icon="showPassword ? 'mdi-eye-off' : 'mdi-eye'"
              @click:append="togglePasswordVisibility"
              :append-icon-aria-label="
                showPassword ? 'Hide password' : 'Show password'
              "
              :type="showPassword ? 'text' : 'password'"
            ></v-text-field>
            <v-btn
              :disabled="!valid"
              color="primary"
              class="btn btn-primary"
              @click="submit_signup"
            >
              Sign Up
            </v-btn>
          </v-form>
          <!-- Link to Login -->
          <div class="mt-3">
            Already have an account?
            <span class="link" @click="show = !show">Login</span>
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
    logInError: {
      message: "",
      show: false,
    },
    signUpError: {
      message: "",
      show: false,
    },
    usernameRules: [(v) => !!v || "Username is required"],
    displayNameRules: [(v) => !!v || "Display Name is required"],
    passwordRules: [(v) => !!v || "Password is required"],
    showPassword: false,
  }),
  methods: {
    togglePasswordVisibility() {
      this.showPassword = !this.showPassword;
    },
    async submit_login() {
      if (this.$refs.form.validate()) {
        //submit to backend to authenticate
        let formData = new FormData();
        formData.append("username", this.username);
        formData.append("password", this.password.password);
        let response = await Vue.axios.post("/api/login", formData);
        if (response.data.success) {
          this.logInError.show = false;
          this.logInError.message = "";
          this.$router.push("/");
        } else {
          this.logInError.show = true;
          this.logInError.message = response.data.message;
          this.password.password = "";
        }
      }
    },
    async submit_signup() {
      if (this.$refs.form.validate()) {
        //submit to backend to authenticate
        let formData = new FormData();
        formData.append("username", this.username);
        formData.append("displayName", this.displayName);
        formData.append("password", this.password.password);
        let response = await Vue.axios.post("/user/create", formData);
        if (response.data.success) {
          this.signUpError.show = false;
          this.signUpError.message = "";
          this.show = !this.show;
          this.displayName = "";
          this.password.password = "";
        } else {
          this.signUpError.show = true;
          this.signUpError.message = response.data.message;
        }
      }
    },
    reset() {
      this.$refs.form.reset();
    },
  },
};
</script>

<style scoped>
@import "https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css";
@import "https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css";
@import "https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js";
@import "../assets/styles/login-styles.css";
@import "../assets/styles/styles.css";

.background {
  background-image: url("../assets/images/41_MUIC_campus.jpg");
  background-size: cover;
  background-position: center;
  height: 100vh; /* Adjust the height as needed */
}

.logo-container {
  margin-bottom: 20px;
}

.webapp-logo {
  text-align: center;
  margin-bottom: 20px;
}

.form-title {
  text-align: center;
}

.alert {
  margin-bottom: 20px;
}

.link {
  color: blue;
  cursor: pointer;
  text-decoration: underline;
}

.link:hover {
  text-decoration: none;
}

.login-container {
  background-color: rgba(
    255,
    255,
    255,
    0.7
  ); /* Adjust the opacity value as needed */
  padding: 20px;
  border-radius: 10px;
}
</style>
