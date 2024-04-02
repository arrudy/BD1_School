<script src="js/baza.js"></script>
<script type="text/javascript">



function fn_search_nauczyciel()
 {
    var nauczyciel=document.form.nauczyciel;
     //var klasa = document.getElementById("lname").value ;
     //document.getElementById("data").style.display = "none" ;
     var json_data = "{\"nauczyciel\":\"" + nauczyciel.value  + "\"}" ;
     var msg = "data=" + encodeURIComponent(json_data) ;
     var url = "index.php?sub=Baza&action=direct_searchNauczyciel" ;
     resp = function(response) {
        response = JSON.parse(response);
        //var studentlist=document.form.nauczyciel;
        //studentlist.options = JSON.parse(response);


        target = document.getElementById("response");
         target.innerHTML = "<tr><th>id</th><th>imie</th><th>nazwisko</th></tr>";

        for (i=0; i<response.length; i++)
        {
            //nauczyciellist.options[nauczyciellist.options.length] = new Option(response[i].imie + " " + response[i].nazwisko,response[i].nauczyciel_id,false,false);
            target.innerHTML += '<tr><td>' + response[i].nauczyciel_id + '</td><td>' + response[i].imie + '</td><td>' + response[i].nazwisko + '</td>' 
            + '<td><a href="index.php?sub=Baza&action=infoNauczyciel&nauczyciel_id=' + response[i].nauczyciel_id +'">Info</a></td>'
            + '<td><a href="index.php?sub=Baza&action=listPrzypisanie&nauczyciel_id=' +response[i].nauczyciel_id +'">Uprawnienia</a></td>'
            + '<td><a href="index.php?sub=Baza&action=zarzadzajGrupyNauczyciela&nauczyciel_id=' +response[i].nauczyciel_id +'">Zarzadzaj zajeciami</a></td>'
            + '<td><a href="javascript:fn_delete_nauczyciel(' +response[i].nauczyciel_id +')">Usun osobe</a></td>'
            + '</tr>';
         }


        //document.getElementById("art_content").innerHTML = ;
      }
      xmlhttpPost (url, msg, resp) ;                          
}


function fn_delete_nauczyciel(id)
 {
     //var klasa = document.getElementById("lname").value ;
     //document.getElementById("data").style.display = "none" ;
     var json_data = "{\"nauczyciel_id\":\"" + id  + "\"}" ;
     var msg = "data=" + encodeURIComponent(json_data) ;
     var url = "index.php?sub=Baza&action=direct_deleteNauczyciel" ;
     resp = function(response) {
      document.getElementById("response").innerHTML = response;
        //document.getElementById("art_content").innerHTML = ;
      }
      xmlhttpPost (url, msg, resp) ;                          
}



</script>

<form name="form" id = "form">            
  <table>
    <tr><td><label for="nauczyciel">Nauczyciel:</label></td>
    <td><input value="<?php if(isset($formData)) echo $formData['nauczyciel']; ?>" type="text" id="nauczyciel" name="nauczyciel" /></td></tr>
    <tr><td><span id="data"><input type="button" value="Znajdz" onclick="fn_search_nauczyciel()" /></span></td>
  </table>
</form> 

<table border="1" id ="response">
<tr><th>id</th><th>imie</th><th>nazwisko</th></tr>
 <?php 
    if ($data) { 
       foreach ( $data as $row ) { 
      echo '<tr><td>'.$row['nauczyciel_id'].'</td><td>'.$row['imie'].'</td><td>'.$row['nazwisko'].'</td>' ;

      echo '<td><a href="index.php?sub=Baza&action=infoNauczyciel&nauczyciel_id='.$row['nauczyciel_id'].'">Info</a></td>';
      echo '<td><a href="index.php?sub=Baza&action=listPrzypisanie&nauczyciel_id='.$row['nauczyciel_id'].'">Uprawnienia</a></td>';
      echo '<td><a href="index.php?sub=Baza&action=zarzadzajGrupyNauczyciela&nauczyciel_id='.$row['nauczyciel_id'].'">Zarzadzaj zajeciami</a></td>';
      echo '<td><a href="javascript:fn_delete_nauczyciel('.$row['nauczyciel_id'].')">Usun osobe</a></td>';

       echo '</tr>';
    }}
 ?> 
 </table>