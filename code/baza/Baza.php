<?php
  
namespace baza   ;
  
use appl\ { View, Controller, Register } ;
// use appl\Controller ;


class Baza extends Controller 
{
  
    protected $layout ;
    protected $model ;
  
    function __construct() {
       parent::__construct();
       $this->layout = new View('main') ;
       $this->layout->css = $this->css ;
       // $this->layout->css = "<<link rel=\"stylesheet\" href=\"css/main.css\" type=\"text/css\" media=\"screen\" >" ; 
       $this->layout->title  = 'E-dziennik' ;
       $this->layout->menu = $this->menu ;
       // $this->layout->menu = file_get_contents ('template/menu.tpl') ;
       $this->model  = new Model() ;
    }

    /**
     * Zwraca formularz zawierający informację o braku dostępu do zasobów.
     * @param who Dla who = 'admin' zwraca powiadomienie o za niskim poziomie dostępu. Dla dowolnego innego parametru domyślny komunikat o braku dostępu. 
     * @return string
     */
    function badAccess($who)
    {
      $this->layout->header = 'Brak uprawnień' ;
      $this->layout->content = 'Nie można załadować strony. ' . ($who == 'admin' ? 'Brak uprawnień administratora.' : 'Brak uprawnień.'); 
      return $this->layout ;
    }
  

    function loginUser() {
      $data = $_POST['data'] ;
      $obj  = json_decode($data) ;

      $response = false;

      if ( isset($obj->nauczyciel_id) and isset($obj->PESEL) ) {
           //echo "id= ".$obj->nauczyciel_id." pesel= ".$obj->PESEL ;      


           if($obj->nauczyciel_id == 'admin' && $obj->PESEL = 'adminadmin')
           {
            $this->register->login('admin');
            return 'Zalogowano pomyslnie uzytkownika o podwyższonym stopniu dostępu.';
           }



         $found = $this->model->szukajLogin($obj) ;
         if(count($found) == 0)
         {
            return 'Uzytkownik o podanym adresie nie istnieje!';
         }
         else //pasuje dokladnie
         {
            $this->register->login($obj->nauczyciel_id);
            return 'Zalogowano pomyslnie.';
         }

         if($found[0]['nauczyciel_id'] == $obj->nauczyciel_id || $found[0]['pesel'] == $obj->PESEL)
         {
            return 'Błędne dane.';
         }
      }
      return $response ;
   }

    /**
     * Zwraca formularz zawierający listę nauczycieli i odnośników do ich zajęć
     * 
     * @return string
     */
    function listNauczyciel() {  
      
      if(!$this->register->nauczycielPrivilege()) return $this->badAccess(null);


       $this->layout->header = 'Lista wszystkich nauczycieli' ;
       $this->view = new View('list_nauczyciel') ;
       $this->view->data = $this->model->listNauczyciel() ;
       $this->layout->content = $this->view ; 

      //echo $this->view;

       return $this->layout ;
    }
      

    /**
    * Zwraca formularz realizujący funkcjonalność dodawania nauczyciela.
    * 
    */
    function insertNauczyciel() {
      if(!$this->register->adminPrivilege()) return $this->badAccess('admin');

       $this->layout->header = 'Dodaj nauczyciela' ;
       $this->view = new View('form_nauczyciel') ;
       $this->layout->content = $this->view ;
       return $this->layout ;
    }


    /**
    * Zwraca formularz realizujący funkcjonalność dodawania ucznia.
    * 
    */
    function insertUczen() {
      if(!$this->register->adminPrivilege()) return $this->badAccess('admin');

      $this->layout->header = 'Dodaj ucznia' ;
      $this->view = new View('form_uczen') ;
      $this->layout->content = $this->view ;
      return $this->layout ;
   }


   /**
    * Zwraca formularz realizujący funkcjonalność dodawania przedmiotów.
    * 
    */
   function insertPrzedmiot() {
      if(!$this->register->adminPrivilege()) return $this->badAccess('admin');

      $this->layout->header = 'Dodaj przedmiot' ;
      $this->view = new View('form_przedmiot') ;
      $this->layout->content = $this->view ;
      return $this->layout ;
   }


   /**
    * Zwraca formularz realizujący funkcjonalność dodawania klas.
    * 
    */
    function insertClass() {
      if(!$this->register->adminPrivilege()) return $this->badAccess('admin');

      $this->layout->header = 'Dodaj klase' ;
      $this->view = new View('form_class') ;
      $this->layout->content = $this->view ;
      return $this->layout ;
   }


   /**
    * Zwraca formularz realizujący funkcjonalność wstawiania danych do tabeli zapis.
    * 
    */
   function insertZapis()
   {
      if(!$this->register->adminPrivilege()) return $this->badAccess('admin');
     //$obj = $_GET['param'] ;
     //

     $this->layout->header = 'Zapisz ucznia' ;


      $response = $this->model->listKlasa() ;
      $response_zajecia = $this->model->listPrzedmiot();



     if($response != null)
     {
        $this->view = new View('pair_zapis');
        $this->view->data = $response;
        $this->view->data2 = $response_zajecia;
        $response = $this->view;
     }
     else
     {
        $response = 'Brak klas, nie da sie przypisac.';
     }
     $this->layout->content = $response;
     return $this->layout;
   }


   /**
    * Zwraca formuarz realizujący algorytm zapisania wybranej klasy na zajęcia.
    * 
    */
   function algorytm_zapiszKlase()
   {
      if(!$this->register->adminPrivilege()) return $this->badAccess('admin');
     //$obj = $_GET['param'] ;
     //

     $this->layout->header = 'Zapisz klasę na zajęcia' ;


      $response = $this->model->listKlasa() ;
      $response_zajecia = $this->model->listPrzedmiot();



     if($response != null && $response_zajecia != null)
     {
        $this->view = new View('algorithm_zapisKlasy');
        $this->view->data = $response;
        $this->view->data2 = $response_zajecia;
        $response = $this->view;
     }
     else
     {
         if($response == null)
        $response = 'Brak klas, nie da sie przypisac.';
      else $response = 'Brak przedmiotow, nie da sie przypisac.';
     }
     $this->layout->content = $response;
     return $this->layout;
   }


   
   

