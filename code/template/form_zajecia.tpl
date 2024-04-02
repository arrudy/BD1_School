<script src="js/baza.js"></script>
<script>


/**
 * Procedura przesyłająca zawartość pól: [przedmiot] do serwera na wyznaczony url za pomocą POST.
 * @returns null
 * @param {*} selectedPrzedmiot ID przedmiotu z listy wyboru
 * Element: [nauczyciel] ulega aktualizacji o odpowiedź z serwera
 */
function form_zajecia_updateNauczyciel(selectedPrzedmiot)
 {
    update_button_visibility();
    var przedmiotlist=document.form.przedmiot;
    var nauczyciellist = document.form.nauczyciel;
     //var klasa = document.getElementById("lname").value ;
     //document.getElementById("data").style.display = "none" ;
     var json_data = "{\"przedmiot_id\":\"" + przedmiotlist.options[selectedPrzedmiot].value + "\"}" ;
     var msg = "data=" + encodeURIComponent(json_data) ;
     var url = "index.php?sub=Baza&action=direct_searchPrzypisanie_przedmiot" ;
     document.getElementById('response').innerHTML = "Przetwarzanie.";
     resp = function(response) {
      document.getElementById('response').innerHTML = "";
        //var studentlist=document.form.uczen;
        //studentlist.options = JSON.parse(response);
        nauczyciellist.options.length=0
        nauczyciellist.options.selectedIndex = -1;
        try{
          response = JSON.parse(response);
        for (i=0; i<response.length; i++)
        {
          nauczyciellist.options[nauczyciellist.options.length] = new Option( response[i].nauczyciel,response[i].przypisanie_id,false,false);
        }
        }
        catch(e)
        {
          
        }
        update_button_visibility();
        //document.getElementById("art_content").innerHTML = ;
      }
      xmlhttpPost (url, msg, resp) ;                          
}


/**
 * Procedura aktualizuje widoczność przycisku na podstawie poprawności wypełnienia formularza.
 * @returns null
 */
function update_button_visibility()
{
    var przedmiotlist=document.form.przedmiot;
    var nauczyciellist=document.form.nauczyciel;

    if( przedmiotlist.selectedIndex > 0 && nauczyciellist.selectedIndex != -1 )
    {
        document.form.button.style.visibility="visible";
    }
    else
    {
        document.form.button.style.visibility="hidden";
    }
    document.getElementById("response").innerHTML = "";
}

/**
 * Procedura przesyłająca zawartość pól: [nauczyciel, dzien_rozp, dzien_zak] do serwera na wyznaczony url za pomocą POST.
 * @returns null
 * Element: [response] ulega aktualizacji o odpowiedź z serwera
 */
function fn_save_zajecia()
{

    var przedmiotlist=document.form.przedmiot;
    var nauczyciellist=document.form.nauczyciel;
    var data_rozp = document.form.dzien_rozp.value;
    var data_zak = document.form.dzien_zak.value;

    if(przedmiotlist.selectedIndex > 0 && nauczyciellist.selectedIndex != -1 )
    {
     var przypisanie_id = nauczyciellist.options[nauczyciellist.selectedIndex].value ;
     //document.getElementById("data").style.display = "none" ;
     var json_data = "{\"przypisanie_id\":\"" + przypisanie_id + "\",\"dzien_rozp\":\"" + data_rozp + "\",\"dzien_zak\":\"" + data_zak + "\"}" ;
     var msg = "data=" + encodeURIComponent(json_data) ;
     var url = "index.php?sub=Baza&action=saveZajecia" ;
     resp = function(response) {
        // alert ( response ) ;
        document.getElementById("response").innerHTML = response ; 
      }
      xmlhttpPost (url, msg, resp) ;     
    }
}

</script>
<form name="form">            
  <table>
  <tr><th>Przedmiot</th><th>Nauczyciel</th></tr>

  <tr><td>
    <select name="przedmiot" size="10" style="width: 200px" onChange="form_zajecia_updateNauczyciel(this.selectedIndex)">
    <option selected="selected" value="0">Wybierz przedmiot</option>
    <?php 
    if ($data) { 
      foreach ( $data as $row ) { 
      echo '<option value="'.$row['przedmiot_id'].'">'. $row['przedmiot'] .'</option>' ;
    }}
    ?> 
    </select>
  </td><td>

    <select name="nauczyciel" size="10" onChange="update_button_visibility()" style="width:200px">
    </select>
  </td></tr>

    
    
  </table>

    <table>
    <tr><td><label for="dzien_rozp">Data pierwszych zajęć:</label></td>
    <td><input value="<?php echo date('Y-m-d'); ?>" type="date" id="dzien_rozp" name="dzien_rozp"/></td></tr>

    <tr><td><label for="dzien_zak">Data ostatnich zajęć:</label></td>
    <td><input value="<?php echo date('Y-m-d'); ?>" type="date" id="dzien_zak" name="dzien_zak"/></td></tr>
    <tr><td><span id="data"><input name="button" type="button" value="Zapisz" onclick="fn_save_zajecia()" /></span></td></tr>
    <tr><td><span id="response"></span></td></tr>
    </table>


</form> 

<script>
  update_button_visibility();
  form_zajecia_updateNauczyciel(document.form.przedmiot.selectedIndex);
</script>