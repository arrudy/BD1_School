<script src="js/baza.js"></script>
<script>

/**
 * Procedura przesyłająca zawartość formularzy: [form] do serwera na wyznaczony url za pomocą POST.
 * @returns null
 * Element: [response] ulega aktualizacji o odpowiedź z serwera
 */
function fn_save_obecnosc()
 {
     var zajecia_id = document.getElementById("zajecia_id").value ;
     var uczen_id = document.getElementById("uczen_id").value ;
     var wartosc = document.getElementById("obecnosc").value ;
     var data = document.getElementById("data").value;

     var json_data = "{\"zajecia_id\":\"" + zajecia_id + "\",\"uczen_id\":\"" + uczen_id + "\",\"typ\":\"" + wartosc + 
      "\",\"data\":\"" + data + "\"}" ;
     
     
     
     
     var msg = "data=" + encodeURIComponent(json_data) ;

     var url = "index.php?sub=Baza&action=saveObecnosc" ;
     resp = function(response) {
        // alert ( response ) ;
        document.getElementById("response").innerHTML = response ; 
      }
      xmlhttpPost (url, msg, resp) ;                          
}



</script>

<form name="form">            
  <table>
  <tr><td><label for="zajecia_id">ID zajęć:</label></td>
    <td><input value="<?php if(isset($_GET['zajecia_id'])) echo $_GET['zajecia_id']; ?>" type="number" id="zajecia_id" name="zajecia_id" <?php if(isset($_GET['zajecia_id'])) echo "disabled"; ?>/></td></tr>
    
    <tr><td><label for="uczen_id">ID ucznia:</label></td>
    <td><input value="<?php if(isset($_GET['uczen_id'])) echo $_GET['uczen_id']; ?>" type="number" id="uczen_id" name="uczen_id" <?php if(isset($_GET['uczen_id'])) echo "disabled"; ?>/></td></tr>


    <tr><td><label for="obecnosc">Obecnosc:</label></td>
    <td>
    <select name="obecnosc" id="obecnosc">
      <option value="ob">Obecny</option>
      <option value="nb">Nieobecny</option>
      <option value="zw">Zwolniony</option>
      <option value="us">Usprawiedliwiony</option>
    </select>
    </td>
  </tr>


    <tr><td><label for="data">Data obecnosci:</label></td>
    <td><input value="<?php echo date('Y-m-d'); ?>" type="date" id="data" name="data"/></td></tr>



    <tr><td><span id="data"><input type="button" value="Zapisz" onclick="fn_save_obecnosc()" /></span></td>
    <td></tr>
  </table>
  <span id="response"></span></td>
</form> 