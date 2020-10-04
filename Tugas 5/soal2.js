var myData = [5,7,1,6,8,10,22,13,7,8];
var higerElemet = 0;

myData.forEach(element => {
    if(element > higerElemet)
        higerElemet=element;
});

console.log(higerElemet);