<script src="js/baza.js"></script>
<script type="text/javascript">

document.getElementById("art_section").style.width = "fit-content";







/**
 * Procedura aktualizuje widoczność przycisku na podstawie poprawności wypełnienia formularza.
 * @returns null
 */
function update_button_visibility()
{
    var klasalist=document.form.klasa;
    var nauczyciellist=document.form.nauczyciel;

    if(klasalist.selectedIndex > 0 && nauczyciellist.selectedIndex != -1 )
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
 * Procedura przesyłająca zawartość pól: [klasa, nauczyciel] do serwera na wyznaczony url za pomocą POST.
 * @returns null
 * Element: [response] ulega aktualizacji o odpowiedź z serwera
 */
function fn_update_klasa()
{
    var klasalist=document.form.klasa;
    var nauczyciellist=document.form.nauczyciel;

    if(klasalist.selectedIndex != -1 && nauczyciellist.selectedIndex != -1 )
    {
    var klasa_id = klasalist.options[klasalist.selectedIndex].value ;
     var nauczyciel_id = nauczyciellist.options[nauczyciellist.selectedIndex].value ;
     //document.getElementById("data").style.display = "none" ;
     var json_data = "{\"nauczyciel_id\":\"" + nauczyciel_id + "\",\"klasa_id\":\"" + klasa_id + "\"}" ;
     var msg = "data=" + encodeURIComponent(json_data) ;
     var url = "index.php?sub=Baza&action=updateKlasa_wychowawca" ;
     resp = function(response) {
        // alert ( response ) ;
        document.getElementById("response").innerHTML = response ; 
      }
      xmlhttpPost (url, msg, resp) ;     
    }
}




</script>




<form name="form">
    <select name="klasa" size="10" onChange="update_button_visibility()" style="width:120px">
    <option selected="selected">Wybierz klasę</option>
    <?php 

    if ($data) { 
    foreach ( $data as $row ) { 
    echo '<option value="'.$row['klasa_id'].'">'.$row['id'].'</option>' ;
    echo '</tr>';
    }}
    ?> 
    </select>

    <select name="nauczyciel" size="10" onChange="update_button_visibility()" style="width:200px">
<?php 
if ($data1) { 
   foreach ( $data1 as $row ) { 
   echo '<option value="'.$row['nauczyciel_id'].'">'.$row['imie']." ".$row['nazwisko']. " (". $row['nauczyciel_id'] .")".'</option>' ;
   echo '</tr>';
}}
?> 
</select>

    <input name="button" type="button" value="Aktualizuj" style="visibility:hidden" onclick="fn_update_klasa()" /> 
</form>
<span id="response"></span>
<script>
    update_button_visibility(); 

    document.getElementById("art_section").style.width = "fit-content";
</script>
