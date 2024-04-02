<script src="js/baza.js"></script>

<form name="form" id = "form">            
  <table>
    <tr><td><label for="uczen">Uczen:</label></td>
    <td><input value="<?php if(isset($formData)) echo $formData['uczen']; ?>" type="text" id="uczen" name="uczen" /></td></tr>
    <tr><td><span id="data"><input type="button" value="Znajdz" onclick="fn_search_uczen()" /></span></td>
    <td><span id="response"></span></td></tr>
  </table>
</form> 