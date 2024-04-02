<script src="js/baza.js"></script>


<?php
if(isset($manage) && $manage == 'manage') echo

'<script>



function fn_delete_zapis(zajecia_id, uczen_id)
 {
     var json_data = "{\"zajecia_id\":\"" + zajecia_id + "\",\"uczen_id\":\"" + uczen_id  + "\"}" ;
     var msg = "data=" + encodeURIComponent(json_data) ;
     var url = "index.php?sub=Baza&action=direct_deleteZapis" ;
     resp = function(response) {
      document.getElementById("response").innerHTML = response;
        //document.getElementById("art_content").innerHTML = ;
      }
      xmlhttpPost (url, msg, resp) ;                          
}





</script>
';
else echo

'<script>



function fn_rand(zajecia_id)
 {
      var data = document.form.data.value;

     var json_data = "{\"zajecia_id\":\"" + zajecia_id + "\",\"data\":\"" + data  + "\"}" ;
     var msg = "data=" + encodeURIComponent(json_data) ;
     var url = "index.php?sub=Baza&action=direct_randZapis" ;
     resp = function(response) {
      document.getElementById("rng").innerHTML = response;
      }
      xmlhttpPost (url, msg, resp) ;                          
}





</script>
'





?>



<table border="1" id="response">


<?php 
 //param to dodatkowa tablica parametrow pomocniczych do zawarcia odpowiedniej funkcjonalnosci


    if ($data) { 
       foreach ( $data as $row ) { 
      echo '<tr><td>'.$row['uczen_id'].'</td><td>'.$row['imie'].'</td><td>'.$row['nazwisko'].'</td>' ;


      //echo '<td><a href="javascript:fn_search_note('.$row['osoba_id'].')">Zobacz uwagi</a></td>';

         if(isset($manage) && $manage == 'manage')
         {
            //echo '<td><a href="index.php?sub=Baza&action=deleteZapis&zajecia_id='.$_GET['zajecia_id'].'&uczen_id='.$row['uczen_id'].'">Wypisz ucznia</a></td>';
            echo '<td><a href="javascript:fn_delete_zapis('.$_GET['zajecia_id'].', '.$row['uczen_id'].')">Wypisz ucznia</a></td>';
         }


         echo '<td><a href="index.php?sub=Baza&action=insertObecnosc&zajecia_id='.$_GET['zajecia_id'].'&uczen_id='.$row['uczen_id'].'">Dodaj obecnosc</a></td>';
         echo '<td><a href="index.php?sub=Baza&action=listObecnosc&zajecia_id='.$_GET['zajecia_id'].'&uczen_id='.$row['uczen_id'].'">Zobacz obecnosci</a></td>';
      
      
         echo '<td><a href="index.php?sub=Baza&action=insertOcena&zajecia_id='.$_GET['zajecia_id'].'&uczen_id='.$row['uczen_id'].'">Dodaj ocene</a></td>';
         echo '<td><a href="index.php?sub=Baza&action=listOcena&zajecia_id='.$_GET['zajecia_id'].'&uczen_id='.$row['uczen_id'].'">Zobacz oceny</a></td>';
      
         

       echo '</tr>';
    }
   echo '</table>';



   if(!isset($manage))
   {
      $date = date("Y-m-d");

      echo
      '<form name="form">
      <tr><td><label for="data">Dzien:</label></td>
      <td><input value="'.$date.'" type="date" id="data" name="data"/></td></tr>
      <span id="data"><input type="button" value="Losuj ucznia" onclick="fn_rand('.$_GET['zajecia_id'].')" /></span>
      <p id="rng"></p>
      </form>';
   }



   }
 ?> 





