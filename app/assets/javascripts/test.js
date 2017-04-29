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

