<script src="js/baza.js"></script>
<script>


/**
 * Procedura przesyłająca rządanie do serwera na wyznaczony url za pomocą POST.
 * @returns null
 * @param {*} id obecnosc_id obecnosci do usuniecia
 * Element: [response] ulega aktualizacji o odpowiedź z serwera
 */
function fn_delete_obecnosc(id)
 {
     //var klasa = document.getElementById("lname").value ;
     //document.getElementById("data").style.display = "none" ;
     var json_data = "{\"obecnosc_id\":\"" + id  + "\"}" ;
     var msg = "data=" + encodeURIComponent(json_data) ;
     var url = "index.php?sub=Baza&action=direct_deleteObecnosc" ;
     resp = function(response) {
      document.getElementById("response").innerHTML = response;
        //document.getElementById("art_content").innerHTML = ;
      }
      xmlhttpPost (url, msg, resp) ;                          
}


</script>


<table border="1" id="response">
 <?php 
 //zakladam, ze tabela zawsze ma jednakowa szerokosc
 if ($data) { 
  echo '<tr><th>ID obecności</th><th>typ</th><th>data</th></tr>';

   foreach ( $data as $row ) { 
   echo '<tr><td>'.$row['obecnosc_id'].'</td><td>'.$row['typ'].'</td><td>'.$row['data'].'</td>' ;

  echo '<td><a href="javascript:fn_delete_obecnosc('.$row['obecnosc_id'].')">Usun</a></td>';
  //echo '<td><a href="index.php?sub=Baza&action=listGrupyNauczyciela&nauczyciel_id='.$row['nauczyciel_id'].'">Zajecia</a></td>';
  //echo '<td><a href="javascript:fn_search_info('.$row['nauczyciel_id'].')">Info</a></td>';
  


   echo '</tr>';
}}
 ?> 