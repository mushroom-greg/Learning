function levelHandler(level) {
    var tmp;

    if (level == undefined)
        level = 1;
    alert("LOL je suis un PGM!\nLevel: " + level + "!!!");
    tmp = 0;
        while (tmp <= 0) {
        tmp = prompt("Nouveau level:", level);
        tmp = parseInt(tmp);
    }//tmp = prompt("Nouveau level:", level);
    if (tmp != level && confirm("Es-tu sûr de vouloir atteindre le level " + tmp + "?")) {
            level = parseInt(tmp);
            alert("Bravo, vous avez atteint le level " + level + "!!!");
        }
    else
        alert("Tu restes au level " + level + ", sale boloss!");
    return (level);
}

//levelHandler();
alert(document.title);
