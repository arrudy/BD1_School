<?php
  
namespace info ;
  
use appl\ { View, Controller, Register } ;
// use appl\Controller ;
  
class Info extends Controller {
  
   protected $layout ;
   protected $model ;
  
   function __construct() {
      parent::__construct();
      $this->layout = new View('main') ;   
      $this->layout->css = $this->css ;
      // $this->layout->css = "<link rel="\"stylesheet\"" href="\"css/main.css\"" type="\"text/css\"" media="\"screen\"">" ;  
      $this->layout->menu = $this->menu ;
       //$this->layout->menu = file_get_contents ('template/menu.tpl') ;
      $this->layout->title = 'E-dziennik' ;
   }
  
   /**
    * Funkcja zwraca stronę powitalną aplikacji.
    * @return string
    */
  function index() {
      $this->layout->header  = 'E-dziennik' ;
      $this->layout->content = new View('intro') ;
      return $this->layout ;
  }
  
  function help() {
      $this->model = new Model();
      $this->layout->header  = 'E-dziennik' ;
      $this->view = new View('table') ;
      $this->view->data = $this->model->getTable() ;
      $this->layout->content = $this->view ;
      return $this->layout;//*/ $this->view ; //modified
  }
  
  function error( $text ) {
      $this->layout->content = $text ;
      return $this->layout ;       
  }
}
  
?>