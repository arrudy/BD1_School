<?php

echo '<p>Uczeń: '. $imie . " " . $nazwisko . "</p>" . '<p>PESEL: ' . $pesel . "</p><p>Oceny:</p>";

?>


<table border="1">
 <?php 
    //odpowiedzialne za umozliwienie wpisania ocen i obecnosci w ramach zajec

    echo '<tr><th>ID przedmiotu</th><th>przedmiot</th><th>oceny</th><th>srednia</th></tr>';

    if ($data) { 
       foreach ( $data as $row ) { 
       echo '<tr><td>'.$row['przedmiot_id'].'</td><td>'.$row['przedmiot'].'</td><td>'.$row['oceny'].'</td><td>'.$row['srednia'].'</td>' ;

      //echo '<td><a href="javascript:fn_search_info('.$row['nauczyciel_id'].')">Info</a></td>';
      

       echo '</tr>';
    }}
 ?> 



</table>

<p>Obecności:</p>
<table border ="1">
<?php

   echo '<tr><th>ID zajęć</th><th>przedmiot</th><th>ob</th><th>nb</th><th>zw</th><th>us</th><th>rekordów</th><th>zajęć</th></tr>';


   if ($data2) { 
       foreach ( $data2 as $row ) { 
       echo '<tr><td>'.$row['zajecia_id'].'</td><td>'.$row['przedmiot'].'</td><td>'.$row['obecnosci'].'</td><td>'.$row['nieobecnosci'].'</td><td>'.$row['zwolnien'].'</td><td>'.$row['usprawiedliwien'].'</td><td>'.$row['rekordow'].'</td><td>'.$row['zajec'].'</td>' ;

      //echo '<td><a href="javascript:fn_search_info('.$row['nauczyciel_id'].')">Info</a></td>';
      

       echo '</tr>';

      }}

?>


</table>