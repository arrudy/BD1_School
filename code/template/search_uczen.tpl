<script src="js/baza.js"></script>
<script type="text/javascript">



function fn_search_uczen()
 {
    var uczen=document.form.uczen;
     //var klasa = document.getElementById("lname").value ;
     //document.getElementById("data").style.display = "none" ;
     var json_data = "{\"uczen\":\"" + uczen.value  + "\"}" ;
     var msg = "data=" + encodeURIComponent(json_data) ;
     var url = "index.php?sub=Baza&action=direct_searchUczen" ;
     resp = function(response) {
        response = JSON.parse(response);
        //var studentlist=document.form.uczen;
        //studentlist.options = JSON.parse(response);


        target = document.getElementById("response");
         target.innerHTML = "<tr><th>id</th><th>klasa</th><th>imie</th><th>nazwisko</th></tr>";

        for (i=0; i<response.length; i++)
        {
            //uczenlist.options[uczenlist.options.length] = new Option(response[i].imie + " " + response[i].nazwisko,response[i].uczen_id,false,false);
            target.innerHTML += '<tr><td>' + response[i].uczen_id + '</td><td>' + response[i].klasa + '</td><td>' + response[i].imie + '</td><td>' + response[i].nazwisko + '<td><a href="index.php?sub=Baza&action=infoUczen&uczen_id=' +response[i].uczen_id +'">Info</a></td>'  +'<td><a href="javascript:fn_delete_uczen(' +response[i].uczen_id +')">Usun osobe</a></td>' + '</tr>' ;
        }


        //document.getElementById("art_content").innerHTML = ;
      }
      xmlhttpPost (url, msg, resp) ;                          
}


function fn_delete_uczen(id)
 {
     //var klasa = document.getElementById("lname").value ;
     //document.getElementById("data").style.display = "none" ;
     var json_data = "{\"uczen_id\":\"" + id  + "\"}" ;
     var msg = "data=" + encodeURIComponent(json_data) ;
     var url = "index.php?sub=Baza&action=direct_deleteUczen" ;
     resp = function(response) {
      document.getElementById("response").innerHTML = response;
        //document.getElementById("art_content").innerHTML = ;
      }
      xmlhttpPost (url, msg, resp) ;                          
}



</script>

<form name="form" id = "form">            
  <table>
    <tr><td><label for="uczen">Uczen:</label></td>
    <td><input value="<?php if(isset($formData)) echo $formData['uczen']; ?>" type="text" id="uczen" name="uczen" /></td></tr>
    <tr><td><span id="data"><input type="button" value="Znajdz" onclick="fn_search_uczen()" /></span></td>
  </table>
</form> 

<table border="1" id ="response">

<tr><th>id</th><th>klasa</th><th>imie</th><th>nazwisko</th></tr>

 <?php 
    if ($data) { 
       foreach ( $data as $row ) { 
      echo '<tr><td>'.$row['uczen_id'].'</td><td>'.$row['klasa'].'</td><td>'.$row['imie'].'</td><td>'.$row['nazwisko'].'</td>' ;

         //w klasie dac mozliwosc wyszukania po niej
         echo '<td><a href="index.php?sub=Baza&action=infoUczen&uczen_id='.$row['uczen_id'].'">Info</a></td>';
      echo '<td><a href="javascript:fn_delete_uczen('.$row['uczen_id'].')">Usun osobe</a></td>';
      //echo '<td><a href="index.php?sub=Baza&action=listNote&param='.$row['uczen_id'].'">Uwagi</a></td>';

      //echo '<td><a href="index.php?sub=Baza&action=insertNote&param='.$row['uczen_id'].'">Dodaj uwage</a></td>';

      


       echo '</tr>';
    }}
 ?> 
 </table>