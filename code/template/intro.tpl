<p>
Witaj Użytkowniku w programie "E-dziennik".
</p>


<?php
if(!defined('__NO_REGISTER') && !isset($_SESSION['auth']))
echo '<b>Przed skorzystaniem z bazy należy się zalogować. Instrukcja logowania znajduje się w dokumentacji.</b>';
?>

<p>
    Aby:
</p>
<ul>
    <li>Dodać ucznia</li>
    <li>Dodać nauczyciela</li>
    <li>Dodać klasę</li>
    <li>Dodać przedmiot</li>
    <li>Dodać zajęcia</li>
    <li>Przypisać ucznia/uczniów do zajęć</li>
    <li>Przypisać nauczyciela do przedmiotu</li>
</ul>
<p>
    Wybierz zakładkę "Zarządzaj".
</p>
<p>W zakładce "Przeglądaj" można:</p>
<ul>
    <li>Wyszukać informacje zawarte w bazie</li>
    <li>Wyświetlić zbiorcze raporty dotyczące kształcenia uczniów</li>
</ul>

<p>
    W zakładce "Zarządzaj" znajdują się funkcjonalności odpowiedzialne za utrzymianie, przywracanie i testowanie aplikacji.
</p>