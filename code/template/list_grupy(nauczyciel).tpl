<?php
if(isset($manage) && $manage == 'manage') echo

'<script>



function fn_delete_zajecia(zajecia_id)
 {
     var json_data = "{\"zajecia_id\":\"" + zajecia_id + "\"}" ;
     var msg = "data=" + encodeURIComponent(json_data) ;
     var url = "index.php?sub=Baza&action=direct_deleteZajecia" ;
     resp = function(response) {
      document.getElementById("response").innerHTML = response;
        //document.getElementById("art_content").innerHTML = ;
      }
      xmlhttpPost (url, msg, resp) ;                          
}





</script>
';

?>


<table border="1" id="response">
 <?php 

    //odpowiedzialne za umozliwienie wpisania ocen i obecnosci w ramach zajec
    if ($data) { 
       foreach ( $data as $row ) { 

         $day_of_week = match($row['dzien_tyg']){
            1 => 'PN',
            2 => 'WT',
            3 => 'SR',
            4 => 'CZ',
            5 => 'PT',
            6 => 'SB',
            7 => 'ND',
            '1' => 'PN',
            '2' => 'WT',
            '3' => 'SR',
            '4' => 'CZ',
            '5' => 'PT',
            '6' => 'SB',
            '7' => 'ND'
         };



       echo '<tr><td>'.$row['zajecia_id'].'</td><td>'.$row['przedmiot'].'</td><td>'. $row['dzien_rozp'] . ' - '.$row['dzien_zak'].' ('.$day_of_week.')</td>' ;
       //echo '<td><a href="index.php?sub=Baza&action=listGrupa&nauczyciel_id='.$row['nauczyciel_id'].'&zajecia_id='.$row['zajecia_id'].'">Zajecia</a></td>';


       if(isset($manage) && $manage == 'manage')
       {
       echo '<td><a href="index.php?sub=Baza&action=zarzadzajGrupa&zajecia_id='.$row['zajecia_id'].'">Zarzadzaj</a></td>';
       echo '<td><a href="javascript:fn_delete_zajecia('.$row['zajecia_id'].')">Usun zajecia</a></td>';
      }
      else
      echo '<td><a href="index.php?sub=Baza&action=listGrupa&nauczyciel_id='.$row['nauczyciel_id'].'&zajecia_id='.$row['zajecia_id'].'">Zajecia</a></td>';
      //echo '<td><a href="javascript:fn_search_info('.$row['nauczyciel_id'].')">Info</a></td>';
      

       echo '</tr>';
    }}
 ?> 