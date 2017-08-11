function newInput() {
    var input,
        nbr;

    nbr = NaN;
    while (nbr < 0 || nbr > 999 || isNaN(nbr) == true) {
        input = prompt("Choisissez un nombre entre 0 et 999:");
        nbr = parseInt(input, 10);
    }
    return (nbr);
}

function handleSplit(nbr) {
    var splitted_nbr;

    console.log("input " + nbr + ", type: " + typeof nbr);
    splitted_nbr = [];
    for (i = 0; nbr / 10 > 0; i++) {
        splitted_nbr.push(nbr % 10 - 1);
        nbr = Math.trunc(nbr /= 10);
    }
    return (splitted_nbr);
}

function convertNbrToString(nbr) {
    var splitted_nbr,
        nbr_str;
    var unit_table = ["un", "deux", "trois", "quatre", "cinq", "six", "sept", "huit", "neuf", "dix", "onze", "douze", "treize", "quatorze", "quinze", "seize"],
        ten_table = ["dix", "vingt", "trente", "quarante", "cinquante", "soixante", "soixante-dix", "quatre-vingt", "quatre-vingt-dix"];

    splitted_nbr = handleSplit(nbr);
    nbr_str = "";
    for (i = 0, len = splitted_nbr.length; i < len; i++) {
        if (i == 0)
            nbr_str = unit_table[splitted_nbr[i]];
        else if (i == 1)
            nbr_str = ten_table[splitted_nbr[i]] + "-" + nbr_str;
        else if (i == 2) {
            nbr_str = "cent-" + nbr_str;
            if (splitted_nbr[i] != 1)
                nbr_str = unit_table[splitted_nbr[i]] + "-" + nbr_str;
        }
    }
    return (nbr_str);
}

(function () {
    var nbr;

    nbr = newInput();
    alert(convertNbrToString(nbr));
}) ();
