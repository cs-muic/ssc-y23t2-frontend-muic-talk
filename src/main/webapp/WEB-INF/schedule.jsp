<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
            <form action="/schedule" method="post">
                <div>
                    <label for="event-name">Event Name:</label>
                    <input type="text" id="event-name" name="eventName" class="form-control" required>
                </div>
                <div class="mt-3">
                    <label for="event-date">Event Date:</label>
                    <input type="date" id="event-date" name="eventDate" class="form-control" required>
                </div>
                <div class="mt-3">
                    <label for="event-time">Event Time:</label>
                    <input type="time" id="event-time" name="eventTime" class="form-control" required>
                </div>
                <div class="mt-3">
                    <button class="btn btn-primary" onclick="addEvent()">Add Event</button>
                </div>
            </form>
        </div>

        <div class="col-md-6">
            <h3>All Events</h3>
            <div id="all-events">
                <!-- All events will be displayed here -->
                <!-- Display existing events fetched from the database -->
                <c:forEach var="event" items="${userSchedule}">
                    <div class="event" id="event-${event.id}">
                        <strong>${event.name}</strong> - ${event.dateTime}
                        <button class="btn btn-danger btn-sm delete-btn" onclick="deleteEvent(${event.id})">
                            <i class="fa fa-close"></i>
                        </button>
                    </div>
                </c:forEach>
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
                    <th>Sunday</th>
                    <th>Monday</th>
                    <th>Tuesday</th>
                    <th>Wednesday</th>
                    <th>Thursday</th>
                    <th>Friday</th>
                    <th>Saturday</th>
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
    var events = [];

    <c:forEach var="event" items="${userSchedule}">
    var eventObject = {
        id: "${event.id}",
        name: "${event.name}",
        dateTime: new Date("${event.dateTime}")
    };
    events.push(eventObject);
    </c:forEach>

    // function addEvent() {
    //     var eventName = document.getElementById('event-name').value;
    //     var eventDate = new Date(document.getElementById('event-date').value);
    //     var eventTime = document.getElementById('event-time').value;
    //     // Combine date and time to create a single DateTime object
    //     var eventDateTime = new Date(eventDate.toDateString() + ' ' + eventTime);
    //     var m = eventDate.getMonth() + 1;
    //     if (eventName && eventDateTime) {
    //         var event = {
    //             name: eventName,
    //             dateTime: eventDateTime
    //         };
    //         events.push(event); // Add event to the events array
    //         var eventHtml = '<div class="event"><strong>' + eventName + '</strong> - ' + m + '</strong>/'+ eventDate.getDate() + '</strong>/'+ eventDate.getFullYear() + '</strong> at ' + formatTime(eventDateTime) +
    //             '<button class="btn btn-danger btn-sm delete-btn" onclick="deleteEvent(' + (events.length - 1) + ')"><i class="fa fa-close"></i></button></div>';
    //         document.getElementById('all-events').insertAdjacentHTML('beforeend', eventHtml);
    //         displayWeeklySchedule(); // Update weekly schedule display
    //     } else {
    //         alert('Please fill out all fields.');
    //     }
    // }

    function formatTime(dateTime) {
        var hour = dateTime.getHours();
        var minute = dateTime.getMinutes();
        var period = (hour < 12) ? 'AM' : 'PM';
        hour = (hour % 12) || 12;
        minute = (minute < 10 ? '0' : '') + minute; // Add leading zero to minutes if needed
        return hour + ':' + minute + ' ' + period;
    }

    function displayWeeklySchedule() {
        var daysOfWeek = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'];
        var scheduleHtml = '';
        var currentDate = new Date(); // Get the current date and time
        // Set the current date to the start of the week (Sunday)
        currentDate.setDate(currentDate.getDate() - currentDate.getDay());
        for (var hour = 0; hour < 24; hour++) {
            scheduleHtml += '<tr>';
            scheduleHtml += '<td>' + formatHour(hour) + '</td>'; // Display hour

            for (var day = 0; day < 7; day++) {
                var currentDateTime = new Date(currentDate); // Create a copy of the current date and time
                currentDateTime.setDate(currentDateTime.getDate() + day); // Add day offset

                // console.log("Current Date:", currentDateTime);

                var eventsOnDay = events.filter(function (event) {
                    // Parse event.dateTime into a Date object
                    var eventDateTime = new Date(event.dateTime);

                    return eventDateTime.getHours() === hour &&
                        eventDateTime.getDate() === currentDateTime.getDate() &&
                        eventDateTime.getMonth() === currentDateTime.getMonth() &&
                        eventDateTime.getFullYear() === currentDateTime.getFullYear();
                });
                // console.log("Events on Day:", eventsOnDay);

                var eventsHtml = '';
                eventsOnDay.forEach(function (event) {
                    eventsHtml += '<div><strong>' + event.name + '</strong> at ' + formatTime(event.dateTime) + '</div>';
                });

                scheduleHtml += '<td>' + eventsHtml + '</td>';

            }

            scheduleHtml += '</tr>';
        }
        document.getElementById('weekly-schedule').innerHTML = scheduleHtml;
    }

    function deleteEvent(eventId) {
        // Remove event from the events array
        events = events.filter(event => event.id !== eventId);

        // Update events display
        displayAllEvents();

        // Update weekly schedule display
        displayWeeklySchedule();

        // Send DELETE request to the backend
        fetch(`/schedule?eventId=${eventId}`, {
            method: 'DELETE',
        })
            .then(response => {
                if (response.ok) {
                    // Event successfully deleted
                    console.log('Event deleted successfully');
                } else {
                    // Failed to delete event
                    console.error('Failed to delete event');
                }
            })
            .catch(error => {
                console.error('Error:', error);
            });
    }

    function displayAllEvents() {
        var allEventsHtml = '';
        events.forEach(function (event) {
            var eventDateTime = new Date(event.dateTime); // Convert dateTime to Date object
            var eventName = event.name;
            var eventID = event.id;
            var eventTime = formatTime(eventDateTime); // Format dateTime to display time
            var eventDate = eventDateTime.getDate() + '/' + (eventDateTime.getMonth() + 1) + '/' + eventDateTime.getFullYear(); // Format dateTime to display date
            allEventsHtml += '<div class="event"><strong>' + eventName + '</strong> - ' + eventDate + ' at ' + eventTime +
                '<button class="btn btn-danger btn-sm delete-btn" name = "eventId" onclick="deleteEvent(\'' + eventID + '\')"><i class="fa fa-close"></i></button></div>';
        });
        document.getElementById('all-events').innerHTML = allEventsHtml;
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