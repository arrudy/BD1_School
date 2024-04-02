set datestyle to European;
delete from zajecia;
delete from zapis;
delete from przypisanie;
delete from uczen;
delete from nauczyciel;
delete from klasa;



insert into nauczyciel ( PESEL, imie, nazwisko) values ('01273425432','Kamil', 'Babacki');
insert into nauczyciel ( PESEL, imie, nazwisko) values ('03236455242','Wiera', 'Kowalczyk');
insert into nauczyciel ( PESEL, imie, nazwisko) values ('27027842652','Aleksandra', 'Korzonko');

insert into klasa(wychowawca_id, id, sala) values ( 1, '1A', 303);
insert into klasa(wychowawca_id, id, sala) values ( 2, '1F', 46);
insert into klasa(wychowawca_id, id, sala) values ( 3, '1G', 16);

insert into przedmiot(nazwa) values( 'Jezyk Polski 1');
insert into przedmiot(nazwa) values( 'Matematyka 1');
insert into przedmiot(nazwa) values( 'Jezyk Angielski 1');
insert into przedmiot(nazwa) values( 'Fizyka 1');
insert into przedmiot(nazwa) values( 'WF 1');

insert into przypisanie (przedmiot_id,nauczyciel_id) values(1,1);
insert into przypisanie (przedmiot_id,nauczyciel_id) values(2,2);
insert into przypisanie (przedmiot_id,nauczyciel_id) values(3,3);
insert into przypisanie (przedmiot_id,nauczyciel_id) values(4,2);
insert into przypisanie (przedmiot_id,nauczyciel_id) values(5,1);

insert into zajecia(przypisanie_id, dzien_rozp, dzien_zak) values(1,'08-09-2023', '14-06-2024'); --1
insert into zajecia(przypisanie_id, dzien_rozp, dzien_zak) values(1,'04-09-2023', '10-06-2024'); --2
insert into zajecia(przypisanie_id, dzien_rozp, dzien_zak) values(1,'13-09-2023', '19-06-2024'); --3

insert into zajecia(przypisanie_id, dzien_rozp, dzien_zak) values(2,'01-09-2023', '07-06-2024'); --4
insert into zajecia(przypisanie_id, dzien_rozp, dzien_zak) values(2,'04-09-2023', '10-06-2024'); --5
insert into zajecia(przypisanie_id, dzien_rozp, dzien_zak) values(2,'05-09-2023', '11-06-2024'); --6

insert into zajecia(przypisanie_id, dzien_rozp, dzien_zak) values(3,'05-09-2023', '11-06-2024'); --7
insert into zajecia(przypisanie_id, dzien_rozp, dzien_zak) values(4,'06-09-2023', '12-06-2024'); --8
insert into zajecia(przypisanie_id, dzien_rozp, dzien_zak) values(5,'07-09-2023', '13-06-2024'); --9

insert into uczen(PESEL, imie, nazwisko, klasa_id) values('01292925974', 'Adam', 'Jackowiak', 1); --1
insert into uczen(PESEL, imie, nazwisko, klasa_id) values('02260174756', 'Alina', 'Jablonska', 1); --2
insert into uczen(PESEL, imie, nazwisko, klasa_id) values('00321972877', 'Bartosz', 'Iksinski', 1); --3
insert into uczen(PESEL, imie, nazwisko, klasa_id) values('02310915623', 'Barabara', 'Iwanowicz', 2); --4
insert into uczen(PESEL, imie, nazwisko, klasa_id) values('01282612495', 'Cezary', 'Horda', 2); --5
insert into uczen(PESEL, imie, nazwisko, klasa_id) values('02230169922', 'Celina', 'Historyk', 2); --6
insert into uczen(PESEL, imie, nazwisko, klasa_id) values('03301237511', 'Dariusz', 'Gromadny', 3); --7
insert into uczen(PESEL, imie, nazwisko, klasa_id) values('02242021511', 'Daria', 'Gruzin', 3); --8
insert into uczen(PESEL, imie, nazwisko, klasa_id) values('01231338416', 'Eugeniusz', 'Fabacki', 3); --9
insert into uczen(PESEL, imie, nazwisko, klasa_id) values('03301664119', 'Edyta', 'Felicka', 3); --10



