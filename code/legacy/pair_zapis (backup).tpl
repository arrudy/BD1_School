<script src="js/baza.js"></script>
<script type="text/javascript">



function pair_zapis_updateUczen(selectedKlasa)
 {
    update_button_visibility();
    var klasalist=document.form.klasa;
    var uczenlist=document.form.uczen;
     //var klasa = document.getElementById("lname").value ;
     //document.getElementById("data").style.display = "none" ;
     var json_data = "{\"class\":\"" + klasalist.options[selectedKlasa].text + "\"}" ;
     var msg = "data=" + encodeURIComponent(json_data) ;
     var url = "index.php?sub=Baza&action=direct_searchClass" ;
     resp = function(response) {
        response = JSON.parse(response);
        //var studentlist=document.form.uczen;
        //studentlist.options = JSON.parse(response);
        uczenlist.options.length=0
        for (i=0; i<response.length; i++)
        {
            uczenlist.options[uczenlist.options.length] = new Option(response[i].imie + " " + response[i].nazwisko,response[i].uczen_id,false,false);
        }


        //document.getElementById("art_content").innerHTML = ;
      }
      xmlhttpPost (url, msg, resp) ;                          
}  

function update_button_visibility()
{
    var klasalist=document.form.klasa;
    var uczenlist=document.form.uczen;
    var przedmiotlist=document.form.zajecia;

    if(klasalist.selectedIndex > 0 && uczenlist.selectedIndex != -1 && przedmiotlist.selectedIndex != -1 )
    {
        document.form.button.style.visibility="visible";
    }
    else
    {
        document.form.button.style.visibility="hidden";
    }
    document.getElementById("response").innerHTML = "";
}


function fn_save_zapis()
{

    var uczenlist=document.form.uczen;
    var przedmiotlist=document.form.zajecia;

    if(uczenlist.selectedIndex != -1 && przedmiotlist.selectedIndex != -1 )
    {
    var uczen_id = uczenlist.options[uczenlist.selectedIndex].value ;
     var zajecia_id = przedmiotlist.options[przedmiotlist.selectedIndex].value ;
     //document.getElementById("data").style.display = "none" ;
     var json_data = "{\"zajecia_id\":\"" + zajecia_id + "\",\"uczen_id\":\"" + uczen_id + "\"}" ;
     var msg = "data=" + encodeURIComponent(json_data) ;
     var url = "index.php?sub=Baza&action=saveZapis" ;
     resp = function(response) {
        // alert ( response ) ;
        document.getElementById("response").innerHTML = response ; 
      }
      xmlhttpPost (url, msg, resp) ;     
    }
}




</script>




<form name="form">
<select name="klasa" size="10" onChange="pair_zapis_updateUczen(this.selectedIndex)" style="width:120px">
<option selected="selected">Wybierz klasę</option>

<?php 

if ($data) { 
   foreach ( $data as $row ) { 
   echo '<option value="'.$row['zajecia_id'].'">'.$row['id'].'</option>' ;
   echo '</tr>';
}}
?> 
</select>
<select name="uczen" size="10" style="width: 200px" onChange="update_button_visibility()">
</select>
<select name="zajecia" size="10">

<?php 

if ($data2) { 
   foreach ( $data2 as $row ) { 
   echo '<option value="'.$row['zajecia_id'].'">'.   $row['zajecia_id']." ". $row['przedmiot'] . " " . $row['nauczyciel'] . " (". $row['nauczyciel_id'] .")"                 .'</option>' ;
   echo '</tr>';
}}
?> 

</select>
<input name="button" type="button" value="Zapisz" style="visibility:hidden" onclick="fn_save_zapis()" /> 
</form>
<script>
    update_button_visibility(); 
</script>

<span id="response"></span>