   /**
    * Zwraca formularz realizujący funkcjonalność wstawiania danych do tabeli przypisanie.
    * @return string
    * 
    */
   function insertPrzypisanie()
   {
      if(!$this->register->adminPrivilege()) return $this->badAccess('admin');
     //$obj = $_GET['param'] ;
     //

     $this->layout->header = 'Dodaj uprawnienia' ;


      $response = $this->model->listNauczyciel() ;
      $response_zajecia = $this->model->listPrzedmiot();



     if($response != null && $response_zajecia != null)
     {
        $this->view = new View('pair_przypisanie');
        $this->view->data = $response;
        $this->view->data2 = $response_zajecia;
        $response = $this->view;
     }
     else
     {
      if($response == null) $response = 'Brak nauczycieli, nie da się przypisać.';
      else $response = 'Brak przedmiotów, nie da się przypisać.';
     }
     $this->layout->content = $response;
     return $this->layout;
   }


/**
    * Zwraca formularz realizujący funkcjonalność aktualizacji wychowawcy danej klasy
    * @return string
    * 
    */
    function updateWychowawca()
    {
       if(!$this->register->adminPrivilege()) return $this->badAccess('admin');
      //$obj = $_GET['param'] ;
      //
 
      $this->layout->header = 'Zaktualizuj wychowawcę' ;
 
 
       $response = $this->model->listNauczyciel() ;
       $response_zajecia = $this->model->listKlasa();
 
 
 
      if($response != null && $response_zajecia != null)
      {
         $this->view = new View('update_wychowawca');
         $this->view->data = $response_zajecia;
         $this->view->data1 = $response;
         $response = $this->view;
      }
      else
      {
       if($response == null) $response = 'Brak klasy, nie da się uaktualnić.';
       else $response = 'Brak nauczycieli, nie da się uaktualnić.';
      }
      $this->layout->content = $response;
      return $this->layout;
    }



/**
     * Funkcja aktualizująca pole wychowawca_id wybranej klasy
     * Identyfikatory podawane przez tablicę $_POST żądania.
     * @return string|null
     * 
     */
    function updateKlasa_wychowawca()
    {
      if(!$this->register->adminPrivilege()) return null;


      $data = $_POST['data'] ;
      $obj  = json_decode($data) ;
      if (isset($obj->nauczyciel_id) && isset($obj->klasa_id))
      {
         {     
            return (pg_fetch_all(
               pg_query_params(
                  $this->model->get_dbconn(),
                  'UPDATE klasa set wychowawca_id = $1 WHERE klasa_id = $2', 
                  array($obj->nauczyciel_id, $obj->klasa_id)
               )
            ) == null ? 'Sukces' : 'Błąd' );
         }
      }
      return null;



    }






   
   /**
    * Zwraca formularz realizujący funkcjonalność wstawiania danych do tabeli zajecia.
    * @return string
    * 
    */
   function insertZajecia()
   {
      if(!$this->register->adminPrivilege()) return $this->badAccess('admin');
     //$obj = $_GET['param'] ;
     //
     $this->layout->header = 'Dodaj zajęcia' ;


      $response = $this->model->listPrzedmiot() ;



     if($response != null)
     {
        $this->view = new View('form_zajecia');
        $this->view->data = $response;
        $response = $this->view;
     }
     else
     {
      $response = 'Brak przedmiotow, nie da się utworzyć.';
     }
     $this->layout->content = $response;
     return $this->layout;
   }






//nauczycie_id, zajecia_id -> lista(osoba, dodaj ocene, dodaj obecnosc) _GET (interfejs)


   /**
    * Zwraca formularz realizujący funkcjonalność wstawiania ocen do tabeli ocena.
    * @param param Tablica z ustalonymi wartościami dla kluczy: uczen_id, zajecia_id
    * @return string|null
    * 
    */
   function insertOcena($param)
   {
      if(!$this->register->nauczycielPrivilege()) return $this->badAccess(null);

      $param = (object) $param;

      if($this->model->szukajUczen($param->uczen_id) && $this->model->szukajZajecia($param->zajecia_id))
      {
         $this->layout->header = 'Dodaj ocene';
         $this->view = new View('form_ocena');
         $this->layout->content = $this->view;
         return $this->layout;
      }

      return null;
   }


   /**
    * Zwraca formularz realizujący funkcjonalność wstawiania obecności do tabeli obecnosc.
    * @param param Tablica z ustalonymi wartościami dla kluczy: uczen_id, zajecia_id
    * @return string|null
    * 
    */
   function insertObecnosc($param)
   {
      if(!$this->register->nauczycielPrivilege()) return $this->badAccess(null);

      $param = (object) $param;

      if($this->model->szukajUczen($param->uczen_id) && $this->model->szukajZajecia($param->zajecia_id))
      {
         $this->layout->header = 'Dodaj obecnosc';
         $this->view = new View('form_obecnosc');
         $this->layout->content = $this->view;
         return $this->layout;
      }

      return null;
   }








   /**
    * Zwraca formularz realizujący funkcjonalność wyszukiwania uczniów z tabeli uczen.
    * @return string|null
    * 
    */
    function szukajUczen()
    {
      if(!$this->register->adminPrivilege()) return $this->badAccess('admin');

         //$obj = $_GET['param'] ;
      //

      $this->layout->header = 'Szukaj ucznia' ;


      $response = $this->model->searchUczen(null) ;



      if($response != null)
      {
         $this->view = new View('search_uczen');
         $this->view->data = $response;
         $response = $this->view;
      }
      else
      {
         $response = 'Brak uczniów.';
      }
      $this->layout->content = $response;
      return $this->layout;
    }


