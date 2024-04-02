<script src="js/baza.js"></script>
<script>


/**
 * Procedura przesyłająca zawartość formularzy: [form] do serwera na wyznaczony url za pomocą POST.
 * @returns null
 * Element: [response] ulega aktualizacji o odpowiedź z serwera
 */
function fn_save_class()
 {
     var wychowawca = document.getElementById("wychowawca_id").value ;
     var nazwa = document.getElementById("nazwa").value ;
     var sala  = document.getElementById("sala_id").value ;



     //document.getElementById("data").style.display = "none" ;
     var json_data = "{\"wychowawca_id\":\"" + wychowawca + "\",\"id\":\"" + nazwa + "\",\"sala\":\"" + sala + "\"}" ;
     var msg = "data=" + encodeURIComponent(json_data) ;
     var url = "index.php?sub=Baza&action=saveKlasa";
     resp = function(response) {
        // alert ( response ) ;
        document.getElementById("response").innerHTML = response ; 
      }
      xmlhttpPost (url, msg, resp) ;                          
}  
</script>
<form name="form">            
  <table>
    <tr><td><label for="wychowawca_id">ID_wychowawcy:</label></td>
    <td><input value="<?php if(isset($formData)) echo $formData['wychowawca_id']; ?>" type="text" id="wychowawca_id" name="wychowawca_id" /></td></tr>
    
    <tr><td><label for="sala_id">Numer sali:</label></td>
    <td><input value="<?php if(isset($formData)) echo $formData['sala_id']; ?>" type="text" id="sala_id" name="sala_id" /></td></tr>
    
    <tr><td><label for="nazwa">Nazwa klasy:</label></td>
    <td><input value="<?php if(isset($formData)) echo $formData['nazwa']; ?>" type="text" id="nazwa" name="nazwa" /></td></tr>
    
    <tr><td><span id="data"><input type="button" value="Zapisz" onclick="fn_save_class()" /></span></td>
    <td><span id="response"></span></td></tr>
  </table>
</form> 