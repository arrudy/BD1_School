<?php
  
namespace baza ;
use PDO ;
  
class Model 
{  
   //static $dsn = 'sqlite:sql/baza.db'  ;
   //protected static $db ;
   //private $sth ;
   private $dbconn;
  
   function __construct()
   {
      /*
     $data = explode(':',self::$dsn) ;
     if ( ! file_exists ( $data[1] ) ) { throw new \Exception ( "Database file doesn't exist." ) ;  }
     self::$db = new PDO ( self::$dsn ) ;
     self::$db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION) ; */

     //integration
    $this->dbconn = pg_connect("host=localhost dbname=yourdbname user=youruser password=yourpasswd")
    
     or die('Could not connect: ' . pg_last_error());
   }
  
  /**
   * Funkcja zwracająca wszystkie rekordy z tabeli nauczyciel.
   * @return array
   * Zwracane kolumny: *
   */
   public function listNauczyciel()
   {

     $result = pg_fetch_all(pg_query($this->dbconn,'SELECT * FROM nauczyciel'),PGSQL_ASSOC);

     return $result ; //array of arrays of data
   }

   /**
   * Funkcja zwracająca wszystkie rekordy z tabeli przedmiot.
   * @return array
   * Zwracane kolumny: przedmiot_id, przedmiot.nazwa as przedmiot
   */
   public function listPrzedmiot()
   {

     $result = pg_fetch_all(pg_query($this->dbconn,'SELECT przedmiot_id, nazwa as przedmiot FROM przedmiot'),PGSQL_ASSOC);

     return $result ; //array of arrays of data
   }

   /**
   * Funkcja zwracająca wszystkie rekordy z tabeli klasa.
   * @return array
   * Zwracane kolumny: *
   */
   public function listKlasa()
   {

     $result = pg_fetch_all(pg_query($this->dbconn,'SELECT * FROM klasa'),PGSQL_ASSOC);

     return $result ; //array of arrays of data
   }


   /**
    * Zwraca zestawienie zajecia_id - przedmiot - nauczyciel - nauczyciel_id
    * @return array
    */
   public function listZajecia()
   {

     $result = pg_fetch_all(pg_query($this->dbconn,"SELECT zajecia_id, przedmiot.nazwa as przedmiot, imie || ' ' || nazwisko as nauczyciel, nauczyciel_id FROM zajecia join przypisanie using(przypisanie_id) join przedmiot using(przedmiot_id) join nauczyciel using(nauczyciel_id)"),PGSQL_ASSOC);

     return $result ; //array of arrays of data
   }


   /**
   * Funkcja zwracająca rekord z tabeli uczen o zadanym uczen_id.
   * @param obj Objekt z ustalonym polem uczen_id
   * @return array
   * Zwracane kolumny: *
   */
   public function infoUczen($obj)
   {
      $result = pg_fetch_all(
         pg_query_params(
            $this->dbconn,
            'SELECT * FROM uczen WHERE uczen.uczen_id=$1', 
            array($obj->uczen_id)
         )
      );
     return $result ; //array of arrays of data

   }



   /**
   * Funkcja zwracająca rekord z tabeli nauczyciel o zadanym nauczyciel_id.
   * @param obj Objekt z ustalonym polem nauczyciel_id
   * @return array
   * Zwracane kolumny: *
   */
  public function infoNauczyciel($obj)
  {
     $result = pg_fetch_all(
        pg_query_params(
           $this->dbconn,
           'SELECT * FROM nauczyciel WHERE nauczyciel.nauczyciel_id=$1', 
           array($obj->nauczyciel_id)
        )
     );
    return $result ; //array of arrays of data

  }



/**
 * Szuka uczniow danej klasy
 * @param obj Obiekt z ustalonym polem class
 * @return array
 */
   public function searchClass($obj)
   {
      /*
      $this->sth = self::$db->prepare('SELECT uczen_id, klasa.nazwa as klasa ,imie, nazwisko FROM uczen join klasa using(klasa_id) WHERE klasa.nazwa=:klasa') ;
      $this->sth->bindValue(':klasa',$obj->class,PDO::PARAM_STR) ; 
      $this->sth->execute() ;
      $result = $this->sth->fetchAll() ;*/

      $result = pg_fetch_all(
         pg_query_params(
            $this->dbconn,
            'SELECT uczen_id, klasa.id as klasa ,imie, nazwisko FROM uczen join klasa using(klasa_id) WHERE klasa.id=$1', 
            array($obj->class)
         )
      );
     return $result ; //array of arrays of data
   }


