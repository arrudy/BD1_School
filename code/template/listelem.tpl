<table border="1">
 <?php 
 //zakladam, ze tabela zawsze ma jednakowa szerokosc
    if ($data) { 

      if(count($data) > 0)
      {
        echo '<tr>';
        foreach($data[0] as $key => $value ) echo '<th>'.$key.'</th>';
        echo '</tr>';

       foreach ( $data as $row ) 
      { 
         echo'<tr>';
         foreach($row as $key => $value)
         {
            echo '<td>'.$row[$key].'</td>';
         }
         echo '</tr>' ;
      }
   }
   }
 ?> 