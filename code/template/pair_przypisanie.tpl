<script src="js/baza.js"></script>
<script type="text/javascript">
 
/**
 * Procedura aktualizuje widoczność przycisku na podstawie poprawności wypełnienia formularza.
 * @returns null
 */
function update_button_visibility()
{
    var nauczyciellist=document.form.nauczyciel;
    var przedmiotlist=document.form.przedmiot;

    if( nauczyciellist.selectedIndex != -1 && przedmiotlist.selectedIndex != -1 )
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
 * Procedura przesyłająca zawartość formularzy: [form] do serwera na wyznaczony url za pomocą POST.
 * @returns null
 * Element: [response] ulega aktualizacji o odpowiedź z serwera
 */
function fn_save_przypisanie()
{

    var nauczyciellist=document.form.nauczyciel;
    var przedmiotlist=document.form.przedmiot;

    if(nauczyciellist.selectedIndex != -1 && przedmiotlist.selectedIndex != -1 )
    {
    var nauczyciel_id = nauczyciellist.options[nauczyciellist.selectedIndex].value ;
     var przedmiot_id = przedmiotlist.options[przedmiotlist.selectedIndex].value ;
     //document.getElementById("data").style.display = "none" ;
     var json_data = "{\"przedmiot_id\":\"" + przedmiot_id + "\",\"nauczyciel_id\":\"" + nauczyciel_id + "\"}" ;
     var msg = "data=" + encodeURIComponent(json_data) ;
     var url = "index.php?sub=Baza&action=savePrzypisanie" ;
     resp = function(response) {
        // alert ( response ) ;
        document.getElementById("response").innerHTML = response ; 
      }
      xmlhttpPost (url, msg, resp) ;     
    }
}




</script>



<br/>
<form name="form">
    <table>
    <tr><th>Nauczyciel</th><th>Przedmiot</th></tr>
    <tr>
        <td>


            <select name="nauczyciel" size="10" onChange="update_button_visibility()" style="width:200px">
                <?php 
                if ($data) { 
                foreach ( $data as $row ) { 
                echo '<option value="'.$row['nauczyciel_id'].'">'.$row['imie']." ".$row['nazwisko']. " (". $row['nauczyciel_id'] .")".'</option>' ;
                }}
                ?> 
            </select>


        </td>
        <td>

            <select name="przedmiot" size="10" style="width: 200px" onChange="update_button_visibility()">
                <?php 
                if ($data2) { 
                foreach ( $data2 as $row ) { 
                echo '<option value="'.$row['przedmiot_id'].'">'. $row['przedmiot'] .'</option>' ;
                }}
                ?> 
            </select>

        </td>
    </tr>
    </table>
<input name="button" type="button" value="Zapisz" style="visibility:hidden" onclick="fn_save_przypisanie()" /> 
</form>
<span id="response"></span>
<script>
    update_button_visibility(); 
</script>
