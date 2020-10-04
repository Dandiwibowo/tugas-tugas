var myArray = [1,5,4,6,2,8,9,11,10,15];
var arrGanjil = [];
var arrGenap = [];

for (a=0; a < myArray.length; a++){
    if(myArray[a]%2==0)
        arrGenap.push(myArray[a]);
    else
        arrGanjil.push(myArray[a]);
}

console.log(arrGanjil);
console.log(arrGenap);
