<script src="js/baza.js"></script>
<script>
/**
 * Procedura przesyłająca zawartość formularzy: [form] do serwera na wyznaczony url za pomocą POST.
 * @returns null
 * Element: [response] ulega aktualizacji o odpowiedź z serwera
 */
function fn_save_ocena()
 {
     var zajecia_id = document.getElementById("zajecia_id").value ;
     var uczen_id = document.getElementById("uczen_id").value ;
     var wartosc = document.getElementById("ocena").value ;
     var waga = document.getElementById("waga").value ;
     var data = format_date(new Date(document.getElementById("data").value));
     console.log( data );
     var komentarz = document.getElementById("komentarz").value ;

     //document.getElementById("data").style.display = "none" ;
     var json_data = "{\"zajecia_id\":\"" + zajecia_id + "\",\"uczen_id\":\"" + uczen_id + "\",\"wartosc\":\"" + wartosc + 
     "\",\"waga\":\"" + waga + "\",\"data\":\"" + data + "\",\"komentarz\":\"" + komentarz +
     "\"}" ;
     
     
     
     
     var msg = "data=" + encodeURIComponent(json_data) ;

     var url = "index.php?sub=Baza&action=saveOcena" ;
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
  <tr><td><label for="zajecia_id">ID zajęć:</label></td>
    <td><input value="<?php if(isset($_GET['zajecia_id'])) echo $_GET['zajecia_id']; ?>" type="number" id="zajecia_id" name="zajecia_id" <?php if(isset($_GET['zajecia_id'])) echo "disabled"; ?>/></td></tr>
    
    <tr><td><label for="uczen_id">ID ucznia:</label></td>
    <td><input value="<?php if(isset($_GET['uczen_id'])) echo $_GET['uczen_id']; ?>" type="number" id="uczen_id" name="uczen_id" <?php if(isset($_GET['uczen_id'])) echo "disabled"; ?>/></td></tr>


    <tr><td><label for="ocena">Ocena:</label></td>
    <td>
    <select name="ocena" id="ocena">
      <option value="6.0">6</option>
      <option value="5.5">5+</option>
      <option value="5.0">5</option>
      <option value="4.5">4+</option>
      <option value="4.0">4</option>
      <option value="3.5">3+</option>
      <option value="3.0">3</option>
      <option value="2.5">2+</option>
      <option value="2.0">2</option>
      <option value="1.5">1+</option>
      <option value="1.0">1</option>
      <option value="0.5">+</option>
      <option value="0.0">0</option>
      <option value="-0.5">-</option>
    </select>
    </td>
  </tr>

    <tr><td><label for="waga">Waga:</label></td>
    <td><input value="1" type="number" id="waga" name="waga" min="0.0" max="1.0" step="0.1"/></td></tr>



    <tr><td><label for="data">Data:</label></td>
    <td><input value="<?php echo date('Y-m-d'); ?>" type="date" id="data" name="data" disabled/></td></tr>
    
    <tr>
      <td>
      <label for="komentarz">Komentarz:</label></b><br style="margin-bottom: 10px;"></td><td>
      <textarea id="komentarz" name="komentarz" rows="6" cols="50" style="margin-bottom: 10px;"></textarea>
      </td>
    </tr>




    <tr><td><span id="data"><input type="button" value="Zapisz" onclick="fn_save_ocena()" /></span></td>
    <td><span id="response"></span></td></tr>
  </table>
</form> 