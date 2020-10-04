let getName = ()=> {
    fetch("http://api.themoviedb.org/3/discover/movie?language=en-US&api_key=cd8dbb788edd89ca755f429a50beded3")
    .then(response => response.json())
    .then(result => console.log(result));
}

console.log(getName());