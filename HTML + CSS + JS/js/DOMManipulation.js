var position = document.getElementById('position');

document.addEventListener('mousemove', function(e) {
    position.innerHTML = 'Position X : ' + e.clientX + 'px<br />Position Y : ' + e.clientY + 'px';
    if (e.clientX > 500 && e.clientX < 600 && e.clientY > 500 && e.clientY < 600)
        position.innerHTML += "<br/>TAPE DANS LE FOND!";
});
