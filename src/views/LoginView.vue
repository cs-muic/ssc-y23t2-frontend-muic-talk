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
          <form action="/api/login" method="post">
            <!-- Username -->
            <div class="input-group mb-4 input-group-md">
              <span
                class="input-group-text"
                id="login-username"
                style="width: 40px"
                ><i class="fa fa-user"></i>
              </span>
              <input
                type="text"
                class="form-control"
                name="username"
                placeholder="uXXXXXXX"
                aria-label="Username"
                aria-describedby="login-username"
              />
            </div>
            <!-- Password -->
            <div class="input-group mb-4 input-group-md">
              <span
                class="input-group-text"
                id="login-password"
                style="width: 40px"
                ><i class="fa fa-key"></i>
              </span>
              <input
                type="password"
                class="form-control"
                name="password"
                placeholder="Password"
                aria-label="Password"
                aria-describedby="login-password"
              />
            </div>
            <!-- Login Button -->
            <div class="d-grid gap-2">
              <button class="btn btn-primary" type="submit">
                <i class="fa fa-sign-in"></i>&nbsp;Login
              </button>
            </div>
          </form>
          <!-- Link to Sign Up -->
          <div class="mt-3">
            Don't have an account? <a @click="show = !show">Sign Up</a>
          </div>
        </div>
      </div>
    </div>
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
          <form action="/user/create" method="post">
            <!-- Username -->
            <div class="input-group mb-4 input-group-md">
              <span
                class="input-group-text"
                id="signup-username"
                style="width: 40px"
                ><i class="fa fa-user"></i>
              </span>
              <input
                type="text"
                class="form-control"
                name="username"
                placeholder="uXXXXXXX"
                aria-label="Username"
                aria-describedby="signup-username"
                autocomplete="off"
                value=""
                required
              />
            </div>
            <!-- Display Name -->
            <div class="input-group mb-4 input-group-md">
              <span
                class="input-group-text"
                id="signup-displayName"
                style="width: 40px"
                ><i class="fa fa-user"></i>
              </span>
              <input
                type="text"
                class="form-control"
                name="displayName"
                placeholder="Display Name"
                aria-label="DisplayName"
                aria-describedby="signup-displayName"
                autocomplete="off"
                value=""
                required
              />
            </div>
            <!-- Password -->
            <div class="input-group mb-4 input-group-md">
              <span
                class="input-group-text"
                id="signup-password"
                style="width: 40px"
                ><i class="fa fa-key"></i>
              </span>
              <input
                type="password"
                class="form-control"
                name="password"
                placeholder="Password"
                aria-label="password"
                aria-describedby="signup-password"
                autocomplete="off"
                value=""
                required
              />
            </div>
            <!-- Confirmed Password -->
            <div class="input-group mb-4 input-group-md">
              <span
                class="input-group-text"
                id="signup-cpassword"
                style="width: 40px"
                ><i class="fa fa-key"></i>
              </span>
              <input
                type="password"
                class="form-control"
                name="confirm-password"
                placeholder="Confirm Password"
                aria-label="Password"
                aria-describedby="signup-cpassword"
                autocomplete="off"
                required
              />
            </div>
            <!-- Sign Up Button -->
            <div class="d-grid gap-2">
              <button class="btn btn-primary" type="submit">
                <i class="fa fa-user-plus"></i>&nbsp;Sign Up
              </button>
            </div>
          </form>
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
export default {
  // reactive state
  data() {
    return {
      show: true,
    };
  },
  // functions that mutate state and trigger updates
  methods: {
    increment() {},
  },

  // lifecycle hooks
  mounted() {},
};

// Ensure the error message is displayed even if the sign-up form is hidden
const errorMessage = document.querySelector(".container.error .alert-danger");
if (errorMessage) {
  errorMessage.style.display = "block";
}
</script>

<style>
@import "../main/webapp/styles/login-styles.css";
@import "https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css";
@import "https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css";
@import "../main/webapp/styles/styles.css";
@import "https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js";
</style>
