<?php
 
// define('__NO_REGISTER',true);
 //error_reporting(E_ALL);
 //ini_set('display_errors', 'On');
	error_reporting(0);
/***************
 * 
 * 
 ****************/
function my_autoloader($class_name) {
   // print '{'.$class_name.'}' ;
   $path_to_class = __DIR__. '/' . str_replace('\\', DIRECTORY_SEPARATOR, $class_name) . '.php';
   if ( file_exists($path_to_class) )  
      { require_once($path_to_class); }
   else {
      header('HTTP/1.1 404 Not Found') ;
      //print $path_to_class;
      print '<!doctype html><html><head><title>404 Not Found</title></head><body><p>Invalid URL</p></body></html>' ;
   }   
}
  
spl_autoload_register('my_autoloader');
/*
include_once("appl/Controller.php");
include_once("appl/View.php");
include_once("info/Info.php");
include_once("baza/Baza.php");
include_once("test/Test.php");*/
                 
//use \info\Info ;
//use \baza\Baza ;
//use \test\Test ;
  



try {
  
  if (empty ($_GET['sub']))    { $contr = 'Info' ;   }
  else                         { $contr = $_GET['sub'] ; }
  
  if (empty ($_GET['action'])) { $action     = 'index' ;  }
  else                         { $action     = $_GET['action'] ; } 
    
  switch ($contr) {           
     case 'Info' :
       $contr = "info\\".$contr ;         
       break ;
     case 'Baza' :
       $contr = "baza\\" . $contr ;
       break ;  
      case 'User' :
        $contr = 'user\\'.$contr;
        break;
  }

  //echo $contr;
  //echo $action;
  //$test = new baza\Baza;
  //$test2 = new info\Info;
  //$test2 = new test\Test;

  $controller = new $contr ;
  //echo get_class($controller) ;

  if(count($_GET) <= 2) 
  {
    //echo "Standard";
  echo $controller->$action() ;
  }
  else 
  {
    $param = $_GET;
    unset($param['sub']);
    unset($param['action']);
    //echo "Parametr";
    echo $controller->$action($param);
  }
}
catch (Exception $e) {
  // echo 'Blad -.- : [' . $e->getCode() . '] ' . $e->getMessage() . '<br>' ;
  // echo __CLASS__.':'.__LINE__.':'.__FILE__ ;
  // $contr = new info() ;
  // echo $contr->error ( $e->getMessage() ) ;
  echo 'Error: [' . $e->getCode() . '] ' . $e->getMessage() ;
  
}
  
?>