   /**
    * Szuka zajęć powiązanych z danym przedmiotem (przedmiot_id)
    * @param obj Obiekt z ustalonym polem przedmiot_id
    */
   public function searchZajecia_przedmiot($obj)
   {
      $result = pg_fetch_all(
         pg_query_params(
            $this->dbconn,
            "SELECT imie || ' ' || nazwisko as nauczyciel, dzien_rozp, zajecia_id FROM zajecia join przypisanie using(przypisanie_id) join nauczyciel using(nauczyciel_id) WHERE przedmiot_id=$1", 
            array($obj->przedmiot_id)
         )
      );
     return $result ; //array of arrays of data
   }

   /**
    * Szuka wszystkich nauczycieli powiązanych z danym przedmiotem
    * @param obj Obiekt z polem przedmiot_id
    * @return array
    */
   public function searchPrzypisanie_przedmiot($obj)
   {
      $result = pg_fetch_all(
         pg_query_params(
            $this->dbconn,
            "SELECT imie || ' ' || nazwisko as nauczyciel, przypisanie_id FROM przypisanie join nauczyciel using(nauczyciel_id) WHERE przedmiot_id=$1", 
            array($obj->przedmiot_id)
         )
      );
     return $result ;
   }



   /**
   * Szuka nauczycieli dla $obj danych
   * @param obj Obiekt z polami: nauczyciel_id, PESEL
   * @return array
   */
   public function szukajLogin($obj)
   {

      $result = pg_fetch_all(
         pg_query_params(
            $this->dbconn,
            'SELECT * FROM nauczyciel WHERE nauczyciel.nauczyciel_id=$1 and nauczyciel.pesel = $2', 
            array($obj->nauczyciel_id, $obj->PESEL)
         )
      );

     return $result ; 
   }

/**
   * Zwraca imię, nazwisko, id nauczyciela o podanym id
   * @param obj Obiekt z polem id
   * @return array
   */
   public function szukajNauczyciel(int $id)
   {

      $result = pg_fetch_all(
         pg_query_params(
            $this->dbconn,
            'SELECT nauczyciel_id, imie, nazwisko FROM nauczyciel WHERE nauczyciel.nauczyciel_id=$1', 
            array($id)
         )
      );

     return $result ; 
   }

   /**
    * Wykorzystywane do dodawania ocen. Zwraca ucznia dla danego id.
    * @param id uczen_id szukanego ucznia
    * @return array
    */
   public function szukajUczen(int $id)
   {

      $result = pg_fetch_all(
         pg_query_params(
            $this->dbconn,
            'SELECT uczen_id, imie, nazwisko, klasa_id FROM uczen WHERE uczen.uczen_id=$1', 
            array($id)
         )
      );

     return $result ; 
   }

   /**
   * Wyszukuje ucznia po imieniu / nazwisku/ imieniu i nazwisku
   * @param obj Obiekt z polem uczen. Dla null zwraca wszystkich nauczycieli
   * @return array
   */
   public function searchUczen($obj)
   {
      $result = null;
      if(!isset($obj->uczen))
         $result = pg_fetch_all(
            pg_query(
               $this->dbconn,
               "SELECT uczen_id, imie, nazwisko, klasa.id as klasa from uczen join klasa using(klasa_id)"
               
            ),
            PGSQL_ASSOC
         );
      else 
         $result = pg_fetch_all(
            pg_query_params(
               $this->dbconn,
               "SELECT uczen_id, imie, nazwisko, klasa.id as klasa from ((select uczen_id from uczen where imie like $1) union (select uczen_id from uczen where nazwisko like $1)) as ids join uczen using(uczen_id) join klasa using(klasa_id)", 
               array($obj->uczen. "%")
            )
         );

     return $result ; 
   }

