<script src="js/baza.js"></script>
<script type="text/javascript">


/**
 * Procedura przesyłająca zawartość formularzy: [form] do serwera na wyznaczony url za pomocą POST.
 * @returns null
 * Element: [response] ulega aktualizacji o odpowiedź z serwera z dodatkowym formatowaniem
 */
function fn_search_klasa()
 {
    var klasa=document.form.klasa;
     //var klasa = document.getElementById("lname").value ;
     //document.getElementById("data").style.display = "none" ;
     var json_data = "{\"klasa\":\"" + klasa.value  + "\"}" ;
     var msg = "data=" + encodeURIComponent(json_data) ;
     var url = "index.php?sub=Baza&action=direct_searchKlasa" ;
     resp = function(response) {
        response = JSON.parse(response);
        //var studentlist=document.form.klasa;
        //studentlist.options = JSON.parse(response);


        target = document.getElementById("response");
         target.innerHTML = "<tr><th>id</th><th>klasa</th></tr>";

        for (i=0; i<response.length; i++)
        {
            //klasalist.options[klasalist.options.length] = new Option(response[i].imie + " " + response[i].nazwisko,response[i].klasa_id,false,false);
            target.innerHTML += '<tr><td>' + response[i].klasa_id + '</td><td>' + response[i].klasa + '</td>' 
            + '<td><a href = "index.php?sub=Baza&action=infoKlasa&class='+ $row['klasa']   +'">Info</a></td>'
            + '<td><a href="javascript:fn_delete_klasa(' +response[i].klasa_id +')">Usun klase</a></td>';
            
            target.innerHTML += '</tr>';
         }


        //document.getElementById("art_content").innerHTML = ;
      }
      xmlhttpPost (url, msg, resp) ;                          
}


function fn_delete_klasa(id)
 {
     //var klasa = document.getElementById("lname").value ;
     //document.getElementById("data").style.display = "none" ;
     var json_data = "{\"klasa_id\":\"" + id  + "\"}" ;
     var msg = "data=" + encodeURIComponent(json_data) ;
     var url = "index.php?sub=Baza&action=direct_deleteKlasa" ;
     resp = function(response) {
      document.getElementById("response").innerHTML = response;
        //document.getElementById("art_content").innerHTML = ;
      }
      xmlhttpPost (url, msg, resp) ;                          
}



</script>

<form name="form" id = "form">            
  <table>
    <tr><td><label for="klasa">klasa:</label></td>
    <td><input value="<?php if(isset($formData)) echo $formData['klasa']; ?>" type="text" id="klasa" name="klasa" /></td></tr>
    <tr><td><span id="data"><input type="button" value="Znajdz" onclick="fn_search_klasa()" /></span></td>
  </table>
</form> 

<table border="1" id ="response">
<tr><th>id</th><th>klasa</th></tr>
 <?php 
    if ($data) { 
       foreach ( $data as $row ) { 
      echo '<tr><td>'.$row['klasa_id'].'</td><td>'.$row['klasa'].'</td>' ;

      echo '<td><a href="javascript:fn_delete_klasa('.$row['klasa_id'].')">Usun klase</a></td>';
        echo'<td><a href = "index.php?sub=Baza&action=infoKlasa&class='. $row['klasa']   .'">Info</a></td>';

       echo '</tr>';
    }}
 ?> 
 </table>