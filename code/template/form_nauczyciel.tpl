<script src="js/baza.js"></script>

<script>


/**
 * Procedura przesyłająca zawartość formularzy: [form] do serwera na wyznaczony url za pomocą POST.
 * @returns null
 * Element: [response] ulega aktualizacji o odpowiedź z serwera
 */
function fn_save_nauczyciel()
 {
     var fname = document.getElementById("fname").value ;
     var lname = document.getElementById("lname").value ;
     var PESEL = document.getElementById("pesel").value ;
     //var city  = document.getElementById("city").value ;
     //document.getElementById("data").style.display = "none" ;
     var json_data = "{\"imie\":\"" + fname + "\",\"nazwisko\":\"" + lname + "\",\"pesel\":\"" + PESEL + "\"}" ;
     var msg = "data=" + encodeURIComponent(json_data) ;
     var url = "index.php?sub=Baza&action=saveNauczyciel" ;
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
    <tr><td><label for="fname">Imie:</label></td>
    <td><input value="<?php if(isset($formData)) echo $formData['fname']; ?>" type="text" id="fname" name="fname" /></td></tr>
    
    <tr><td><label for="lname">Nazwisko:</label></td>
    <td><input value="<?php if(isset($formData)) echo $formData['lname']; ?>" type="text" id="lname" name="lname" /></td></tr>
    
    <tr><td><label for="pesel">PESEL:</label></td>
    <td><input value="<?php if(isset($formData)) echo $formData['pesel']; ?>" type="text" id="pesel" name="pesel" /></td></tr>
    
    <tr><td><span id="data"><input type="button" value="Zapisz" onclick="fn_save_nauczyciel()" /></span></td>
    <td><span id="response"></span></td></tr>
  </table>
</form> 