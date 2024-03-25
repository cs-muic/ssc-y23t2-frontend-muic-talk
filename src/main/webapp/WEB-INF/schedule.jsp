<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>

<head>
    <title>MUIC Talk</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
            crossorigin="anonymous"></script>
    <link rel="stylesheet" href="../styles/styles.css">

    <style>
        .event {
            background-color: #f0f0f0;
            border: 1px solid #ccc;
            padding: 5px;
            margin-bottom: 5px;
        }
        .schedule {
            margin-top: 20px;
        }
    </style>
</head>

<body>
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
                <input type="text" id="event-name" class="form-control" required>
            </div>
            <div class="mt-3">
                <label for="event-date">Event Date:</label>
                <input type="date" id="event-date" class="form-control" required>
            </div>
            <div class="mt-3">
                <label for="event-time">Event Time:</label>
                <input type="time" id="event-time" class="form-control" required>
            </div>
            <div class="mt-3">
                <button class="btn btn-primary" onclick="addEvent()">Add Event</button>
            </div>
        </div>
        <div class="col-md-6">
            <h3>All Events</h3>
            <div id="all-events">
                <!-- All events will be displayed here -->
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
                    <th>Monday</th>
                    <th>Tuesday</th>
                    <th>Wednesday</th>
                    <th>Thursday</th>
                    <th>Friday</th>
                    <th>Saturday</th>
                    <th>Sunday</th>
                </tr>
                </thead>
                <tbody id="weekly-schedule">
                <!-- Weekly schedule will be displayed here -->
                </tbody>
            </table>
        </div>
    </div>
</div>

<script>
    var events = []; // Array to store all events

    function addEvent() {
        var eventName = document.getElementById('event-name').value;
        var eventDate = new Date(document.getElementById('event-date').value);
        var eventTime = document.getElementById('event-time').value;

        if (eventName && eventDate && eventTime) {
            var event = {
                name: eventName,
                date: eventDate,
                time: eventTime
            };

            events.push(event); // Add event to the events array

            var eventHtml = '<div class="event"><strong>' + eventName + '</strong> at ' + eventTime + '</div>';
            document.getElementById('all-events').insertAdjacentHTML('beforeend', eventHtml);
            displayWeeklySchedule(); // Update weekly schedule display
        } else {
            alert('Please fill out all fields.');
        }
    }

    function displayWeeklySchedule() {
        var daysOfWeek = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'];

        var scheduleHtml = '';
        for (var hour = 0; hour < 24; hour++) {
            scheduleHtml += '<tr>';
            scheduleHtml += '<td>' + formatHour(hour) + '</td>'; // Display hour

            for (var day = 0; day < 7; day++) {
                var eventsOnDay = events.filter(function(event) {
                    return event.date.getDay() === day && event.date.getHours() === hour;
                });

                var eventsHtml = '';
                eventsOnDay.forEach(function(event) {
                    eventsHtml += '<div><strong>' + event.name + '</strong> at ' + event.time + '</div>';
                });

                scheduleHtml += '<td>' + eventsHtml + '</td>';
            }

            scheduleHtml += '</tr>';
        }

        document.getElementById('weekly-schedule').innerHTML = scheduleHtml;
    }

    function formatHour(hour) {
        if (hour < 10) {
            return '0' + hour + ':00';
        } else {
            return hour + ':00';
        }
    }

    // Initial display of weekly schedule
    displayWeeklySchedule();
</script>
</body>

</html>
