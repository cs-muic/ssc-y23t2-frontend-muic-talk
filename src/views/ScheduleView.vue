<template>
  <div class="container mt-4">
    <nav class="navbar navbar-light bg-light">
      <div class="container-fluid">
        <a class="navbar-brand"><strong>MUIC Talk</strong></a>
        <div>
          <router-link to="/">
            <button class="btn btn-primary"><i class="fa fa-home"></i> &nbsp; Home</button>
          </router-link>
          <router-link to="/schedule">
            <button class="btn btn-primary"><i class="fa fa-calendar"></i> &nbsp; Schedule</button>
          </router-link>
          <router-link to="/chat">
            <button class="btn btn-primary"><i class="fa fa-comments"></i> &nbsp; Chats</button>
          </router-link>
        </div>
        <div>
          <button class="btn btn-primary" @click="logout"><i class="fa fa-sign-out"></i></button>
        </div>
      </div>
    </nav>

    <div class="row mt-4">
      <div class="col-md-6">
        <h3>Add Event</h3>
        <form @submit.prevent="addEvent">
          <div>
            <label for="event-name">Event Name:</label>
            <input type="text" id="event-name" v-model="newEventName" class="form-control" required>
          </div>
          <div class="mt-3">
            <label for="event-date">Event Date:</label>
            <input type="date" id="event-date" v-model="newEventDate" class="form-control" required>
          </div>
          <div class="mt-3">
            <label for="event-time">Event Time:</label>
            <input type="time" id="event-time" v-model="newEventTime" class="form-control" required>
          </div>
          <div class="mt-3">
            <button type="submit" class="btn btn-primary">Add Event</button>
          </div>
        </form>
      </div>

      <div class="col-md-6">
        <h3>All Events</h3>
        <div id="all-events">
          <!-- All events will be displayed here -->
          <div v-for="event in events" :key="event.id" class="event">
            <strong>{{ event.name }}</strong> - {{ event.dateTime }}
            <button class="btn btn-danger btn-sm delete-btn" @click="deleteEvent(event.id)">
              <i class="fa fa-close"></i>
            </button>
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
            <td v-for="day in daysOfWeek" :key="day">
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
export default {
  data() {
    return {
      newEventName: '',
      newEventDate: '',
      newEventTime: '',
      events: [],
      daysOfWeek: ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday']
    };
  },
  methods: {
    async logout() {
      try {
        let response = await this.$axios.get("/api/logout");
        if (response.data.success) {
          this.$router.push("/login");
        }
      } catch (error) {
        console.error('Error:', error);
      }
    },
    async addEvent() {
      try {
        let response = await this.$axios.post("/schedule", {
          eventName: this.newEventName,
          eventDate: this.newEventDate,
          eventTime: this.newEventTime
        });
        if (response.data.success) {
          this.newEventName = '';
          this.newEventDate = '';
          this.newEventTime = '';
          this.fetchEvents(); // Refresh events after adding
        }
      } catch (error) {
        console.error('Error:', error);
      }
    },
    async fetchEvents() {
      try {
        let response = await this.$axios.get("/api/events");
        this.events = response.data;
      } catch (error) {
        console.error('Error:', error);
      }
    },
    async deleteEvent(eventId) {
      try {
        let response = await this.$axios.delete(`/schedule/${eventId}`);
        if (response.ok) {
          this.fetchEvents(); // Refresh events after deleting
          this.displayWeeklySchedule(); // Update weekly schedule display
        } else {
          console.error('Failed to delete event');
        }
      } catch (error) {
        console.error('Error:', error);
      }
    },
    formatHour(hour) {
      return hour < 10 ? '0' + hour + ':00' : hour + ':00';
    },
    getEventsForDay(hour, day) {
      return this.events
          .filter(event => {
            let eventDateTime = new Date(event.dateTime);
            return (
                eventDateTime.getHours() === hour &&
                eventDateTime.toLocaleString('en-US', { weekday: 'long' }) === day
            );
          })
          .map(event => {
            let eventDateTime = new Date(event.dateTime);
            return `<div><strong>${event.name}</strong> at ${eventDateTime.toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' })}</div>`;
          })
          .join('');
    },
    displayWeeklySchedule() {
      // Update weekly schedule display
    }
  },
  mounted() {
    this.fetchEvents();
    this.displayWeeklySchedule();
  }
};
</script>

<style scoped>
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
</style>

