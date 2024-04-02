<script src="js/baza.js"></script>
<script>

/**
 * Procedura przesyłająca zawartość formularzy: [form] do serwera na wyznaczony url za pomocą POST.
 * @returns null
 * Element: [response] ulega aktualizacji o odpowiedź z serwera
 */
function fn_save_przedmiot()
 {
     var nazwa = document.getElementById("nazwa").value ;
     //var city  = document.getElementById("city").value ;
     //document.getElementById("data").style.display = "none" ;
     var json_data = "{\"nazwa\":\"" + nazwa + "\"}" ;
     var msg = "data=" + encodeURIComponent(json_data) ;
     var url = "index.php?sub=Baza&action=savePrzedmiot" ;
     document.getElementById("response").innerHTML = "";
     resp = function(response) {
        // alert ( response ) ;
        document.getElementById("response").innerHTML = response ; 
      }
      xmlhttpPost (url, msg, resp) ;                          
}


</script>
<form name="form">            
  <table>
    <tr><td><label for="nazwa">Nazwa:</label></td>
    <td><input value="<?php if(isset($formData)) echo $formData['nazwa']; ?>" type="text" id="nazwa" name="nazwa" /></td></tr>
    
    <tr><td><span id="data"><input type="button" value="Zapisz" onclick="fn_save_przedmiot()" /></span></td>
    <td><span id="response"></span></td></tr>
  </table>
</form> 