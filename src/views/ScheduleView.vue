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

    <div v-if="showPastDateAlert" class="alert alert-danger mt-3" role="alert">
      <i class="fa fa-exclamation-circle mr-2"></i>
      Please select a future date for the event.
    </div>

    <div class="row mt-4">
      <div class="col-md-6">
        <h3>Add Event</h3>
        <v-form ref="form" lazy-validation>
          <div>
            <v-text-field
              v-model="newEvent.name"
              label="Event Name"
              required
            ></v-text-field>
          </div>
          <div class="mt-3">
            <label for="event-date">Event Date:</label>
            <input
              type="date"
              id="event-date"
              v-model="newEvent.date"
              class="form-control"
              required
            />
          </div>
          <div class="mt-3">
            <label for="event-time">Event Time:</label>
            <input
              type="time"
              id="event-time"
              v-model="newEvent.time"
              class="form-control"
              required
            />
          </div>
          <v-btn color="primary" class="btn btn-primary mt-3" @click="addEvent">
            <i class="fa fa-calendar"></i> &nbsp; Add Event
          </v-btn>
        </v-form>
      </div>

      <div class="col-md-6">
        <h3>All Events</h3>
        <div id="all-events">
          <!-- All events will be displayed here -->
          <div
            v-for="event in events"
            :key="event.id"
            class="event"
            style="height: 50px; border-radius: 5px"
          >
            <p class="mt-2">
              <strong>{{ event.name.string }}</strong> -
              {{ new Date(event.date.string).toLocaleDateString() }}
              at
              {{
                new Date(event.date.string).toLocaleTimeString([], {
                  hour: "2-digit",
                  minute: "2-digit",
                })
              }}
            </p>
            <v-btn
              color="error"
              class="btn btn-danger btn-sm delete-btn"
              @click="deleteEvent(event.id.string)"
            >
              <i class="fa fa-close"></i>
            </v-btn>
          </div>
        </div>
      </div>
    </div>

    <div class="row schedule">
      <div class="col">
        <h3>Weekly Schedule</h3>
        <table class="table">
          <thead>
            <tr>
              <th>Time</th>
              <th v-for="day in daysOfWeek" :key="day">{{ day }}</th>
            </tr>
          </thead>
          <tbody id="weekly-schedule">
            <!-- Weekly schedule will be displayed here -->
            <tr v-for="hour in 24" :key="hour">
              <td>{{ formatHour(hour) }}</td>
              <td
                v-for="(day, index) in daysOfWeek"
                :key="index"
                :class="{ 'current-day': isCurrentDay(index) }"
              >
                <div v-html="getEventsForDay(hour, day)"></div>
              </td>
            </tr>
          </tbody>
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
  data() {
    return {
      username: store.state.username,
      displayName: store.state.name,
      newEvent: {
        name: "",
        date: "",
        time: "",
      },
      events: [],
      datetime: [],
      daysOfWeek: [
        "Sunday",
        "Monday",
        "Tuesday",
        "Wednesday",
        "Thursday",
        "Friday",
        "Saturday",
      ],
      showPastDateAlert: false,
    };
  },
  methods: {
    isCurrentDay(index) {
      const currentDate = new Date();
      const currentDayIndex = currentDate.getDay(); // 0 for Sunday, 1 for Monday, ..., 6 for Saturday
      return index === currentDayIndex;
    },
    async logout() {
      try {
        let response = await this.axios.get("/api/logout");
        if (response.data.success) {
          this.$router.push("/login");
        }
      } catch (error) {
        console.error("Error:", error);
      }
    },
    async addEvent() {
      try {
        // Get the current date
        const currentDate = new Date();
        const options = { timeZone: "Asia/Bangkok" };
        const currentDateString = currentDate
          .toLocaleString("en-US", options)
          .split(",")[0];
        console.log("Current Date:", currentDateString);
        console.log("Selected Date:", this.newEvent.date);
        // Check if the selected date is in the past
        if (new Date(this.newEvent.date) < currentDate) {
          this.showPastDateAlert = true; // Show the alert
          return;
        }

        let formData = new FormData();
        formData.append("username", this.username);
        formData.append("eventName", this.newEvent.name);
        formData.append("eventDate", this.newEvent.date);
        formData.append("eventTime", this.newEvent.time);
        let response = await this.axios.post("/api/user/events/new", formData);
        if (response.data.success) {
          this.newEvent.name = "";
          this.newEvent.date = "";
          this.newEvent.time = "";
          this.fetchEvents(); // Refresh events after adding
        }
      } catch (error) {
        console.error("Error:", error);
      }
    },
    async fetchEvents() {
      try {
        let formData = new FormData();
        formData.append("username", this.username);
        let response = await this.axios.post("/api/user/events", formData);
        if (response.data.success) {
          console.log(response.data.events);
          this.events = response.data.events;
          this.events.map(({ id }) => id.string).join(", ");
          this.events.map(({ name }) => name.string).join(", ");
          this.events.map(({ date }) => date.string).join(", ");
          console.log(this.events);
        }
      } catch (error) {
        console.error("Error:", error);
      }
    },
    async deleteEvent(eventId) {
      try {
        let formData = new FormData();
        formData.append("username", this.username);
        formData.append("eventId", eventId);
        let response = await this.axios.post(
          "/api/user/events/delete",
          formData
        );
        if (response.data.success === false) {
          console.error("Failed to delete event");
        }
        await this.fetchEvents(); // Refresh events after deleting
        this.displayWeeklySchedule(); // Update weekly schedule display
      } catch (error) {
        console.error("Error:", error);
      }
    },
    formatHour(hour) {
      return hour < 10 ? "0" + hour + ":00" : hour + ":00";
    },
    getEventsForDay(hour, day) {
      return this.events
        .filter((event) => {
          let eventDateTime = new Date(event.date.string);
          return (
            eventDateTime.getHours() === hour &&
            eventDateTime.toLocaleString("en-US", { weekday: "long" }) === day
          );
        })
        .map((event) => {
          console.log(event.name.string);
          let eventDateTime = new Date(event.date.string);
          return `<div><strong>
            ${event.name.string}
          </strong> at ${eventDateTime.toLocaleTimeString([], {
            hour: "2-digit",
            minute: "2-digit",
          })}</div>`;
        })
        .join("");
    },
    displayWeeklySchedule() {
      // Update weekly schedule display
    },
  },
  async mounted() {
    await this.fetchEvents();
    await this.displayWeeklySchedule();
  },
};
</script>

<style scoped>
@import "https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css";
@import "https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css";
@import "../assets/styles/styles.css";
.event {
  background-color: #f0f0f0;
  border: 1px solid #ccc;
  padding: 5px;
  margin-bottom: 5px;
  position: relative;
}

.event .delete-btn {
  position: absolute;
  top: 5px;
  right: 5px;
}

.schedule {
  margin-top: 20px;
}

.schedule table {
  width: 100%;
  border-collapse: collapse; /* Collapse borders for a cleaner look */
}

.schedule th,
.schedule td {
  text-align: center;
  padding: 10px;
  border: 1px solid #ddd; /* Add borders to table cells */
}

.schedule th {
  background-color: rgba(235, 216, 255, 0.7);
}

.schedule td {
  vertical-align: middle;
}

.schedule td.current-day {
  background-color: #f9f5ff; /* Change the background color for the current day */
}
</style>
