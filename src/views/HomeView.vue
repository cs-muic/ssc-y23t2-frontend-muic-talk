<style>
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
            <strong>displayName</strong> <br />
            username
          </p>
        </div>
        <div class="pull-right">
          <v-btn color="primary" class="btn btn-primary">
            <!--This should go to user edit page-->
            <i class="fa fa-cog"></i>
          </v-btn>
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
                <button
                  class="btn btn-primary btn-w40"
                  type="button"
                  data-bs-toggle="modal"
                  data-bs-target="#add-friend"
                >
                  <i class="fa fa-plus"></i>
                </button>
                <!--Pop up for adding friends-->
                <div
                  class="modal fade"
                  id="add-friend"
                  tabindex="-1"
                  aria-labelledby="exampleModalLabel"
                  aria-hidden="true"
                >
                  <div class="modal-dialog">
                    <div class="modal-content">
                      <div class="modal-header">
                        <h1 class="modal-title fs-5" id="exampleModalLabel">
                          Add Friend
                        </h1>
                        <button
                          type="button"
                          class="btn-close"
                          data-bs-dismiss="modal"
                          aria-label="Close"
                        ></button>
                      </div>

                      <div class="modal-body my-4">
                        <form action="/user/add" method="post">
                          <div class="input-group mb-4 input-group-md">
                            <span
                              class="input-group-text"
                              id="friendUser"
                              style="width: 40px"
                              ><i class="fa fa-user"></i
                            ></span>
                            <input
                              type="text"
                              class="form-control py-2"
                              name="friendUser"
                              placeholder="uXXXXXXX"
                              aria-label="Friend Username"
                              aria-describedby="friendUser"
                              autocomplete="off"
                            />
                          </div>
                          <div class="d-grid gap-2">
                            <button class="btn btn-primary" type="submit">
                              <i class="fa fa-plus"></i> &nbsp; Add
                            </button>
                          </div>
                        </form>
                      </div>
                    </div>
                  </div>
                </div>
                <a class="btn btn-primary btn-w40" type="button" href="/"
                  ><i class="fa fa-pencil"></i
                ></a>
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
export default {
  data: () => ({
    name: "Home",
    username: "",
    displayName: "",
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
