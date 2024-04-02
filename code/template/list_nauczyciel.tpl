<table border="1">
 <?php 
    if ($data) { 
       foreach ( $data as $row ) { 
       echo '<tr><td>'.$row['nauczyciel_id'].'</td><td>'.$row['imie'].'</td><td>'.$row['nazwisko'].'</td>' ;

      echo '<td><a href="index.php?sub=Baza&action=listGrupyNauczyciela&nauczyciel_id='.$row['nauczyciel_id'].'">Zajecia</a></td>';
      


       echo '</tr>';
    }}
 ?> 