    /**
     * Funkcja szukająca ucznia.
     * Fraza do znalezienia w imieniu / nazwisku / imieniu i nazwisku, podawana poprzez tablicę $_POST żądania.
     * @return string|null
     * Zwracana jest jedynie tablica znalezionych rekordów.
     * Zwracane kolumny: uczen_id, imie, nazwisko, klasa.id as klasa
     */
    function direct_searchUczen()
    {
      if(!$this->register->adminPrivilege()) return null;

      $data = $_POST['data'] ;
      $obj  = json_decode($data) ;
      if (isset($obj->uczen))
      {
         {     
            return json_encode($this->model->searchUczen($obj)) ;
         }
      }
      return null;
    }


    /**
     * Funkcja usuwająca ucznia.
     * uczen_id (wraz z innymi parametrami filtrującymi) podawane poprzez tablicę $_POST żądania.
     * @return string odpowiedź zwrotna o powodzeniu usunięcia
     */
    function direct_deleteUczen()
    {
      if(!$this->register->adminPrivilege()) return "Błąd uprawnień";

      $data = $_POST['data'] ;
      $obj  = json_decode($data) ;
      $response = null;
      if (isset($obj->uczen_id))
      {
         {     
            $response = $this->model->universalDelete($obj,'uczen') ;
         }
      }
      return $response ? "Usunięto" : "Błąd. ";
    }






   /**
    * Zwraca formularz realizujący funkcjonalność wyszukiwania nauczycieli z tabeli nauczyciel.
    * @return string|null
    * 
    */
    function szukajNauczyciel()
    {
      if(!$this->register->adminPrivilege()) return $this->badAccess('admin');
         //$obj = $_GET['param'] ;
      //

      $this->layout->header = 'Szukaj nauczyciela' ;
      $response = $this->model->searchNauczyciel(null) ;

      if($response != null)
      {
         $this->view = new View('search_nauczyciel');
         $this->view->data = $response;
         $response = $this->view;
      }
      else
      {
         $response = 'Brak uczniow.';
      }
      $this->layout->content = $response;
      return $this->layout;
    }


    /**
     * Funkcja szukająca nauczyciela.
     * Fraza do znalezienia w imieniu / nazwisku / imieniu i nazwisku, podawana poprzez tablicę $_POST żądania.
     * @return string|null
     * Zwracana jest jedynie tablica znalezionych rekordów.
     * Zwracane kolumny: nauczyciel_id, imie, nazwisko
     */
    function direct_searchNauczyciel()
    {
      if(!$this->register->adminPrivilege()) return null;

      $data = $_POST['data'] ;
      $obj  = json_decode($data) ;
      if (isset($obj->nauczyciel))
      {
         {     
            return json_encode($this->model->searchNauczyciel($obj)) ;
         }
      }
      return null;
    }


    /**
     * Funkcja usuwająca nauczyciela.
     * nauczyciel_id (wraz z innymi parametrami filtrującymi) podawane poprzez tablicę $_POST żądania.
     * @return string
     */
    function direct_deleteNauczyciel()
    {
      if(!$this->register->adminPrivilege()) return "Błąd uprawnień";

      $data = $_POST['data'] ;
      $obj  = json_decode($data) ;
      $response = null;
      if (isset($obj->nauczyciel_id))
      {
         {     
            $response = $this->model->universalDelete($obj,'nauczyciel') ;
         }
      }
      return $response ? "Usunięto" : "Błąd. Któreś zajęcia prowadzone przez nauczyciela nadal mogą się odbywać. ";
    }





   /**
    * Zwraca formularz realizujący funkcjonalność wyszukiwania klasy z tabeli klasa.
    * @return string|null
    * 
    */
    function szukajKlasa()
    {
      if(!$this->register->adminPrivilege()) return $this->badAccess('admin');
         //$obj = $_GET['param'] ;
      //

      $this->layout->header = 'Szukaj klasy' ;
      $response = $this->model->searchKlasa(null) ;

      if($response != null)
      {
         $this->view = new View('search_klasa');
         $this->view->data = $response;
         $response = $this->view;
      }
      else
      {
         $response = 'Brak klas.';
      }
      $this->layout->content = $response;
      return $this->layout;
    }

    
    /**
     * Funkcja szukająca klasy.
     * Nazwa klasy podawana poprzez tablicę $_POST żądania.
     * @return string|null
     * Zwracana jest jedynie tablica znalezionych rekordów.
     * Zwracane kolumny: klasa_id, klasa.id as klasa
     */
    function direct_searchKlasa()
    {
      if(!$this->register->adminPrivilege()) return null;

      $data = $_POST['data'] ;
      $obj  = json_decode($data) ;
      if (isset($obj->klasa))
      {
         {     
            return json_encode($this->model->searchKlasa($obj)) ;
         }
      }
      return null;
    }


    /**
     * Funkcja usuwająca klasę.
     * klasa_id (wraz z innymi parametrami filtrującymi) podawane poprzez tablicę $_POST żądania.
     * @return string
     */
    function direct_deleteKlasa()
    {
      if(!$this->register->adminPrivilege()) return "Błąd uprawnień";

      $data = $_POST['data'] ;
      $obj  = json_decode($data) ;
      $response = null;
      if (isset($obj->klasa_id))
      {
         {     
            $response = $this->model->universalDelete($obj,'klasa') ;
         }
      }
      return $response ? "Usunięto" : "Błąd. ";
    }






   /**
    * Zwraca formularz realizujący funkcjonalność wyszukiwania przedmiotu z tabeli przedmiot.
    * @return string|null
    * 
    */
    function szukajPrzedmiot()
    {
      if(!$this->register->adminPrivilege()) return $this->badAccess('admin');
         //$obj = $_GET['param'] ;
      //

      $this->layout->header = 'Szukaj przedmiotu' ;
      $response = $this->model->searchPrzedmiot(null) ;

      if($response != null)
      {
         $this->view = new View('search_przedmiot');
         $this->view->data = $response;
         $response = $this->view;
      }
      else
      {
         $response = 'Brak przedmiotów.';
      }
      $this->layout->content = $response;
      return $this->layout;
    }


