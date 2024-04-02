<?php

echo '<p>Wychowawca: '. $imie . " " . $nazwisko . "</p>";
echo '<p>Sala: '.$sala.'</p>';

?>


<table border="1">
 <?php 
    //odpowiedzialne za umozliwienie wpisania ocen i obecnosci w ramach zajec

    echo '<tr><th>ID ucznia</th><th>imie</th><th>nazwisko</th></tr>';

    if ($data) { 
       foreach ( $data as $row ) { 
         echo '<tr><td>'.$row['uczen_id'].'</td><td>'.$row['imie'].'</td><td>'.$row['nazwisko'].'</td>' ;
         echo '<td><a href="index.php?sub=Baza&action=infoUczen&uczen_id='.$row['uczen_id'].'">Info</a></td>';

      //echo '<td><a href="javascript:fn_search_info('.$row['nauczyciel_id'].')">Info</a></td>';
      

       echo '</tr>';
    }}
 ?> 



</table>
