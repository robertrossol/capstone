function showBG() {
  var allbg = document.querySelectorAll('p');
  for (var i = 0; i < allbg.length; i++) {
    var bg = allbg[i];
    bg.classList.toggle('hidden');
  }
}