    /**
     * Funkcja szukająca przedmiotu.
     * Przedmotu podawana poprzez tablicę $_POST żądania.
     * @return string|null
     * Zwracana jest jedynie tablica znalezionych rekordów.
     * Zwracane kolumny: przedmiot_id, przedmiot.nazwa as przedmiot
     */
    function direct_searchPrzedmiot()
    {
      if(!$this->register->adminPrivilege()) return null;

      $data = $_POST['data'] ;
      $obj  = json_decode($data) ;
      if (isset($obj->przedmiot))
      {
         {     
            return json_encode($this->model->searchPrzedmiot($obj)) ;
         }
      }
      return null;
    }


    /**
     * Funkcja usuwająca przedmiot.
     * przedmiot_id (wraz z innymi parametrami filtrującymi) podawane poprzez tablicę $_POST żądania.
     * @return string
     */
    function direct_deletePrzedmiot()
    {
      if(!$this->register->adminPrivilege()) return "Błąd uprawnień";

      $data = $_POST['data'] ;
      $obj  = json_decode($data) ;
      $response = null;
      if (isset($obj->przedmiot_id))
      {
         {     
            $response = $this->model->universalDelete($obj,'przedmiot') ;
         }
      }
      return $response ? "Usunięto" : "Błąd. Któreś zajęcia z tego przedmiotu nadal mogą się odbywać. ";
    }








   /**
     * Funkcja usuwająca ocenę.
     * ocena_id (wraz z innymi parametrami filtrującymi) podawane poprzez tablicę $_POST żądania.
     * @return string odpowiedź zwrotna
     */
    function direct_deleteOcena()
    {
      if(!$this->register->nauczycielPrivilege()) return "Błąd uprawnień";

      $data = $_POST['data'] ;
      $obj  = json_decode($data) ;
      $response = null;
      if (isset($obj->ocena_id))
      {
         {     
            $response = $this->model->universalDelete($obj,'ocena') ;
         }
      }
      return $response ? "Usunięto" : "Błąd. ";
    }


    /**
     * Funkcja usuwająca obecność.
     * obecnosc_id (wraz z innymi parametrami filtrującymi) podawane poprzez tablicę $_POST żądania.
     * @return string odpowiedź zwrotna
     */
    function direct_deleteObecnosc()
    {
      if(!$this->register->nauczycielPrivilege()) return "Błąd uprawnień";

      $data = $_POST['data'] ;
      $obj  = json_decode($data) ;
      $response = null;
      if (isset($obj->obecnosc_id))
      {
         {     
            $response = $this->model->universalDelete($obj,'obecnosc') ;
         }
      }
      return $response ? "Usunięto" : "Błąd. ";
    }





    /**
     * Szuka przypisań powiązanych z danym przedmiotem
     */
   function direct_searchPrzypisanie_przedmiot()
   {
      if(!$this->register->adminPrivilege()) return null;

      $data = $_POST['data'] ;
      $obj  = json_decode($data) ;
      if (isset($obj->przedmiot_id))
      {
         {
            return json_encode($this->model->searchPrzypisanie_przedmiot($obj));
         }
      }
      return null;

   }


   /**
     * Funkcja usuwająca przypisanie.
     * przypisanie_id (wraz z innymi parametrami filtrującymi) podawane poprzez tablicę $_POST żądania.
     * @return strings
     */
   function direct_deletePrzypisanie()
    {
      if(!$this->register->adminPrivilege()) return "Błąd uprawnień";

      $data = $_POST['data'] ;
      $obj  = json_decode($data) ;
      $response = null;
      if (isset($obj->przypisanie_id))
      {
         {     
            $response = $this->model->universalDelete($obj,'przypisanie') ;
         }
      }
      return $response ? "Usunieto" : "Blad ";
    }




   /**
    * Szuka uczniow danej klasy
    */
    function direct_searchClass()
    {
      if(!$this->register->adminPrivilege()) return null;

      $data = $_POST['data'] ;
      $obj  = json_decode($data) ;
      if (isset($obj->class))
      {
         {
            return json_encode($this->model->searchClass($obj));
         }
      }
      return null;
    }


    /**
     * Szuka zajęć związanych z danym przedmiotem
     */
    function direct_searchZajecia_przedmiot()
    {
      if(!$this->register->adminPrivilege()) return null;

      $data = $_POST['data'] ;
      $obj  = json_decode($data) ;
      if (isset($obj->przedmiot_id))
      {
         {
            return json_encode($this->model->searchZajecia_przedmiot($obj));
         }
      }
      return null;


    }

   /**
    * Zwraca formularz listujący wszystkie oceny danego ucznia w ramach danych zajęć.
    * @param param tablica zawierająca wartości dla kluczy: zajecia_id i uczen_id, dla którego zostaną wyszukane oceny
    * @return string formularz w formacie HTML
    */
    function listOcena($param)
    {
      if(!$this->register->nauczycielPrivilege()) return $this->badAccess(null);

      if ($param != null)
      {
         { 
            $response = $this->model->listOcena((object) $param) ;
         }
      }
      if($response != null)
      {
         $layout = new View('list_ocena(zajecia, uczen)');
         $layout->data = $response;
         $response = $layout;
      }
      else
      {
         $response = 'Brak ocen';
      }



      $this->layout->header = 'Oceny wybranej osoby';
      //$this->view = new View('form_search');
      $this->layout->content = $response; //$this->view;

      return $this->layout;


      //return $response;
    }


