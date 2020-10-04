var myData = [4,6,6,7,8,1,5,6,2,4,10,5,11,6];
var knownData = [];

function searchData (x){
    counter = 0;
    myData.forEach(element => {
        if(element==x)
            counter++;  
    });
    return counter;
}

myData.forEach(element => {
    if (!knownData.includes(element)){
        console.log("Angka : "+element+" muncul sebanyak : "+searchData(element)+" kali");
        knownData.push(element);
    }
});