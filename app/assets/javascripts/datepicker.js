$(document).ready(function() {
  let booking;
  fetchDates()

  $( function() {
    $('#datepicker1').datepicker({
      beforeShowDay: checkAvailability,
    });
  });

  function fetchDates() {
    var listingId = getID();
    $.ajax({
      url: `http://localhost:3000/api/v1/availabledates/${listingId}`,
      type: 'GET',
      success: (response) => {
        booking = response
        console.log(response)
      }
    })
  }

  function checkAvailability(date) {
    var availableDays = booking.map(function(day) {
      return day
    })
    var y = date.getFullYear();
    var m = date.getMonth();
    var d = date.getDate();
    let currentDate = y + '-' + (m + 1) + '-' + d;
    if (availableDays.indexOf(currentDate.toString())=== -1) {
      return [false, "", "Booked"]
    }
    else {
      return [true];
    }
  }

  function getID() {
    return window.location.pathname.split('/').slice(-1).toString();
  }
})