    /**
    * Zwraca formularz listujący wszystkie obecności danego ucznia w ramach danych zajęć.
    * @param param tablica zawierająca wartości dla kluczy: zajecia_id i uczen_id, dla którego zostaną wyszukane obecności
    * @return string
    */
    function listObecnosc($param)
    {
      if(!$this->register->nauczycielPrivilege()) return $this->badAccess(null);

      if ($param != null)
      {
         { 
            $response = $this->model->listObecnosc((object) $param) ;
         }
      }
      if($response != null)
      {
         $layout = new View('list_obecnosc(zajecia, uczen)');
         $layout->data = $response;
         $response = $layout;
      }
      else
      {
         $response = 'Brak obecnosci';
      }



      $this->layout->header = 'Obecnosci wybranej osoby';
      //$this->view = new View('form_search');
      $this->layout->content = $response; //$this->view;

      return $this->layout;


      //return $response;
    }



   /**
    * Zwraca formularz listujący wszystkie przedmioty, do których uprawniony jest nauczyciel.
    * @param param tablica zawierająca wartości dla kluczy: nauczyciel_id, dla którego zostaną wyszukane uprawnienia
    * @return string
    */
    function listPrzypisanie($param)
    {
      if(!$this->register->adminPrivilege()) return $this->badAccess('admin');

      if ($param != null)
      {
         { 
            $response = $this->model->listPrzypisanie((object) $param) ;
         }
      }
      if($response != null)
      {
         $layout = new View('list_przypisanie');
         $layout->data = $response;
         $response = $layout;
      }
      else
      {
         $response = 'Brak przypisań. Przypisz <a href="index.php?sub=Baza&action=insertPrzypisanie">tutaj<\a>. ';
      }



      $this->layout->header = 'Uprawnienia';
      //$this->view = new View('form_search');
      $this->layout->content = $response; //$this->view;

      return $this->layout;

      //return $response;
    }











    /**
     * Zwraca formularz zawierający znane informacje o uczniu: dane osobowe, podsumowanie ocen z przedmiotów, podsumowanie obecności.
     * Parametr uczen_id podawany poprzez tablicę $_GET.
     * @return string
     */
    function infoUczen()
    {
      if(!$this->register->adminPrivilege()) return $this->badAccess('admin');

      $obj = array();
      $obj['uczen_id'] = $_GET['uczen_id'] ;
      

      $this->layout->header = 'Informacje o uczniu' ;


      $response = $this->model->infoUczen((object)$obj) ;



      if($response != null)
      {
         $this->view = new View('info_uczen');

         //podsumowanie ocen
         $this->view->data = pg_fetch_all(
            pg_query_params(
               $this->model->get_dbconn(),
               'SELECT * from przedmiot_oceny_lista($1) join przedmiot_srednia using(przedmiot_id) where uczen_id = $1;', 
               array($obj['uczen_id'])
            )
         );

         //podsumowanie obecności
         $this->view->data2 = pg_fetch_all(
            pg_query_params(
               $this->model->get_dbconn(),
               'SELECT przedmiot.nazwa as przedmiot, obecnosc_podsumowanie.* from zajecia join obecnosc_podsumowanie using(zajecia_id) join przypisanie using(przypisanie_id) join przedmiot using(przedmiot_id) where uczen_id = $1;', 
               array($obj['uczen_id'])
            )
         );


         $this->view->imie = $response[0]['imie'];
         $this->view->nazwisko = $response[0]['nazwisko'];
         $this->view->pesel = $response[0]['pesel'];
         $this->view->uczen_id = $_GET['uczen_id'];


         $response = $this->view;
      }
      else
      {
         $response = 'Uczen nie istnieje.';
      }
      $this->layout->content = $response;
      return $this->layout;
    }


    /**
     * Zwraca formularz zawierający znane informacje o nauczycielu: dane osobowe, uprawnienia, prowadzone zajęcia.
     * Parametr nauczyciel_id podawany poprzez tablicę $_GET.
     * @return string
     */
    function infoNauczyciel()
    {
      if(!$this->register->adminPrivilege()) return $this->badAccess('admin');

      $obj = array();
      $obj['nauczyciel_id'] = $_GET['nauczyciel_id'] ;
      

      $this->layout->header = 'Informacje o nauczycielu' ;


      $response = $this->model->infoNauczyciel((object)$obj) ;



      if($response != null)
      {
         $this->view = new View('info_nauczyciel');

         //podsumowanie uprawnien
         $this->view->data = $this->model->listPrzypisanie((object)$obj);

         //podsumowanie obecności
         $this->view->data2 = $this->model->listGrupyNauczyciela((object)$obj);

         $this->view->data3 = $this->model->listKlasyNauczyciela((object)$obj);


         $this->view->imie = $response[0]['imie'];
         $this->view->nazwisko = $response[0]['nazwisko'];
         $this->view->pesel = $response[0]['pesel'];
         $this->view->nauczyciel_id = $_GET['nauczyciel_id'];


         $response = $this->view;
      }
      else
      {
         $response = 'Nauczyciel nie istnieje.';
      }
      $this->layout->content = $response;
      return $this->layout;
    }



    function infoKlasa($param)
    {
      $this->layout->header = 'Informacje o klasie' ;
      if(!$this->register->adminPrivilege()) return $this->badAccess('admin');

      $response1 = pg_fetch_all(pg_query_params(
         $this->model->get_dbconn(),
         'SELECT imie, nazwisko from nauczyciel join klasa on nauczyciel_id = wychowawca_id where klasa.id = $1',
         $param
      )
      );

      $response2 = pg_fetch_all(pg_query_params(
         $this->model->get_dbconn(),
         'SELECT * from klasa where klasa.id = $1',
         $param
      )
      );



      $response = $this->model->searchClass((object)$param);
      if($response != null && $response1 != null)
      {
         
         $this->view = new View('info_klasa');
         $this->view->data = $response;
         $this->view->imie = $response1[0]['imie'];
         $this->view->nazwisko = $response1[0]['nazwisko'];
         $this->view->sala = $response2[0]['sala'];

         $response = $this->view;
      }
      $this->layout->content = $response;
      return $this->layout;
    }












