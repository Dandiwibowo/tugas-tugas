var graph ={
    'A' : {'B' : 4,'C' : 5},
    'B' : {'A' : 4,'C' : 6},
    'C' : {'A' : 5,'B' : 6,'D' : 4,'E' : 3},
    'D' : {'C' : 4,'E' : 5},
    'E' : {'C' : 3,'D' : 5},
};
var passedNode = [], coLength=0;

// Fungsi di bawah ini adalah untuk mencari node terpendek berikutnya yang belum pernah dilewati sebelumnya

let findNextNode = (arr)=>{
    var shortestNode="", shortestLength=Number.MAX_VALUE;
    for(index in arr){

        // menegecek apakah node tersebut sudah dilewati atau belum
        if(!passedNode.includes(index)){
            
            // Mancari node terpendek pada array
            if(shortestLength>arr[index]){
                shortestNode=index;
                shortestLength=arr[index];
            }
            
        }
        
    };
    return shortestNode;
}


/*  Fungsi dibawah ini adalah untuk mengolah data graph, terdapat 3 element yaitu graph, start node dan end node
    mula mula dianggap node belum ditemukan
    lalu startnode akan ditandai sudah dilewati atau dimasukkan ke array passedNode
    lalu dilakukan pengulangan selama pencarian node tersebut belum ditemukan
        lalu dilakukan pengecekan, apakah end node merupakan tetangga dari node sekarang
            jika iya, maka node tersebut akan ditambahkan ke array passedNode
            dan dilakukan penambahan jarak node tersebut
        jika tidak bertetanggaan
            maka akan dicari node tetangga manakah yang memiliki jarak terpendek dan belum dilewati, menggunakan fungsi findNextNode
            jika ketemu, maka jarak tempuh node akan ditambahkan dengan jarak node tersebut dan node tersebut ditandahi sebagai sudah dilewati atau ditambahkan ke passedNode
    jika sudah ditemukan maka akan dicetak jarak dan list node yang telah dilewati
*/
let olahGraph = (graph,startNode,endNode)=>{
    var found=0;
    passedNode.push(startNode);

    while(found==0){
        if(endNode in graph[passedNode[passedNode.length-1]]){
            coLength+=graph[passedNode[passedNode.length-1]][endNode];
            passedNode.push(endNode);
            found=1;
        }
        else{
            var currentNode = passedNode[passedNode.length-1];
            var nextNode = findNextNode(graph[currentNode]);
            coLength+=graph[currentNode][nextNode];
            passedNode.push(nextNode);
        }

    }

    console.log("List Node : "+passedNode);
    console.log("Jarak Tempuh : "+coLength);
}

olahGraph(graph,"B","D");