   /**
   * Wyszukuje nauczyciela po imieniu / nazwisku/ imieniu i nazwisku
   * @param obj Obiekt z polem nauczyciel. Dla null zwraca wszystkich nauczycieli.
   * @return array
   */
   public function searchNauczyciel($obj)
   {
      $result = null;
      if(!isset($obj->nauczyciel))
         $result = pg_fetch_all(
            pg_query(
               $this->dbconn,
               "SELECT nauczyciel_id, imie, nazwisko from nauczyciel"
               
            ),
            PGSQL_ASSOC
         );
      else 
         $result = pg_fetch_all(
            pg_query_params(
               $this->dbconn,
               "SELECT nauczyciel_id, imie, nazwisko from ((select nauczyciel_id from nauczyciel where imie like $1) union (select nauczyciel_id from nauczyciel where nazwisko like $1)) as ids join nauczyciel using(nauczyciel_id)", 
               array($obj->nauczyciel. "%")
            )
         );

     return $result ; //array of arrays of data
   }

   /**
   * Wyszukuje klasę po identyfikatorze
   * @param obj Obiekt z polem klasa. Dla null zwraca wszystkie klasy.
   * @return array
   */
   public function searchKlasa($obj)
   {
      $result = null;
      if(!isset($obj->klasa))
         $result = pg_fetch_all(
            pg_query(
               $this->dbconn,
               "SELECT klasa_id, id as klasa from klasa"
               
            ),
            PGSQL_ASSOC
         );
      else 
         $result = pg_fetch_all(
            pg_query_params(
               $this->dbconn,
               "SELECT klasa_id, id as klasa from klasa as k where id like $1", 
               array($obj->klasa. "%")
            )
         );

     return $result ; //array of arrays of data
   }




   /**
   * Wyszukuje przedmiot po nazwie.
   * @param obj Obiekt z polem przedmiot. Dla null zwraca wszystkie przedmioty.
   * @return array
   */
   public function searchPrzedmiot($obj)
   {
      $result = null;
      if(!isset($obj->przedmiot))
         $result = pg_fetch_all(
            pg_query(
               $this->dbconn,
               "SELECT przedmiot_id, nazwa as przedmiot from przedmiot p"
            ),
            PGSQL_ASSOC
         );
      else 
         $result = pg_fetch_all(
            pg_query_params(
               $this->dbconn,
               "SELECT przedmiot_id, nazwa as przedmiot from przedmiot as p where nazwa like $1", 
               array($obj->przedmiot. "%")
            )
         );

     return $result ; //array of arrays of data
   }



   /**
   * Wyszukuje zajęcia po identyfikatorze
   * @param id Identyfikator zajęć
   * @return array
   */
   public function szukajZajecia(int $id) 
   {
      /*
      $this->sth = self::$db->prepare('SELECT * FROM zajecia WHERE zajecia.zajecia_id = :zajecia_id') ;
      $this->sth->bindValue(':zajecia_id',$id,PDO::PARAM_STR) ; 
      $this->sth->execute() ;
      $result = $this->sth->fetchAll() ;*/

      $result = pg_fetch_all(
         pg_query_params(
            $this->dbconn,
            'SELECT * FROM zajecia WHERE zajecia.zajecia_id = $1', 
            array($id)
         )
      );

     return $result ; //array of arrays of data
   }






   /**
   * Wyszukuje oceny dla danych zajęć i danego ucznia. Dokonuje podstawowego formatowania.
   * @param obj Obiekt z polami: zajecia_id, uczen_id. 
   * @return array
   */
   public function listOcena($obj)
   {

      $result = pg_fetch_all(
         pg_query_params(
            $this->dbconn,
            'SELECT ocena_id, wartosc, waga, data, komentarz from ocena join id_asocjacja using(zapis_id) where uczen_id=$2 and 
            przedmiot_id = (select przedmiot_id from zajecia join przypisanie using(przypisanie_id) where zajecia_id = $1)', 
            array($obj->zajecia_id, $obj->uczen_id)
         )
      );

      if($result)
      {
      foreach($result as $key => &$row)
      {
         if($row['wartosc'] == 0.5)
         {
            $row['wartosc'] = '+';
         }
         if($row['wartosc'] == -0.5)
         {
            $row['wartosc'] = '-';
         }
      }
      }

     return ($result != null ? $result : null ); //array of arrays of data
   }



   /**
   * Wyszukuje obecności dla danych zajęć i danego ucznia.
   * @param obj Obiekt z polami: zajecia_id, uczen_id. 
   * @return array
   */
   public function listObecnosc($obj)
   {

      $result = pg_fetch_all(
         pg_query_params(
            $this->dbconn,
            'SELECT obecnosc_id, typ, data from obecnosc join id_asocjacja using(zapis_id) where uczen_id=$2 and zajecia_id =$1', 
            array($obj->zajecia_id, $obj->uczen_id)
         )
      );

     return ($result != null ? $result : null ); //array of arrays of data
   }




