document.addEventListener("DOMContentLoaded", function(event) { 
  var app = new Vue({
    el: '#app',
    data: {
    },
    methods: {
      showDaily: function() {
        var chart = document.querySelectorAll("#thing");
        chart.classList.toggle('hidden');
      },

      showBG: function() {
        var allbg = document.querySelectorAll("#entries");
        for (var i = 0; i < allbg.length; i++) {
          var bg = allbg[i];
          bg.classList.toggle('hidden');
        }
      }

    }
  });
});

