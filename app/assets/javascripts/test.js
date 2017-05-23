document.addEventListener("DOMContentLoaded", function(event) { 
  var app = new Vue({
    el: '#app',
    data: {
    },
    computed: {
      totalPoints: function() {

      }
    },
    methods: {
      showDaily: function() {
        var charts = document.querySelectorAll(".thing");
        for (var i = 0; i < charts.length; i++) {
          var chart = charts[i];
          chart.classList.toggle('hidden');
        }
      },

      showBG: function() {
        var allbg = document.querySelectorAll(".entries");
        for (var i = 0; i < allbg.length; i++) {
          var bg = allbg[i];
          bg.classList.toggle('hidden');
        }
      },

    }
  });
});





$(document).ready(function() {
    $('#logged_trophy').hover(function() {
        $('#logged_trophy_popup').show();
    }, function() {
        $('#logged_trophy_popup').hide();
    });
});

$(document).ready(function() {
    $('#best_day_trophy').hover(function() {
        $('#best_day_trophy_popup').show();
    }, function() {
        $('#best_day_trophy_popup').hide();
    });
});