   /**
    * Zwraca wszystkich uczniow w ramach grupy.
    * @param obj Obiekt z polem zajecia_id
    * @return array
    */
   public function listGrupa($obj)
   {

      $result = pg_fetch_all(
         pg_query_params(
            $this->dbconn,
            'SELECT uczen_id ,imie, nazwisko from uczen join zapis using(uczen_id) join zajecia using(zajecia_id) where zajecia_id = $1', 
            array($obj->zajecia_id)
         )
      );

     return ($result != null ? $result : null ); //array of arrays of data
   }

/**
    * Zwraca wszystkie przypisania nauczyciela o podanym id
    * @param obj Obiekt z polem nauczyciel_id
    * @return array
    */
public function listPrzypisanie($obj)
{

   $result = pg_fetch_all(
      pg_query_params(
         $this->dbconn,
         'SELECT przypisanie_id, przedmiot_id, przedmiot.nazwa as przedmiot from przypisanie join przedmiot using(przedmiot_id) where nauczyciel_id = $1', 
         array($obj->nauczyciel_id)
      )
   );

  return ($result != null ? $result : null ); //array of arrays of data
}





/**
    * Zwraca wszystkie grupy zajęciowe nauczyciela dla podanego id
    * @param obj Obiekt z polem nauczyciel_id
    * @return array
    */
   public function listGrupyNauczyciela($obj)
   {
      /*
      $this->sth = self::$db->prepare('SELECT zajecia_id, nauczyciel_id ,nazwa from zajecia where nauczyciel_id = :nauczyciel_id') ;
      $this->sth->bindValue(':nauczyciel_id',$obj->nauczyciel_id,PDO::PARAM_STR) ; 
      $this->sth->execute() ;
      $result = $this->sth->fetchAll(PDO::FETCH_ASSOC) ;*/

      $result = pg_fetch_all(
         pg_query_params(
            $this->dbconn,
            "SELECT zajecia_id, nauczyciel_id ,przedmiot.nazwa as przedmiot, dzien_rozp, dzien_zak, extract( ISODOW FROM dzien_rozp) as dzien_tyg from przedmiot join przypisanie using(przedmiot_id) join zajecia using(przypisanie_id) where nauczyciel_id = $1", 
            array($obj->nauczyciel_id)
         )
      );


     return ($result != null ? $result : null ); //array of arrays of data
   }



   /**
    * Zwraca wszystkie klasy nauczyciela, których jest wychowawcą, dla podanego id
    * @param obj Obiekt z polem nauczyciel_id
    * @return array
    */
    public function listKlasyNauczyciela($obj)
    {
       /*
       $this->sth = self::$db->prepare('SELECT zajecia_id, nauczyciel_id ,nazwa from zajecia where nauczyciel_id = :nauczyciel_id') ;
       $this->sth->bindValue(':nauczyciel_id',$obj->nauczyciel_id,PDO::PARAM_STR) ; 
       $this->sth->execute() ;
       $result = $this->sth->fetchAll(PDO::FETCH_ASSOC) ;*/
 
       $result = pg_fetch_all(
          pg_query_params(
             $this->dbconn,
             "SELECT klasa_id, id as klasa  from klasa where wychowawca_id = $1", 
             array($obj->nauczyciel_id)
          )
       );
 
 
      return ($result != null ? $result : null ); //array of arrays of data
    }
  

/**
    * Zwraca losową osobę spośród obecnych na danych zajęciach
    * @param obj Obiekt z polem zajecia_id, data
    * @return array
    */
   public function randZapis($obj)
{

   $result = pg_fetch_all(
      pg_query_params(
         $this->dbconn,
         "SELECT uczen_id || ' ' || imie || ' ' || nazwisko as uczen from uczen join obecnosc_rng using(uczen_id) where typ = 'ob' and zajecia_id = $1 and data = $2 LIMIT 1",
         array($obj->zajecia_id, $obj->data)
      )
   );

  return ($result != null ? $result[0]['uczen'] : null ); //array of arrays of data
}


   public function saveNauczyciel($obj)
   {
      return pg_insert($this->dbconn,"nauczyciel",(array)$obj);
   }

   public function saveKlasa($obj)
   {
      return pg_insert($this->dbconn,"klasa",(array)$obj);
   }