   /**
    * Zwraca formularz listujący wszystkich uczniów zapisanych na dane zajęcia.
    * @param param tablica zawierająca wartości dla kluczy: zajecia_id, dla którego zostaną wyszukani uczniowie
    * @return string
    */
    function listGrupa($param)
    {
      if(!$this->register->nauczycielPrivilege()) return $this->badAccess(null);

      if ($param != null)
      {
         {
            $response = $this->model->listGrupa((object) $param) ;
         }
      }
      if($response != null)
      {
         $layout = new View('list_uczen(grupa, nauczyciel)');
         $layout->data = $response;
         $response = $layout;
         $this->layout->header = 'Osoby w grupie';
      //$this->view = new View('form_search');
         $this->layout->content = $response; //$this->view;

      return $this->layout;
      }

      


      return "Nieprawidłowy URL.";
    }










    /**
    * Zwraca formularz listujący wszystkie grupy zajęciowe nauczyciela.
    * @param param tablica zawierająca wartości dla kluczy: nauczyciel_id, dla którego zostaną wyszukane grupy zajęciowe.
    * @return string
    */
    function listGrupyNauczyciela($param)
    {
      if(!$this->register->nauczycielPrivilege()) return $this->badAccess(null);

      if ($param != null)
      {
         {  
            $response = $this->model->listGrupyNauczyciela((object) $param) ;
         }
      }
      if($response != null)
      {
         $layout = new View('list_grupy(nauczyciel)');
         $layout->data = $response;
         $response = $layout;
      }
      else
      {
         $response = 'Brak grup zajeciowych';
      }



      $this->layout->header = 'Grupy zajeciowe nauczyciela '.$param['nauczyciel_id'];
      //$this->view = new View('form_search');
      $this->layout->content = $response; //$this->view;

      return $this->layout;


      //return $response;


    }





   /**
    * Zwraca formularz listujący wszystkie grupy zajęciowe nauczyciela rozbudowane o dodatkowe opcje modyfikacji grup (możliwość usuwania grup).
    * @param param tablica zawierająca wartości dla kluczy: nauczyciel_id, dla którego zostaną wyszukane grupy zajęciowe.
    * @return string strona w formacie HTML
    */
    function zarzadzajGrupyNauczyciela($param)
    {
      if(!$this->register->adminPrivilege()) return $this->badAccess('admin');
      //$obj = $_GET['param'] ;
      //
      if ($param != null)
      {
         {  
            $response = $this->model->listGrupyNauczyciela((object) $param) ;
         }
      }
      if($response != null)
      {
         $layout = new View('list_grupy(nauczyciel)');
         $layout->data = $response;
         $layout->manage = 'manage';
         $response = $layout;
      }
      else
      {
         $response = 'Brak grup zajeciowych';
      }
      $this->layout->header = 'Grupy zajeciowe nauczyciela '.$param['nauczyciel_id'];
      //$this->view = new View('form_search');
      $this->layout->content = $response; //$this->view;

      return $this->layout;
    }



    /**
    * Zwraca formularz listujący wszystkich uczniów zapisanych na dane zajęcia, z dodatkowymi możliwościami zarządzania (usuwanie zapisów uczniów).
    * @param param tablica zawierająca wartości dla kluczy: zajecia_id, dla którego zostaną wyszukani uczniowie
    * @return string strona w formacie HTML
    */
    function zarzadzajGrupa($param)
    {
      if(!$this->register->adminPrivilege()) return $this->badAccess('admin');

      if ($param != null)
      {
         {
            $response = $this->model->listGrupa((object) $param) ;
         }
      }
      if($response != null)
      {
         $layout = new View('list_uczen(grupa, nauczyciel)');
         $layout->data = $response;
         $layout->manage = "manage";
         $response = $layout;
         $this->layout->header = 'Osoby w grupie';
      //$this->view = new View('form_search');
         $this->layout->content = $response; //$this->view;

      return $this->layout;
      }

      


      return "Nieprawidlowy URL.";
    }




    /**
     * Funkcja usuwająca zapis.
     * uczen_id i zajecia_id (wraz z innymi parametrami filtrującymi) podawane poprzez tablicę $_POST żądania.
     * @return string informacja zwrotna o powodzeniu procesu
     */
    function direct_deleteZapis()
    {
      if(!$this->register->adminPrivilege()) return "Błąd uprawnień";

      $data = $_POST['data'] ;
      $obj  = json_decode($data) ;
      $response = null;
      if (isset($obj->uczen_id) && isset($obj->zajecia_id))
      {
         {     
            $response = $this->model->deleteZapis($obj) ;
         }
      }
      return $response === true ? "Usunięto" : "Błąd. ";
    }


   /**
     * Funkcja usuwająca zajęcia.
     * zajecia_id (wraz z innymi parametrami filtrującymi) podawane poprzez tablicę $_POST żądania.
     * @return strings informacja zwrotna o powodzeniu procesu
     */
    function direct_deleteZajecia()
    {
      if(!$this->register->adminPrivilege()) return "Błąd uprawnień";

      $data = $_POST['data'] ;
      $obj  = json_decode($data) ;
      $response = null;
      if (isset($obj->zajecia_id))
      {
         {     
            $response = $this->model->universalDelete($obj,'zajecia') ;
         }
      }
      return $response === true ? "Usunięto" : "Błąd. Zajęcia nadal mogą się odbywać. ";
    }



    /**
     * Funkcja zwraca wylosowaną osobę spośród osób obecnych danego dnia.
     * zajecia_id, data podawane poprzez tablicęę $_POST żądania.
     * @return string wynik wyszukiwania w formacie HTML
     * Zwraca tablicę o kolumnach: uczen
     */
    function direct_randZapis()
    {
      if(!$this->register->adminPrivilege()) return "Błąd uprawnień";

      $data = $_POST['data'] ;
      $obj  = json_decode($data) ;
      $response = null;
      if (isset($obj->zajecia_id) && isset($obj->data))
      {
         {     
            $response = $this->model->randZapis($obj) ;
         }
      }
      return $response ? $response : "Blad ";
    }


