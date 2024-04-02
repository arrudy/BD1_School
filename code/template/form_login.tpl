<script src="js/baza.js"></script>
<script>



/**
 * Procedura przesyłająca zawartość formularzy: [form] do serwera na wyznaczony url za pomocą POST.
 * @returns null
 * Element: [response] ulega aktualizacji o odpowiedź z serwera
 */
function fn_login()
 {
     var nauczyciel_id = document.getElementById("nauczyciel_id").value ;
     var PESEL = document.getElementById("PESEL").value ;


     var json_data = "{\"nauczyciel_id\":\"" + nauczyciel_id + "\",\"PESEL\":\"" + PESEL + "\"}" ;
     var msg = "data=" + encodeURIComponent(json_data) ;
     var url = "index.php?sub=Baza&action=loginUser" ;
     resp = function(response) {
        // alert ( response ) ;
        document.getElementById("response").innerHTML = response ; 
      }
      xmlhttpPost (url, msg, resp) ;                          
}  

</script>

<form name="form" style="display: grid; justify-content: center;">            
  <table>
    <tr><td><label for="nauczyciel_id">nauczyciel_id:</label></td>
    <td><input value="<?php if(isset($formData)) echo $formData['nauczyciel_id']; ?>" type="text" id="nauczyciel_id" name="nauczyciel_id" /></td></tr>
    
    <tr><td><label for="PESEL">PESEL:</label></td>
    <td><input value="<?php if(isset($formData)) echo $formData['PESEL']; ?>" type="password" id="PESEL" name="PESEL" /></td></tr>

    <tr><td><span id="data"><input type="button" value="Zaloguj" onclick="fn_login()" /></span></td>
    <td><span id="response"></span></td></tr>
  </table>
</form> 