   public function savePrzedmiot($obj)
   {
      return pg_insert($this->dbconn,"przedmiot",(array)$obj);
   }

   public function saveZapis($obj)
   {
      return pg_insert($this->dbconn,"zapis",(array)$obj);
   }

   public function savePrzypisanie($obj)
   {
      return pg_insert($this->dbconn,"przypisanie",(array)$obj);
   }

   public function saveZajecia($obj)
   {
      return pg_insert($this->dbconn,"zajecia",(array)$obj);
   }





   

   public function deletePrzypisanie($obj)
   {
      return pg_delete($this->dbconn,"przypisanie",(array)$obj);
   }
   
   
   

/**
    * Realizuje operację DELETE dla dowolnych rekordów
    * @param obj Obiekt z polami filtrującymi
    * @return array
    */
   public function universalDelete($obj, $table)
   {
      return pg_delete($this->dbconn, ''. $table, (array)$obj);
   }



/**
 * Zwraca zmienną połączenia.
 */
   public function get_dbconn()
   {
      return $this->dbconn;
   }


/**
    * Zapisuje ucznia dla podanych parametrów
    * @param obj Obiekt z danymi ucznia
    * @return array
    */
   public function saveUczen($obj)
   {

      $query = pg_fetch_all(
         pg_query_params(
            $this->dbconn,
            'SELECT klasa_id from klasa where id = $1', 
            array($obj->id)
         )
      );

      $obj = (array) $obj;
      unset($obj['id']);
      $obj['klasa_id'] = $query[0]['klasa_id'];

      return pg_insert($this->dbconn,"uczen",$obj);


   }


   /**
    * Zapisuje ocenę dla danych parametrów
    * @param obj Obiekt z danymi oceny
    * @return array
    */
   public function saveOcena($obj)
   {
      /*
      $zapis_id = pg_fetch_all(
         pg_query_params(
            $this->dbconn,
            'SELECT zapis_id from id_asocjacja where uczen_id = $1 and zajecia_id = $2 LIMIT 1', 
            array($obj->uczen_id, $obj->zajecia_id)
         ))[0]['zapis_id'];*/

         $zapis_id = pg_fetch_all(
            pg_query_params(
               $this->dbconn,
               'SELECT get_zapis as zapis_id from get_zapis($1,$2) LIMIT 1', 
               array($obj->uczen_id, $obj->zajecia_id)
            ))[0]['zapis_id'];


      $obj = (array) $obj;

         unset($obj['uczen_id']);
         unset($obj['zajecia_id']);
         $obj['zapis_id'] = $zapis_id;

      return pg_insert($this->dbconn,"ocena",$obj);
   }




/**
    * Zapisuje obecność dla danych parametrów
    * @param obj Obiekt z danymi obecności
    * @return array
    */
   public function saveObecnosc($obj)
   {
      

      //var_dump((array) $obj  );

      //$array = pg_convert($this->dbconn, 'ocena', $array);


      $zapis_id = pg_fetch_all(
         pg_query_params(
            $this->dbconn,
            'SELECT get_zapis as zapis_id from get_zapis($1,$2) LIMIT 1', 
            array($obj->uczen_id, $obj->zajecia_id)
         ))[0]['zapis_id'];


      $obj = (array) $obj;

         unset($obj['uczen_id']);
         unset($obj['zajecia_id']);
         $obj['zapis_id'] = $zapis_id;
         
         //$obj['typ'] = $obj['obecnosc'];
         //unset($obj['obecnosc']);

         $result = pg_insert($this->dbconn,"obecnosc",$obj);

      return $result;
   }






/**
    * Realizuje usuwanie zapisu.
    * @param obj Obiekt z polami: uczen_id, zajecia_id
    * @return array
    */
   public function deleteZapis($obj)
   {
      

      //var_dump((array) $obj  );

      //$array = pg_convert($this->dbconn, 'ocena', $array);


      $zapis_id = pg_fetch_all(
         pg_query_params(
            $this->dbconn,
            'SELECT get_zapis as zapis_id from get_zapis($1,$2) LIMIT 1', 
            array($obj->uczen_id, $obj->zajecia_id)
         ))[0]['zapis_id'];


      $obj = (array) $obj;

         unset($obj['uczen_id']);
         unset($obj['zajecia_id']);
         $obj['zapis_id'] = $zapis_id;

      return pg_delete($this->dbconn,"zapis",$obj);
   }

  
}
  
?>