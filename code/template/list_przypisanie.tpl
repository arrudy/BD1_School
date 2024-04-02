<script src="js/baza.js"></script>
<script>


/**
 * Procedura przesyłająca rządanie do serwera na wyznaczony url za pomocą POST.
 * @returns null
 * @param {*} przypisanie_id przypisanie_id uprawnienia do usuniecia
 * Element: [response] ulega aktualizacji o odpowiedź z serwera
 */
function fn_delete_przypisanie(przypisanie_id)
 {
     var json_data = "{\"przypisanie_id\":\"" + przypisanie_id   + "\"}" ;
     var msg = "data=" + encodeURIComponent(json_data) ;
     var url = "index.php?sub=Baza&action=direct_deletePrzypisanie" ;
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
   foreach ( $data as $row ) { 
   echo '<tr><td>'.$row['przedmiot_id'].'</td><td>'.$row['przedmiot'].'</td>' ;
    echo '<td><a href="javascript:fn_delete_przypisanie('.$row['przypisanie_id'].')">Usun</a></td>';
  //echo '<td><a href="index.php?sub=Baza&action=listGrupyNauczyciela&nauczyciel_id='.$row['nauczyciel_id'].'">Zajecia</a></td>';
  //echo '<td><a href="javascript:fn_search_info('.$row['nauczyciel_id'].')">Info</a></td>';
  


   echo '</tr>';
}}
 ?> 