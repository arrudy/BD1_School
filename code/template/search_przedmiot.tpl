<script src="js/baza.js"></script>
<script type="text/javascript">



function fn_search_przedmiot()
 {
    var uczen=document.form.przedmiot;
     //var klasa = document.getElementById("lname").value ;
     //document.getElementById("data").style.display = "none" ;
     var json_data = "{\"przedmiot\":\"" + uczen.value  + "\"}" ;
     var msg = "data=" + encodeURIComponent(json_data) ;
     var url = "index.php?sub=Baza&action=direct_searchPrzedmiot" ;
     resp = function(response) {
        response = JSON.parse(response);
        //var studentlist=document.form.uczen;
        //studentlist.options = JSON.parse(response);


        target = document.getElementById("response");
         target.innerHTML = "<tr><th>id</th><th>przedmiot</th></tr>";

        for (i=0; i<response.length; i++)
        {
            //uczenlist.options[uczenlist.options.length] = new Option(response[i].imie + " " + response[i].nazwisko,response[i].uczen_id,false,false);
            target.innerHTML += '<tr><td>' + response[i].przedmiot_id + '</td><td>' + response[i].przedmiot + '</td><td><a href="javascript:fn_delete_przedmiot(' +response[i].przedmiot_id +')">Usun przedmiot</a></td>' + '</td></tr>' ;
        }


        //document.getElementById("art_content").innerHTML = ;
      }
      xmlhttpPost (url, msg, resp) ;                          
}


function fn_delete_przedmiot(id)
 {
     //var klasa = document.getElementById("lname").value ;
     //document.getElementById("data").style.display = "none" ;
     var json_data = "{\"przedmiot_id\":\"" + id  + "\"}" ;
     var msg = "data=" + encodeURIComponent(json_data) ;
     var url = "index.php?sub=Baza&action=direct_deletePrzedmiot" ;
     resp = function(response) {
      document.getElementById("response").innerHTML = response;
        //document.getElementById("art_content").innerHTML = ;
      }
      xmlhttpPost (url, msg, resp) ;                          
}



</script>

<form name="form" id = "form">            
  <table>
    <tr><td><label for="przedmiot">Przedmiot:</label></td>
    <td><input value="<?php if(isset($formData)) echo $formData['przedmiot']; ?>" type="text" id="przedmiot" name="przedmiot" /></td></tr>
    <tr><td><span id="data"><input type="button" value="Znajdz" onclick="fn_search_przedmiot()" /></span></td>
  </table>
</form> 

<table border="1" id ="response">
<tr><th>id</th><th>przedmiot</th></tr>
 <?php 
    if ($data) { 
       foreach ( $data as $row ) { 
      echo '<tr><td>'.$row['przedmiot_id'].'</td><td>'.$row['przedmiot'].'</td>' ;

         //w klasie dac mozliwosc wyszukania po niej

      echo '<td><a href="javascript:fn_delete_przedmiot('.$row['przedmiot_id'].')">Usun przedmiot</a></td>';
      //echo '<td><a href="index.php?sub=Baza&action=listNote&param='.$row['uczen_id'].'">Uwagi</a></td>';

      //echo '<td><a href="index.php?sub=Baza&action=insertNote&param='.$row['uczen_id'].'">Dodaj uwage</a></td>';

      


       echo '</tr>';
    }}
 ?> 
 </table>