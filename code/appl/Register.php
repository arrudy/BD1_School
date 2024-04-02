<?php

namespace appl;
class Register {
  

   protected $data = array() ; //nie jest widoczna na zewnątrz klasy i może być dziedziczona
  
   private function domainSelector()
   {
      if(str_contains($_SERVER['HTTP_HOST'],'localhost'))
      {
         return 'localhost';
      }
      else
      return $_SERVER['HTTP_HOST'];
   }

   function __construct () { 


      if(session_status() != PHP_SESSION_ACTIVE && !defined('__NO_REGISTER'))
      {
      session_set_cookie_params([
            'lifetime' => 600,
            'path' => '/~1rudy/',//'/~1rudy/',                 // konto na ktorym dziala serwis 
            'domain' => $this->domainSelector(), //null?
            'secure' => false,                   // serwer Pascal - tylko http
            'httponly' => false,
            'samesite' => 'LAX'
        ]);       
      session_start() ;
      }
   }
  




   /** 
    * Logowanie uzytkownika do serwisu 
    */
function login($user) {
   $_SESSION['auth'] = 'OK' ;
   $_SESSION['user'] = $user ;
    }

    /* Sprawdzamy czy uzytkownik jest zalogowany */
    function is_logged() {

    if ( isset ( $_SESSION['auth'] ) ) 
    {
      return ($_SESSION['auth'] == 'OK' ? true : false );
    } 
      else return false ;
    }


   /**
    * Sprawdza, czy użytkownik może być zalogowany na poziomie dostępu nauczyciela
    * @return bool
    */
    function nauczycielPrivilege()
   {
      if(
         defined('__NO_REGISTER')  
         ||
         ( $this->is_logged() && isset($_SESSION['user']) )
         
      ) return true;
      else
      return false;
   }

/**
    * Sprawdza, czy użytkownik może być zalogowany na poziomie dostępu administratora
    * @return bool
    */
   function adminPrivilege()
   {
      if(
         defined('__NO_REGISTER')  
         ||
         ( $this->is_logged() && isset($_SESSION['user']) && $_SESSION['user'] == 'admin' )
         
      ) return true;
      else
      return false;
   }





    /* Wylogowanie uzytkownika ze serwisu */
function logout() {
   unset($_SESSION);
   session_destroy();
   }
}
?>
