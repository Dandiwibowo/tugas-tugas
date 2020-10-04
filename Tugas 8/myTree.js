function Tree(data) {
    var node = new Node(data);
    this._root = node;
}
/* ============ Penjelasan fungsi Tree ==============
    Fungsi diatas adalah fungsi untuk mendeklarasi suatu tree baru. dimana setiap tree memiliki komponen node dan root
    komponen Node disini menggunakan fungsi Node untuk menciptakan komponen komponen yang terdapat pada node sendiri.
    pada program yang saya buat, fungsi yang pertama kali saya panggil adalah fungsi ini.
*/

function Node(data) {
    this.data = data;
    this.parent = null;
    this.children = [];
}
/* ============ Penjelasan fungsi Node ==============
    Fungsi diatas adalah fungsi untuk mendeklarasi suatu Node, dimana didalam node terdapat komponen berupa data, parent, childern.
    data, parent, childern ini berupa assosiatif array yang nantinya akan sering diolah.
*/

/**
* Queue
*/
function Queue() {
    this.dataStore = []
    this.enqueue = function enqueue(element) {
        this.dataStore.push(element)
    }
    this.dequeue = function dequeue() {
        return this.dataStore.shift()
    }
    this.front = function front() {
        return this.dataStore[0]
    }
    this.back = function back() {
        return this.dataStore[this.dataStore.length - 1]
    }
}
/* ============ Penjelasan fungsi Queue ==============
    Fungsi diatas adalah fungsi yang digunakan oleh traverseBF dalam proses pengolahan data array.
    dalam fungsi queue sendiri terdapat empat fungsi yaitu enqueue, dequeue, front, back.
    variabel dataStore digunakan untuk menampung data yang akan diproses, baik untuk proses penambahan maupun pengurangan.
    enqueue adalah sebuah fungsi yang digunakan untuk menambahkan data "element" kedalam dataStore, data baru tersebut akan ditambahkan pada akhir array.
    dequeue adalah sebuah fungsi yang digunakan untuk mengahapus nilai pada array ke 0, dan menggeser semua array ke x menjadi array x-1.
    front adalah sebuah fungsi untuk melihat berapa nilai pada array pertama.
    back adalah sebuah fungsi untu melihat berapa nilai pada array terakhir.
*/

Tree.prototype.traverseDF = function(callback) {
 
    // this is a recurse and immediately-invoking function
    (function recurse(currentNode) {
        // step 2
        for (var i = 0, length = currentNode.children.length; i < length; i++) {
            // step 3
            recurse(currentNode.children[i]);
        }
 
        // step 4
        callback(currentNode);
 
        // step 1
    })(this._root);
 
};
/* ============ Penjelasan fungsi traverseDF ==============
    Fungsi diatas adalah yang digunakan untuk menerjemahkan data yang tersimpan pada Tree menjadi bentuk array satu dimensi
    yang berurutan dari child ke parent dan yang terakhir adalan root. fungsi trasverseDF sendiri memiliki fungsi parameter bernama callback,
    dimana fungsi callback ini merupakan fungsi rekursif sehingga didalam fungsi traverseDF, fungsi callback memanggil dirinya sendiri sebanyak jumlah childern di masing masing node.
*/
Tree.prototype.traverseBF = function(callback) {
    var queue = new Queue();
 
    queue.enqueue(this._root);
 
    currentTree = queue.dequeue();
 
    while(currentTree){
        for (var i = 0, length = currentTree.children.length; i < length; i++) {
            queue.enqueue(currentTree.children[i]);
        }
 
        callback(currentTree);
        currentTree = queue.dequeue();
    }
};
/* ============ Penjelasan fungsi traverseBF ==============
    Fungsi diatas adalah yang digunakan untuk menerjemahkan data yang tersimpan pada Tree menjadi bentuk array satu dimensi
    yang berurutan dari root ke parent dan yang terakhir adalan child terakhir, fungsi ini kebalikan dari fungsi traverseDF dalam hal mengurutkan data. 
    Fungsi ini sendiri juga melibatkan fungsi Queue dalam pengolahan data Tree. mula mula, data pada Tree akan di store menggunakan enqueue, 
    setelah itu untuk mendapatkan data pada array ber key "data", dilakukan proses dequeue. dan didalam pengulangan sebanyak data childern juga 
    melakukan langkah untuk mendapatkan data pada array ber key "data", pengulangan ini berlangsung hingga ke node yang tidak memiliki childern.
*/

