<style scoped>
@import "https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css";
@import "https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css";
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
                <template>
                  <v-dialog v-model="createGroupDialog" max-width="500">
                    <template v-slot:activator="{ props: activatorProps }">
                      <!-- Button to open create group dialog -->
                      <v-btn
                        color="primary"
                        v-bind="activatorProps"
                        @click="createGroupDialog = true"
                        class="mr-2"
                      >
                        <i class="fa fa-plus"></i>
                        &nbsp; Create
                      </v-btn>
                    </template>

                    <!-- Create Group Dialog -->
                    <v-card>
                      <v-card-title
                        class="d-flex justify-space-between align-center"
                        >Create New Group
                        <v-btn
                          color="primary"
                          @click="createGroupDialog = false"
                        >
                          <i class="fa fa-close"></i></v-btn
                      ></v-card-title>
                      <v-card-text>
                        <v-row dense>
                          <div class="row ml-2 px-2">
                            <div class="col col-md-auto mt-6">
                              <i class="fa fa-users"></i>
                            </div>
                            <div class="col">
                              <v-text-field
                                label="Group Name"
                                v-model="newGroupName"
                              ></v-text-field>
                            </div>
                            <div class="col col-md-auto">
                              <v-btn
                                class="mt-3"
                                color="primary"
                                @click="createGroup"
                                >Create</v-btn
                              >
                            </div>
                          </div>
                        </v-row>
                        <!-- Include other fields as necessary -->
                      </v-card-text>
                    </v-card>
                  </v-dialog>
                </template>
                <template>
                  <v-dialog v-model="inviteGroupDialog" max-width="500">
                    <template v-slot:activator="{ props: activatorProps }">
                      <!-- Button to open join group dialog -->
                      <v-btn
                        color="primary"
                        v-bind="activatorProps"
                        @click="inviteGroupDialog = true"
                        class="mr-2"
                      >
                        <i class="fa fa-user-plus"></i>
                        &nbsp; Invite
                      </v-btn>
                    </template>

                    <!-- Invite To Group Dialog -->
                    <v-card>
                      <v-card-title
                        class="d-flex justify-space-between align-center"
                      >
                        Invite a user to a group!
                        <v-btn
                          color="primary"
                          @click="inviteGroupDialog = false"
                        >
                          <i class="fa fa-close"></i>
                        </v-btn>
                      </v-card-title>
                      <v-card-text>
                        <v-row dense>
                          <div class="row ml-2 px-2">
                            <div class="col col-md-auto mt-6">
                              <i class="fa fa-user-plus"></i>
                            </div>
                            <div class="col">
                              <v-text-field
                                label="User to invite"
                                v-model="invite.user"
                                required
                              ></v-text-field>
                            </div>
                          </div>
                          <div class="row ml-2 px-2">
                            <div class="col col-md-auto mt-6">
                              <i class="fa fa-user-plus"></i>
                            </div>
                            <div class="col">
                              <v-autocomplete
                                v-model="invite.group"
                                :items="groups.groups"
                                item-text="name.string"
                                item-value="groupId.string"
                                dense
                                filled
                                label="Group"
                              >
                              </v-autocomplete>
                            </div>
                          </div>
                          <div class="row ml-2 px-2">
                            <div class="col col-md-auto">
                              <v-btn
                                class="mt-3"
                                color="primary"
                                @click="inviteToGroup()"
                                >Invite</v-btn
                              >
                            </div>
                          </div>
                        </v-row>
                      </v-card-text>
                    </v-card>
                  </v-dialog>
                </template>
                <v-btn color="primary" @click="groups.edit = !groups.edit">
                  <i class="fa fa-pencil"></i>
                  &nbsp; Edit
                </v-btn>
              </div>
            </td>
          </tr>
          <tr class="container container-fluid">
            <td colspan="100%">
              <v-data-table
                style="width: 100%"
                fill-width
                :footer-props="{
                  'items-per-page-options': [5],
                }"
                :items-per-page="5"
                :headers="groups.headers"
                :items="groups.groups"
                :sort-by="groups.sortBy"
              >
                <template v-slot:item="row">
                  <tr>
                    <td>
                      {{ row.item.name.string }}
                    </td>
                    <td width="100">
                      <v-btn
                        dark
                        small
                        color="error"
                        v-if="groups.edit"
                        @click="leaveGroup(row.item.groupId.string)"
                      >
                        <i class="fa fa-user-times"></i>
                        &nbsp; Leave
                      </v-btn>
                    </td>
                  </tr>
                </template>
              </v-data-table>
            </td>
          </tr>
          <!-- Friends -->
          <tr style="vertical-align: middle">
            <td>
              <h3><strong>Friends</strong></h3>
            </td>
            <td style="padding-right: 12px">
              <div class="container-fliud pull-right">
                <template>
                  <v-dialog v-model="addFriends.dialog" max-width="500">
                    <template v-slot:activator="{ props: activatorProps }">
                      <v-btn
                        color="primary"
                        v-bind="activatorProps"
                        @click="friendsModal"
                        class="mr-2"
                        ><i class="fa fa-plus"></i>
                        &nbsp; Add
                      </v-btn>
                    </template>

                    <v-card>
                      <v-card-title
                        class="d-flex justify-space-between align-center"
                      >
                        Add Friends!
                        <v-btn color="primary" @click="friendsModal">
                          <i class="fa fa-close"></i>
                        </v-btn>
                      </v-card-title>
                      <v-card-text>
                        <v-row dense>
                          <div class="row ml-2 px-2">
                            <div class="col col-md-auto mt-6">
                              <i class="fa fa-user"></i>
                            </div>
                            <div class="col">
                              <v-form id="add-friend-form" lazy-validation>
                                <v-text-field
                                  v-model="addFriends.toAdd"
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
                          <div
                            class="alert alert-danger"
                            role="alert"
                            v-show="addFriends.error"
                          >
                            {{ addFriends.message }}
                          </div>
                          <div
                            class="alert alert-success"
                            role="alert"
                            v-show="addFriends.success"
                          >
                            {{ addFriends.message }}
                          </div>
                          <v-data-table
                            :headers="addFriends.headers"
                            :items="addFriends.requests"
                            :footer-props="{
                              'items-per-page-options': [10],
                            }"
                            :items-per-page="10"
                            v-show="addFriends.showRequests"
                          >
                            <template v-slot:item="row">
                              <tr>
                                <td>{{ row.item.username.string }}</td>
                                <td width="100">
                                  <v-btn
                                    dark
                                    small
                                    color="primary"
                                    @click="
                                      acceptFriendReq(row.item.username.string)
                                    "
                                  >
                                    <i class="fa fa-check"></i>
                                  </v-btn>
                                </td>
                              </tr>
                            </template>
                          </v-data-table>
                        </v-row>
                      </v-card-text>
                    </v-card>
                  </v-dialog>
                </template>
                <v-btn color="primary" @click="friends.edit = !friends.edit">
                  <i class="fa fa-pencil"></i>
                  &nbsp; Edit
                </v-btn>
              </div>
            </td>
          </tr>
          <tr class="container container-fluid">
            <td colspan="100%">
              <v-data-table
                style="width: 100%"
                fill-width
                :footer-props="{
                  'items-per-page-options': [10],
                }"
                :items-per-page="10"
                :headers="friends.headers"
                :items="friends.friends"
              >
                <template v-slot:item="row">
                  <tr>
                    <td>{{ row.item.username.string }}</td>
                    <td width="100">
                      <v-btn
                        dark
                        small
                        color="error"
                        v-if="friends.edit"
                        @click="deleteFriend(row.item.username.string)"
                      >
                        <i class="fa fa-user-times"></i>
                        &nbsp; Remove
                      </v-btn>
                    </td>
                  </tr>
                </template>
              </v-data-table>
            </td>
          </tr>
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
    inviteGroupDialog: false,
    createGroupDialog: false,
    newGroupName: "",
    groupIdToJoin: "",
    username: store.state.username,
    displayName: store.state.name,
    addFriends: {
      toAdd: "",
      dialog: false,
      error: false,
      success: false,
      message: "",
      requests: [],
      headers: [
        { text: "Username", value: "username" },
        { text: "", value: "" },
      ],
      showRequests: false,
    },
    friends: {
      friends: [],
      headers: [
        { text: "Username", value: "username" },
        { text: "", value: "" },
      ],
      edit: false,
    },
    addGroup: {
      dialog: false,
      userId: "",
      groupId: "",
    },
    groups: {
      groups: [],
      headers: [
        { title: "Group Name", key: "Group Name", value: "name" },
        { key: "", value: "" },
      ],
      edit: false,
      sortBy: [{ key: "Group Name", order: "asc" }],
    },
    invite: {
      user: "",
      group: "",
    },
    components: {},
  }),
  methods: {
    async leaveGroup(groupId) {
      try {
        console.log(groupId);
        let formData = new FormData();
        formData.append("username", this.username);
        formData.append("groupId", groupId);
        await this.axios.post("/user/groups/leave", formData);
        await this.fetchGroups();
      } catch (error) {
        console.error("Failed to leave group:", error);
        alert("Failed to leave group.");
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
    async logout() {
      let response = await Vue.axios.get("/api/logout");
      if (response.data.success) {
        this.$router.push("/login");
      }
    },
    async friendsModal() {
      this.addFriends.dialog = !this.addFriends.dialog;
      await this.getFriendReqs();
    },
    async sendFriendReq() {
      let formData = new FormData();
      formData.append("username", this.username);
      formData.append("userToAdd", this.addFriends.toAdd);
      let response = await Vue.axios.post("/user/friends/add", formData);
      if (response.data.success) {
        this.addFriends.toAdd = "";
        this.addFriends.success = true;
        this.addFriends.error = false;
        this.addFriends.message = response.data.message;
      } else {
        this.addFriends.error = true;
        this.addFriends.success = false;
        this.addFriends.message = response.data.message;
      }
    },
    async getFriendReqs() {
      let formData = new FormData();
      formData.append("username", this.username);
      let response = await Vue.axios.post("/user/friends/requests", formData);
      if (response.data.success && response.data.request) {
        this.addFriends.requests = response.data.friends;
        this.addFriends.requests
          .map(({ username }) => username.string)
          .join(", ");
        this.addFriends.showRequests = response.data.request;
      }
    },
    async acceptFriendReq(toAccept) {
      let formData = new FormData();
      console.log(toAccept, this.username);
      formData.append("username", this.username);
      formData.append("userToAdd", toAccept);
      await Vue.axios.post("/user/friends/accept", formData);
      await this.getFriendReqs();
      await this.getFriends();
    },
    async getFriends() {
      let formData = new FormData();
      formData.append("username", store.state.username);
      let response = await Vue.axios.post("/user/friends", formData);
      if (response.data.success) {
        this.friends.friends = response.data.friends;
        this.friends.friends.map(({ username }) => username.string).join(", ");
        this.friends.showRequests = response.data.request;
      }
    },
    async deleteFriend(toDelete) {
      let formData = new FormData();
      formData.append("username", this.username);
      formData.append("userToDelete", toDelete);
      await Vue.axios.post("/user/friends/remove", formData);
      await this.getFriendReqs();
      await this.getFriends();
      alert("Successfully deleted friend " + toDelete);
    },
    async createGroup() {
      try {
        let formData = new FormData();
        formData.append("username", this.username);
        formData.append("name", this.newGroupName);
        // Assume you have a function to call your API to create the group
        await this.axios.post("/user/groups/create", formData);
        this.createGroupDialog = false; // Close the dialog
        this.newGroupName = ""; // Reset input
        await this.fetchGroups();
      } catch (error) {
        console.error("Failed to create group:", error);
        alert("Failed to create group.");
      }
    },
    async inviteToGroup() {
      let formData = new FormData();
      console.log(this.invite.group);
      formData.append("toInvite", this.invite.user);
      formData.append("groupId", this.invite.group);
      let response = await this.axios.post("/user/groups/invite", formData);
      if (!response.data.success) {
        console.error("Failed to invite ", this.invite.user, " to group");
        alert("Failed to invite ", this.invite.user, " to group");
      }
      this.invite.user = "";
    },
  },
  async mounted() {
    await this.getFriends();
    await this.fetchGroups();
  },
};
</script>
