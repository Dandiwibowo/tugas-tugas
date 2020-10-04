         
    $.ajax({
        url:'http://api.themoviedb.org/3/discover/movie?language=en-US&api_key=cd8dbb788edd89ca755f429a50beded3',
        method: 'GET',
        // data: {
        //    "username":email,
        //    "password":password,
        // },
        
        success: function (data) {
            var response= JSON.stringify(data);
            var myResponse=JSON.parse(response);

            console.log(myResponse);

            var arrayResult = myResponse.results;
            // console.log(arrayResult[0].title);

            var tableText="";
            for(a=0; a< arrayResult.length; a++){
                tableText+=`
                    <tr>
                        <td>`+arrayResult[a].title+`</td>
                        <td>`+arrayResult[a].poster_path+`</td>
                        <td>`+arrayResult[a].original_language+`</td>
                        <td>`+arrayResult[a].popularity+`</td>
                    </tr>
                `;
            }

            document.getElementById("listData").innerHTML=tableText;
            
        }
    });