<?php
namespace appl;
class view
{
    protected $_file;
    protected $_data = array();
      
    public function __construct($template)
    {
        $file = 'template/'.strtolower($template).'.tpl' ;
        if ( file_exists($file) )  
         { $this->_file =  $file ; }
        else
         { throw new \Exception("Template " . $file . " doesn't exist.") ; }
    }
      
    public function __set($key, $value) //Obsługuje próbę zapisu do atrybutu, który nie istnieje lub jest niewidoczny dla klasy.
    {
        $this->_data[$key] = $value;
    }
      
    public function __get($key) //Obsługuje próbę dostępu do atrybutu, który nie istnieje lub jest niewidoczny dla klasy
    {
        return $this->_data[$key];
    }
      
    public function __toString() //Wywoływana, kiedy nastąpi próba przekonwertowania obiektu na tekst. 
    {      

        //foreach ( $this->_data as $key => $value ) echo $key. "::--::".$value;


        
        extract($this->_data);
        ob_start();//buforowanie wyjścia
        include($this->_file);
        $output = ob_get_contents();// skopiowanie wewnętrznego bufora  do zmiennej
        ob_end_clean(); //czyszczenie bufora i zamykanie
        return $output;
    }
}
?>