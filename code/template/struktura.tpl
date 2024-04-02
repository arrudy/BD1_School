<head>
   <meta http-equiv="content-type" content="text/html; charset=iso-8859-2">
   <title>E-dziennik</title>
   <?php echo $css ; ?>  
   <script type="text/JavaScript" src="js/baza.js"></script> 
   <script>

      /** Wysyła puste żądanie do serwera na zadany adres.
       * @param arg funkcja po stronie serwera do wykonania
       */
      function zadanie(arg)
      {


         var msg = "data=" + encodeURIComponent(null) ;
         var url = "index.php?sub=Baza&action="+ arg;
         document.getElementById("response").innerHTML = ""; 
         resp = function(response) {
            // alert ( response ) ;
            document.getElementById("response").innerHTML = response ; 
            }
            xmlhttpPost (url, msg, resp) ;                          
      }  


   </script>
</head>
<input type="button" value="Resetuj strukturę" onclick="zadanie('resetStruktura')" />
<input type="button" value="Wprowadź losowe dane" onclick="zadanie('fillPrzyklad')" />
<p id = "response"></p>