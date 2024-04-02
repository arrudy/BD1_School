<head>
   <meta http-equiv="content-type" content="text/html; charset=iso-8859-2">
   <title>E-dziennik</title>
   <?php echo $css ; ?>  
   <script type="text/JavaScript" src="js/baza.js"></script> 
</head>
<a href="index.php" >Strona główna</a><!--<br/>-->
<a href="index.php?sub=Baza&action=listNauczyciel" >Zajęcia</a><!--<br />-->


<?php

//if(defined('__NO_REGISTER') || (isset($_SESSION['auth']) && isset($_SESSION['user']) && $_SESSION['user'] == 'admin') )
echo "<span>
<a href='index.php?sub=Baza&action=utworz' >Utwórz</a>/
<a href='index.php?sub=Baza&action=wyswietl' >Przeglądaj</a>/
<a href='index.php?sub=Baza&action=struktura' >Zarządzaj</a>
</span>";



 if(!defined('__NO_REGISTER'))
 {
   if(isset($_SESSION['auth']))
   {
      echo "<a href='index.php?sub=User&action=logout' >Wyloguj</a>";
   }else
   {
      echo "<a href='index.php?sub=User&action=login' >Zaloguj</a>";
   }

 }


?>