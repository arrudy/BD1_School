<script src="js/baza.js"></script>
<script type="text/javascript">

document.getElementById("art_section").style.width = "fit-content";





/**
 * Procedura przesyłająca zawartość pól: [przedmiot] do serwera na wyznaczony url za pomocą POST.
 * @returns null
 * Element: [zajecia] ulega aktualizacji o odpowiedź z serwera
 */
function pair_zapis_updateZajecia(selectedPrzedmiot)
 {
    update_button_visibility();
    var przedmiotlist=document.form.przedmiot;
    var zajecialist = document.form.zajecia;
     //var klasa = document.getElementById("lname").value ;
     //document.getElementById("data").style.display = "none" ;
     var json_data = "{\"przedmiot_id\":\"" + przedmiotlist.options[selectedPrzedmiot].value + "\"}" ;
     var msg = "data=" + encodeURIComponent(json_data) ;
     var url = "index.php?sub=Baza&action=direct_searchZajecia_przedmiot" ;

     document.getElementById("response").innerHTML = 'Przetwarzanie.';

     resp = function(response) {
        zajecialist.options.length=0
        document.getElementById("response").innerHTML = "";
        try{
        response = JSON.parse(response);
        for (i=0; i<response.length; i++)
        {
            zajecialist.options[zajecialist.options.length] = new Option( "[" + response[i].zajecia_id  + "] (" + response[i].dzien_rozp + ")"  + response[i].nauczyciel,response[i].zajecia_id,false,false);
        }
        }
        catch(e){};
        //var studentlist=document.form.uczen;
        //studentlist.options = JSON.parse(response);
        
        

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
    var klasalist=document.form.klasa;
    var przedmiotlist=document.form.przedmiot;
    var zajecialist=document.form.zajecia;

    if(klasalist.selectedIndex > 0 && przedmiotlist.selectedIndex > 0 && zajecialist.selectedIndex != -1 )
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
 * Procedura przesyłająca zawartość formularzy: [klasa, zajecia] do serwera na wyznaczony url za pomocą POST.
 * @returns null
 * Element: [response] ulega aktualizacji o odpowiedź z serwera
 */
function fn_save_zapis_all()
{

    var klasalist=document.form.klasa;
    var przedmiotlist=document.form.przedmiot;
    var zajecialist=document.form.zajecia;

    if(klasalist.selectedIndex > 0 && przedmiotlist.selectedIndex > 0 && zajecialist.selectedIndex != -1 )
    {
        var klasa_id = klasalist.options[klasalist.selectedIndex].value ;
        var zajecia_id = zajecialist.options[zajecialist.selectedIndex].value ;
        //document.getElementById("data").style.display = "none" ;
        var json_data = "{\"zajecia_id\":\"" + zajecia_id + "\",\"klasa_id\":\"" + klasa_id + "\"}" ;
        var msg = "data=" + encodeURIComponent(json_data) ;
        var url = "index.php?sub=Baza&action=algorytmZapisKlasy" ;
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
<tr><th>Klasa</th><th>Przedmiot</th><th>Zajęcia</th></tr>

<tr><td>
<select name="klasa" size="10" onChange="update_button_visibility()" style="width:120px">
    <option selected="selected">Wybierz klasę</option>
    <?php 

    if ($data) { 
    foreach ( $data as $row ) { 
    echo '<option value="'.$row['klasa_id'].'">'.$row['id'].'</option>' ;
    }}
    ?> 
    </select>

</td><td>

    <select name="przedmiot" size="10" onChange="pair_zapis_updateZajecia(this.selectedIndex)">
    <option selected="selected">Wybierz przedmiot</option>
    <?php 
    if ($data2) {
    foreach ( $data2 as $row ) { 
    echo '<option value="'.$row['przedmiot_id'].'">'. $row['przedmiot'] .'</option>' ;
    }}
    ?> 
</select>

</td><td>

    <select name="zajecia" onChange="update_button_visibility()" size="10" style="width: 300px">
    </select>
</td>
</tr>
</table>
    <input name="button" type="button" value="Zapisz" style="visibility:hidden" onclick="fn_save_zapis_all()" /> 
</form>
<span id="response"></span>
<script>
    update_button_visibility(); 

    document.getElementById("art_section").style.width = "fit-content";
</script>
