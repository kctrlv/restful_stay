$(document).ready(function() {
  var booking;
  fetchDates()


  $( function() {
    $('#datepicker1').datepicker({
      beforeShowDay: checkAvailability,
    });
  });

  function fetchDates() {
    var listingId = getID();
    $.ajax({
      url: `http://restful-stay.herokuapp.com/api/v1/availabledates/${listingId}`,
      type: 'GET',
      success: (response) => {
        booking = response
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
