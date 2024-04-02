<?php

echo '<p>Nauczyciel: '. $imie . " " . $nazwisko . "</p>" . '<p>PESEL: ' . $pesel . "</p><p>Uprawnienia:</p>";

?>


<table border="1">
 <?php 
    //odpowiedzialne za umozliwienie wpisania ocen i obecnosci w ramach zajec

    echo '<tr><th>ID przypisania</th><th>ID przedmiotu</th><th>przedmiot</th></tr>';

    if ($data) { 
       foreach ( $data as $row ) { 
       echo '<tr><td>'.$row['przypisanie_id'].'</td><td>'.$row['przedmiot_id'].'</td><td>'.$row['przedmiot'].'</td>' ;

      //echo '<td><a href="javascript:fn_search_info('.$row['nauczyciel_id'].')">Info</a></td>';
      

       echo '</tr>';
    }}
 ?> 



</table>

<p>Zajecia:</p>
<table border ="1">
<?php

   echo '<tr><th>ID zajęć</th><th>przedmiot</th><th>data rozpoczęcia</th><th>data zakończenia</th><th>dzień tygodnia</th></tr>';


   if ($data2) { 
       foreach ( $data2 as $row ) { 
       echo '<tr><td>'.$row['zajecia_id'].'</td><td>'.$row['przedmiot'].'</td><td>'.$row['dzien_rozp'].'</td><td>'.$row['dzien_zak'].'</td><td>'.$row['dzien_tyg'].'</td>' ;

      //echo '<td><a href="javascript:fn_search_info('.$row['nauczyciel_id'].')">Info</a></td>';
      

       echo '</tr>';

      }}


echo "</table> <p>Wychowawca klas:</p><table border ='1'>";

      echo '<tr><th>ID klasy</th><th>klasa</th></tr>';


      if ($data3) { 
          foreach ( $data3 as $row ) { 
          echo '<tr><td>'.$row['klasa_id'].'</td><td>'.$row['klasa'].'</td>' ;
   
         //echo '<td><a href="javascript:fn_search_info('.$row['nauczyciel_id'].')">Info</a></td>';
         
   
          echo '</tr>';
   
         }}







?>


</table>