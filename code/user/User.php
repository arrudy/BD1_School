<?php
  
namespace user ;
  
use appl\ { View, Controller, Register } ;
// use appl\Controller ;
  
class User extends Controller {
  
   protected $layout ;
   protected $model ;
  
   function __construct() {
      parent::__construct();
      $this->layout = new View('main') ;   
      $this->layout->css = $this->css ;
      // $this->layout->css = "<link rel="\"stylesheet\"" href="\"css/main.css\"" type="\"text/css\"" media="\"screen\"">" ;  
      $this->layout->menu = $this->menu ;
       //$this->layout->menu = file_get_contents ('template/menu.tpl') ;
      $this->layout->title = 'Baza danych SQL' ;
   }
  
  function login() {

      $this->layout->header  = 'Zaloguj' ;
      //$this->layout->content = 'Template - test !' ;


        $this->layout->content = new View('form_login');

      return $this->layout ;
  }


  function logout()
   {
      unset($_SESSION);
   session_destroy();
   }



  
  function error( $text ) {
      $this->layout->content = $text ;
      return $this->layout ;       
  }
}
  
?>