Tree.prototype.contains = function(callback, traversal) {
    traversal.call(this, callback);
};
/* ============ Penjelasan fungsi contains ==============
    Fungsi diatas adalah yang digunakan untuk membantu memilah data berdasarkan transverse yang digunakan. data tersebut akan digunakan untuk mempermudah
    proses penambahan data pada fungsi Add. Fungsi contains sendiri akan mengirim data pada Tree untuk diolah oleh fungsi Transverse dan data tersebut akan 
    dikembalikan untuk fungsi add. Transverse yang digunakan bergantung pada isi dari variabel tranversal.
*/

Tree.prototype.add = function(data, toData, traversal) {
    var child = new Node(data),
        parent = null,
        callback = function(node) {
            if (node.data === toData) {
                parent = node;
            }
        };
 
    this.contains(callback, traversal);
 
    if (parent) {
        parent.children.push(child);
        child.parent = parent;
    } else {
        alert('Cannot add node to a non-existent parent.');
    }
};
/* ============ Penjelasan fungsi add ==============
    Fungsi diatas adalah yang digunakan untuk menambahkan data baru sebagai child dari parent yang dinginkan. didalam fungsi ini terdapat 3 parameter
    yaitu "data" yang berisi data baru yang akan diinputkan, "toData" yaitu data yang akan dijadikan parrent, dan tranversal berisi dengan fungsi transverse yang di inginkan.
    pada fungsi callback akan mencari node mana yang memiliki data yang sama dengan "toData", setelah itu dilakan transversal untuk menjalakan fungsi callback didalam fungsi 
    tranversal yang telah dipilih. setelah itu data parent tersebut akan di sisipi data baru kedalam array ber "key" 'childern' sebagai childern dari data parent tersebut. 
*/
Tree.prototype.remove = function(data, fromData, traversal) {
    var tree = this,
        parent = null,
        childToRemove = null,
        index;
 
    var callback = function(node) {
        if (node.data === fromData) {
            parent = node;
        }
    };
 
    this.contains(callback, traversal);
 
    if (parent) {
        index = findIndex(parent.children, data);
 
        if (index === undefined) {
            alert('Node to remove does not exist.');
        } else {
            childToRemove = parent.children.splice(index, 1);
        }
    } else {
        alert('Parent does not exist.');
    }
 
    return childToRemove;
};
/* ============ Penjelasan fungsi Remove ==============
    Fungsi diatas adalah yang digunakan untuk menghapus data yang dinginkan. didalam fungsi ini terdapat 3 parameter
    yaitu "data" yang berisi data yang akan dihapus, "fromData" yaitu data yang berisi parrent dari data yang akan dihapus, dan tranversal berisi dengan fungsi transverse yang di inginkan.
    pada fungsi callback akan mencari node mana yang memiliki data yang sama dengan "fromData", setelah itu dilakan transversal untuk menjalakan fungsi callback didalam fungsi 
    tranversal yang telah dipilih. setelah itu data parent tersebut akan di proses pada fungsi findIdex untuk mendapatkan nomor index data yang dihapus tersebut. jika index tersebut tidak 
    ditemukan, maka data node tersebut tidak ada, jika index tersebut ditemukan maka data tersebut akan dihapus dari array menggunakan fungsi splice.
*/
function findIndex(arr, data) {
    var index;
 
    for (var i = 0; i < arr.length; i++) {
        if (arr[i].data === data) {
            index = i;
        }
    }
 
    return index;
}
/* ============ Penjelasan fungsi findIndex ==============
    Fungsi diatas adalah yang digunakan untuk membantu fungsi remove dalam menjari indeks dari data yang dicari. fungsi findIndex sendiri memiliki beberapa parameter yaitu arr dan data
    arr sendiri merupakan array yang akan diolah, sedangkan data adalah data yang akan dicari pada array tersebut. pada fungsi ini dilakukan pencarian data yang memiliki nilai dan type 
    yang sama sebanyak jumlah data pada array
*/