    /**
     * Zwraca formularz dla opcji "Utwórz" z Menu.
     * @return string strona w formacie HTML
     */
    function utworz()
    {
      if(!$this->register->adminPrivilege()) return $this->badAccess('admin');

      $this->layout->header = 'Dodawanie elementów do bazy';
      $this->view = new View('utworz');
      $this->view->css = $this->css ;
      $this->layout->content = $this->view;
      return $this->layout;
    }

    
    /**
     * Zwraca formularz dla opcji "Szukaj" z Menu.
     * @return string strona w formacie HTML
     */
    function wyswietl()
    {
      if(!$this->register->adminPrivilege()) return $this->badAccess('admin');

      $this->layout->header = 'Przeglądanie danych w bazie';
      $this->view = new View('wyswietl');
      $this->view->css = $this->css ;
      $this->layout->content = $this->view;
      return $this->layout;
    }

    /**
     * Zwraca formularz dla opcji "Algorytmy" z Menu.
     * @return string strona w formacie HTML
     */
    function zarzadzaj()
    {
      if(!$this->register->adminPrivilege()) return $this->badAccess('admin');

      $this->layout->header = 'Zarządzaj bazą';
      $this->view = new View('zarzadzaj');
      $this->view->css = $this->css ;
      $this->layout->content = $this->view;
      return $this->layout;
    }







  /**
   * Funkcja dodająca rekord do tabeli nauczyciel.
   * Parametry: imie, nazwisko, pesel podawane przez tablicę $_POST.
   * @return string informacja zwrotna o powodzeniu procesu
   */
    function saveNauczyciel() {
      if(!$this->register->adminPrivilege()) return "Błąd uprawnień";

       $data = $_POST['data'] ;
       $obj  = json_decode($data) ;
       if ( isset($obj->imie) and isset($obj->nazwisko) and isset($obj->pesel)  ) {   
          $response = $this->model->saveNauczyciel($obj) ;
       }
       return ( $response ? "Dodano rekord" : "Błąd. " ) ;
    }

   /**
   * Funkcja dodająca rekord do tabeli uczen.
   * Parametry: imie, nazwisko, pesel, id (klasa_id) podawane przez tablicę $_POST.
   * @return string informacja zwrotna o powodzeniu procesu
   */
    function saveUczen() {
      if(!$this->register->adminPrivilege()) return "Błąd uprawnień";

      $data = $_POST['data'] ;
      $obj  = json_decode($data) ;
      if ( isset($obj->imie) and isset($obj->nazwisko) and isset($obj->pesel) and isset($obj->id)  ) {   
         $response = $this->model->saveUczen($obj) ;
      }
      return ( $response ? "Dodano rekord" : "Błąd. " ) ;
   }

   /**
   * Funkcja dodająca rekord do tabeli przedmiot.
   * Parametry: nazwa podawane przez tablicę $_POST.
   * @return string informacja zwrotna o powodzeniu procesu
   */
   function savePrzedmiot() {
      if(!$this->register->adminPrivilege()) return "Błąd uprawnień";

      $data = $_POST['data'] ;
      $obj  = json_decode($data) ;
      if ( isset($obj->nazwa)  ) {     
         $response = $this->model->savePrzedmiot($obj) ;
      }
      return ( $response ? "Dodano rekord" : "Błąd. " ) ;
   }

   /**
   * Funkcja dodająca rekord do tabeli zapis.
   * Parametry: uczen_id, zajecia_id podawane przez tablicę $_POST.
   * @return string informacja zwrotna o powodzeniu procesu
   */
   function saveZapis() {
      if(!$this->register->adminPrivilege()) return "Błąd uprawnień";

      $data = $_POST['data'] ;
      $obj  = json_decode($data) ;
      if ( isset($obj->uczen_id) && isset($obj->zajecia_id)) {   
         $response = $this->model->saveZapis($obj) ;
      }
      return ( $response ? "Dodano rekord" : "Błąd. Uczeń może już być przypisany.") ;
   }

   /**
   * Funkcja dodająca rekord do tabeli klasa.
   * Parametry: wychowawca_id, id (klasa_id), sele podawane przez tablicę $_POST.
   * @return string informacja zwrotna o powodzeniu procesu
   */
   function saveKlasa() {
      if(!$this->register->adminPrivilege()) return "Błąd uprawnień";

      $data = $_POST['data'] ;
      $obj  = json_decode($data) ;
      if ( isset($obj->wychowawca_id) and isset($obj->id) and isset($obj->sala)  ) {
         $response = $this->model->saveKlasa($obj) ;
      }
      return ( $response ? "Dodano rekord" : "Błąd " ) ;
   }

   /**
   * Funkcja dodająca rekord do tabeli przypisanie.
   * Parametry: nauczyciel_id, przedmiot_id podawane przez tablicę $_POST.
   * @return string informacja zwrotna o powodzeniu procesu
   */
   function savePrzypisanie() {
      if(!$this->register->adminPrivilege()) return "Błąd uprawnień";

      $data = $_POST['data'] ;
      $obj  = json_decode($data) ;
      if ( isset($obj->nauczyciel_id) && isset($obj->przedmiot_id)) {
         $response = $this->model->savePrzypisanie($obj) ;
      }
      return ( $response ? "Dodano rekord" : "Błąd. Rekord może już istnieć. " ) ;
   }

   /**
   * Funkcja dodająca rekord do tabeli zajecia.
   * Parametry: przypisanie_id, dzien_rozp, dzien_zak podawane przez tablicę $_POST.
   * Parametry daty podawane w formacie: DD-MM-YYYY 
   * @return string informacja zwrotna o powodzeniu procesu
   */
   function saveZajecia() {
      if(!$this->register->adminPrivilege()) return "Błąd uprawnień";

      $data = $_POST['data'] ;
      $obj  = json_decode($data) ;
      if ( isset($obj->przypisanie_id) && isset($obj->dzien_rozp) && isset($obj->dzien_zak)) {  
         $response = $this->model->saveZajecia($obj) ;
      }
      return ( $response ? "Dodano rekord" : "Błąd. " ) ;
   }

