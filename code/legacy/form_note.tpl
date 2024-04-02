<script src="js/baza.js"></script>
<form name="form">            
  <table>
    <tr><td><label for="nauczyciel_id">ID_nauczyciela:</label>
    <input value="<?php if(isset($formData)) echo $formData['nauczyciel_id']; ?>" type="text" id="nauczyciel_id" name="nauczyciel_id" /></td></tr>
    
    <tr>
      <td>
      <label for="note">Uwaga:</label></b><br style="margin-bottom: 10px;">
      <textarea id="note" name="note" rows="6" cols="50" style="margin-bottom: 10px;"></textarea>
      </td>
    </tr>
    
    <tr><td><span id="data"><input type="button" value="Zapisz" onclick="fn_save_ocena()" /></span></td>
    <td><span id="response"></span></td></tr>
  </table>
</form> 