const API_TOKEN = '273587e647fe69ea2b7419787157b275';

export function getFilmsFromApiByName(filmName, page) {
    const url = 'https://api.themoviedb.org/3/search/movie?api_key=' + API_TOKEN + '&language=fr&query=' + filmName + '&page' + page;
    return fetch(url)
        .then((response) => response.json())
        .catch((error) => console.log(error));
}

export function getImageFromApiByName(imageName) {
    return 'https://image.tmdb.org/t/p/w300' + imageName;
}

export function getFilmDetailFromApiById(id) {
    const url = 'https://api.themoviedb.org/3/movie' + id + '?api_key=' + API_TOKEN + '&language=fr';
    return fetch(url)
        .then((response) => response.json())
        .catch((error) => console.log(error));
}