   /**
   * Funkcja dodająca rekord do tabeli ocena.
   * Parametry: zajecia_id, uczen_id, wartosc, waga, data podawane przez tablicę $_POST.
   * @return string informacja zwrotna o powodzeniu procesu
   */
    function saveOcena() {
      if(!$this->register->nauczycielPrivilege()) return "Błąd uprawnień";

      $data = $_POST['data'] ;
      $obj  = json_decode($data) ;
      $response = null;
      if ( isset($obj->zajecia_id) and isset($obj->uczen_id) and isset($obj->wartosc) and isset($obj->waga) and isset($obj->data)) {
           
           
           //echo $obj->zajecia_id." ".$obj->uczen_id." ".$obj->data;
         $response = $this->model->saveOcena($obj) ;
      }
      return ( $response ? "Dodano rekord" : "Błąd. " ) ;
   }

   /**
   * Funkcja dodająca rekord do tabeli obecnosc.
   * Parametry: zajecia_id, uczen_id, typ, data podawane przez tablicę $_POST.
   * @return string informacja zwrotna o powodzeniu procesu
   */
   function saveObecnosc() {
      if(!$this->register->nauczycielPrivilege()) return "Błąd uprawnień";

      $data = $_POST['data'] ;
      $obj  = json_decode($data) ;
      $response = null;
      if ( isset($obj->zajecia_id) and isset($obj->uczen_id) and isset($obj->typ) and isset($obj->data)) {
           
           //echo $obj->zajecia_id." ".$obj->uczen_id." ".$obj->data;
         $response = $this->model->saveObecnosc($obj) ;
      }
      return ( $response ? "Dodano rekord" : "Błąd. Wpis może już istnieć") ;
   }






  
    function info ( $text ) {
       $this->layout->content = $text ;
       return $this->layout ; 
    }
  

    
  
  
    function index ()  {
       return $this->layout ; 
    }
  

    /**
     * Funkcja dokonuje zapisu wszystkich uczniów z danej klasy na wybrane zajęcia.
     * Parametry: zajecia_id, klasa_id podawane przez tablicę $_POST.
     * @return string informacja zwrotna o powodzeniu procesu
     */
    function algorytmZapisKlasy()
    {
      if(!$this->register->adminPrivilege()) return "Błąd uprawnień";

      $data = $_POST['data'] ;
      $obj  = json_decode($data) ;
      $response = null;
      if ( isset($obj->zajecia_id) and isset($obj->klasa_id)) 
      {
         pg_prepare($this->model->get_dbconn(),'alg_zapisKlasy','SELECT zapisz_klase($1,$2)');
         $response = pg_execute($this->model->get_dbconn(),'alg_zapisKlasy',array($obj->klasa_id,$obj->zajecia_id));
      }
      return $response ? 'Wykonano polecenie' : 'Błąd. Któryś z wpisów może się powtarzać. ';
    }



    /**
     * Funkcja zwraca formularz zawierający informacje o uczniach z paskiem.
     * @return string formularz w formacie HTML
     */
    function algorytm_paski()
    {
      if(!$this->register->nauczycielPrivilege()) return "Błąd uprawnień";

      $response = new View('listelem');
      $response->data = pg_fetch_all(
         pg_query($this->model->get_dbconn(),"SELECT uczen_id, imie, nazwisko, srednia from pasek join uczen using(uczen_id)")
      );

      $this->layout->content = $response;
      $this->layout->header = 'Uczniowie z paskiem';
      return $this->layout;
    }


    /**
     * Funkcja zwraca formularz zawierający podsumowanie zajec dla kazdego ucznia
     * @return string formularz w formacie HTML
     */
    function algorytm_zajecia_podsumowanie()
    {
      if(!$this->register->nauczycielPrivilege()) return "Błąd uprawnień";

      $response = new View('listelem');
      $response->data = pg_fetch_all(
         pg_query($this->model->get_dbconn(),"SELECT * from zajecia_podsumowanie")
      );

      $this->layout->content = $response;
      $this->layout->header = 'Podsumowanie';
      return $this->layout;
    }




    function algorytm_rok_podsumowanie()
    {
      if(!$this->register->nauczycielPrivilege()) return "Błąd uprawnień";

      $response = new View('listelem');
      $response->data = pg_fetch_all(
         pg_query($this->model->get_dbconn(),"select imie || ' ' || nazwisko as uczen, avg(srednia) as srednia_koncowa from przedmiot_srednia join uczen using(uczen_id) group by uczen order by uczen         ")
      );

      $this->layout->content = $response;
      $this->layout->header = 'Podsumowanie roku';
      return $this->layout;
    }
    



    /**
     * Zwraca formularz dla opcji "Algorytmy" z Menu.
     * @return string strona w formacie HTML
     */
    function struktura()
    {
      if(!$this->register->adminPrivilege()) return $this->badAccess('admin');

      $this->layout->header = 'Modyfikuj strukturę';
      $this->view = new View('struktura');
      $this->view->css = $this->css ;
      $this->layout->content = $this->view;
      return $this->layout;
    }




    function resetStruktura()
    {
      if(!$this->register->adminPrivilege()) return "Błąd uprawnień";


      $lines = explode(PHP_EOL, file_get_contents("sql/clean.sql"));
      foreach($lines as $line)
      {
         pg_query($this->model->get_dbconn(),$line);
      }

      $task = file_get_contents("sql/baza.sql");
      return pg_fetch_all(pg_query($this->model->get_dbconn(),$task)) ? 'OK' : "Błąd"  ;

    }

    function fillPrzyklad()
    {
      if(!$this->register->adminPrivilege()) return "Błąd uprawnień";

      $task = file_get_contents("sql/przyklad.sql");
      return pg_fetch_all(pg_query($this->model->get_dbconn(),$task)) ? 'OK' : "Błąd";
    }



} 
  
?>
