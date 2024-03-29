<template>
  <div class="container mt-4">
    <nav class="navbar navbar-light bg-light">
      <div class="container-fluid">
        <a class="navbar-brand"><strong>MUIC Talk</strong></a>
        <div>
          <a class="btn btn-primary" type="button" href="/"><i class="fa fa-home"></i> &nbsp; Home </a>
          <a class="btn btn-primary" type="button" href="/schedule"><i class="fa fa-calendar"></i> &nbsp; Schedule </a>
          <a class="btn btn-primary" type="button" href="/chat"><i class="fa fa-comments"></i> &nbsp; Chats </a>
        </div>
        <div>
          <a class="btn btn-primary btn-w40" type="button" href="/logout"><i class="fa fa-sign-out"></i></a>
        </div>
      </div>
    </nav>

    <div class="row mt-4">
      <div class="col-md-6">
        <h3>Add Event</h3>
        <div>
          <label for="event-name">Event Name:</label>
          <input type="text" id="event-name" class="form-control" required v-model="eventName">
        </div>
        <div class="mt-3">
          <label for="event-date">Event Date:</label>
          <input type="date" id="event-date" class="form-control" required v-model="eventDate">
        </div>
        <div class="mt-3">
          <label for="event-time">Event Time:</label>
          <input type="time" id="event-time" class="form-control" required v-model="eventTime">
        </div>
        <div class="mt-3">
          <button class="btn btn-primary" @click="addEvent()">Add Event</button>
        </div>
      </div>
      <div class="col-md-6">
        <h3>All Events</h3>
        <div id="all-events">
          <!-- All events will be displayed here -->
          <div class="event" v-for="(event, index) in events" :key="index">
            <strong>{{ event.name }}</strong> - {{ event.date }} at {{ event.time }}
            <button class="btn btn-danger btn-sm delete-btn" @click="deleteEvent(index)"><i class="fa fa-close"></i></button>
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
            <th v-for="(day, index) in daysOfWeek" :key="index">{{ day }}</th>
          </tr>
          </thead>
          <tbody id="weekly-schedule">
          <!-- Weekly schedule will be displayed here -->
          <tr v-for="(hour, index) in 24" :key="index">
            <td>{{ formatHour(hour) }}</td>
            <td v-for="(day, dayIndex) in 7" :key="dayIndex">
              <div v-html="getEventsOnDay(hour, dayIndex)"></div>
            </td>
          </tr>
          </tbody>
        </table>
      </div>
    </div>
  </div>
</template>

<script setup>
import {ref} from 'vue';

const eventName = ref('');
const eventDate = ref('');
const eventTime = ref('');
const events = ref([]);

const daysOfWeek = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'];

function addEvent() {
  const newEvent = {
    name: eventName.value,
    date: eventDate.value,
    time: eventTime.value
  };
  events.value.push(newEvent);
}

function deleteEvent(index) {
  events.value.splice(index, 1);
}

function formatHour(hour) {
  return hour < 10 ? '0' + hour + ':00' : hour + ':00';
}

function getEventsOnDay(hour, dayIndex) {
  const currentDateTime = new Date();
  currentDateTime.setDate(currentDateTime.getDate() + dayIndex);

  const filteredEvents = events.value.filter(event => {
    const eventDateTime = new Date(event.date + 'T' + event.time);
    return eventDateTime.getHours() === hour &&
        eventDateTime.getDate() === currentDateTime.getDate() &&
        eventDateTime.getMonth() === currentDateTime.getMonth() &&
        eventDateTime.getFullYear() === currentDateTime.getFullYear();
  });

  let eventsHtml = '';
  filteredEvents.forEach(event => {
    eventsHtml += `<div><strong>${event.name}</strong> at ${event.time}</div>`;
  });
  return eventsHtml;
}
</script>

<style scoped>
@import "../main/webapp/styles/login-styles.css";
@import "https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css";
@import "https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css";
@import "../main/webapp/styles/styles.css";
@import "https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js";
</style>