insert into zapis(zajecia_id, uczen_id) values (1,1);
insert into zapis(zajecia_id, uczen_id) values (1,2);
insert into zapis(zajecia_id, uczen_id) values (1,3);
insert into zapis(zajecia_id, uczen_id) values (1,4);
insert into zapis(zajecia_id, uczen_id) values (1,5);
insert into zapis(zajecia_id, uczen_id) values (1,6);
insert into zapis(zajecia_id, uczen_id) values (1,7);
insert into zapis(zajecia_id, uczen_id) values (1,8);
insert into zapis(zajecia_id, uczen_id) values (1,9);
insert into zapis(zajecia_id, uczen_id) values (1,10);
insert into zapis(zajecia_id, uczen_id) values (2,1);
insert into zapis(zajecia_id, uczen_id) values (2,2);
insert into zapis(zajecia_id, uczen_id) values (2,3);
insert into zapis(zajecia_id, uczen_id) values (2,4);
insert into zapis(zajecia_id, uczen_id) values (2,5);
insert into zapis(zajecia_id, uczen_id) values (2,6);
insert into zapis(zajecia_id, uczen_id) values (2,7);
insert into zapis(zajecia_id, uczen_id) values (2,8);
insert into zapis(zajecia_id, uczen_id) values (2,9);
insert into zapis(zajecia_id, uczen_id) values (2,10);
insert into zapis(zajecia_id, uczen_id) values (3,1);
insert into zapis(zajecia_id, uczen_id) values (3,2);
insert into zapis(zajecia_id, uczen_id) values (3,3);
insert into zapis(zajecia_id, uczen_id) values (3,4);
insert into zapis(zajecia_id, uczen_id) values (3,5);
insert into zapis(zajecia_id, uczen_id) values (3,6);
insert into zapis(zajecia_id, uczen_id) values (3,7);
insert into zapis(zajecia_id, uczen_id) values (3,8);
insert into zapis(zajecia_id, uczen_id) values (3,9);
insert into zapis(zajecia_id, uczen_id) values (3,10);
insert into zapis(zajecia_id, uczen_id) values (4,1);
insert into zapis(zajecia_id, uczen_id) values (4,2);
insert into zapis(zajecia_id, uczen_id) values (4,3);
insert into zapis(zajecia_id, uczen_id) values (4,4);
insert into zapis(zajecia_id, uczen_id) values (4,5);
insert into zapis(zajecia_id, uczen_id) values (4,6);
insert into zapis(zajecia_id, uczen_id) values (4,7);
insert into zapis(zajecia_id, uczen_id) values (4,8);
insert into zapis(zajecia_id, uczen_id) values (4,9);
insert into zapis(zajecia_id, uczen_id) values (4,10);
insert into zapis(zajecia_id, uczen_id) values (5,1);
insert into zapis(zajecia_id, uczen_id) values (5,2);
insert into zapis(zajecia_id, uczen_id) values (5,3);
insert into zapis(zajecia_id, uczen_id) values (5,4);
insert into zapis(zajecia_id, uczen_id) values (5,5);
insert into zapis(zajecia_id, uczen_id) values (5,6);
insert into zapis(zajecia_id, uczen_id) values (5,7);
insert into zapis(zajecia_id, uczen_id) values (5,8);
insert into zapis(zajecia_id, uczen_id) values (5,9);
insert into zapis(zajecia_id, uczen_id) values (5,10);
insert into zapis(zajecia_id, uczen_id) values (6,1);
insert into zapis(zajecia_id, uczen_id) values (6,2);
insert into zapis(zajecia_id, uczen_id) values (6,3);
insert into zapis(zajecia_id, uczen_id) values (6,4);
insert into zapis(zajecia_id, uczen_id) values (6,5);
insert into zapis(zajecia_id, uczen_id) values (6,6);
insert into zapis(zajecia_id, uczen_id) values (6,7);
insert into zapis(zajecia_id, uczen_id) values (6,8);
insert into zapis(zajecia_id, uczen_id) values (6,9);
insert into zapis(zajecia_id, uczen_id) values (6,10);
insert into zapis(zajecia_id, uczen_id) values (7,1);
insert into zapis(zajecia_id, uczen_id) values (7,2);
insert into zapis(zajecia_id, uczen_id) values (7,3);
insert into zapis(zajecia_id, uczen_id) values (7,4);
insert into zapis(zajecia_id, uczen_id) values (7,5);
insert into zapis(zajecia_id, uczen_id) values (7,6);
insert into zapis(zajecia_id, uczen_id) values (7,7);
insert into zapis(zajecia_id, uczen_id) values (7,8);
insert into zapis(zajecia_id, uczen_id) values (7,9);
insert into zapis(zajecia_id, uczen_id) values (7,10);
insert into zapis(zajecia_id, uczen_id) values (8,4);
insert into zapis(zajecia_id, uczen_id) values (8,5);
insert into zapis(zajecia_id, uczen_id) values (8,6);
insert into zapis(zajecia_id, uczen_id) values (8,7);
insert into zapis(zajecia_id, uczen_id) values (8,8);
insert into zapis(zajecia_id, uczen_id) values (8,9);
insert into zapis(zajecia_id, uczen_id) values (8,10);
insert into zapis(zajecia_id, uczen_id) values (9,1);
insert into zapis(zajecia_id, uczen_id) values (9,2);
insert into zapis(zajecia_id, uczen_id) values (9,3);
insert into zapis(zajecia_id, uczen_id) values (9,4);
insert into zapis(zajecia_id, uczen_id) values (9,5);
insert into zapis(zajecia_id, uczen_id) values (9,6);
insert into zapis(zajecia_id, uczen_id) values (9,7);
insert into zapis(zajecia_id, uczen_id) values (9,8);
insert into zapis(zajecia_id, uczen_id) values (9,9);
insert into zapis(zajecia_id, uczen_id) values (9,10);





SELECT add_rand_ocena(300);
SELECT add_rand_obecnosc(1000);


insert into uczen(PESEL, imie, nazwisko, klasa_id) values('03301662112', 'Wiktor', 'Wzorowy', 3); --11
insert into zapis(zajecia_id, uczen_id) values (1,11);
insert into ocena(zapis_id, wartosc, waga, data) values( (select zapis_id from id_asocjacja where uczen_id = 11 limit 1) , 6, 1, now());


select True;