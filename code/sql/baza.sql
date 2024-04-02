set datestyle to European;

create table nauczyciel(
nauczyciel_id SERIAL not null primary key,
PESEL VARCHAR(11) not null unique,
imie VARCHAR(1024) not null,
nazwisko VARCHAR(1024) not null
);


create table klasa(
klasa_id SERIAL NOT NULL PRIMARY KEY,
wychowawca_id INTEGER NOT NULL,
id VARCHAR(2) NOT NULL UNIQUE,
sala integer,
CONSTRAINT wychowawca_fk FOREIGN KEY (wychowawca_id) references nauczyciel(nauczyciel_id)
);



create table uczen(
uczen_id SERIAL not null primary key,
PESEL VARCHAR(11) not null unique,
imie VARCHAR(1024) not null,
nazwisko VARCHAR(1024) not null,
klasa_id INTEGER not null,
CONSTRAINT klasa_fk FOREIGN KEY (klasa_id) references klasa(klasa_id) --
);




create table przedmiot(
przedmiot_id SERIAL PRIMARY KEY NOT NULL,
nazwa VARCHAR(1024)
);



create table przypisanie(
przypisanie_id SERIAL primary key not null,
przedmiot_id INTEGER NOT NULL,
nauczyciel_id INTEGER NOT NULL,
CONSTRAINT nauczyciel_fk FOREIGN KEY (nauczyciel_id) references nauczyciel(nauczyciel_id),
UNIQUE(przedmiot_id, nauczyciel_id),
CONSTRAINT przedmiot_fk FOREIGN KEY (przedmiot_id) references przedmiot(przedmiot_id)
);



--pojedyncze zajecia
create table zajecia(
zajecia_id SERIAL NOT NULL PRIMARY KEY,
przypisanie_id INTEGER NOT NULL,
dzien_rozp DATE NOT NULL,
dzien_zak DATE NOT NULL,
--CONSTRAINT nauczyciel_fk FOREIGN KEY (nauczyciel_id) references uprawnienia(nauczyciel_id),
CONSTRAINT przypisanie_fk FOREIGN KEY (przypisanie_id) references przypisanie(przypisanie_id),
CONSTRAINT dzien_chk CHECK(dzien_rozp < dzien_zak and extract( ISODOW FROM dzien_rozp) = extract( ISODOW FROM dzien_zak) )
);




--encja asocjacyjna uczen - zajecia
create table zapis(
zapis_id SERIAL NOT NULL PRIMARY KEY,
zajecia_id INTEGER NOT NULL,
uczen_id INTEGER NOT NULL,
CONSTRAINT uczen_fk FOREIGN KEY (uczen_id) references uczen(uczen_id),
CONSTRAINT zajecia_fk FOREIGN KEY (zajecia_id) references zajecia(zajecia_id)
);





create table ocena(
ocena_id SERIAL NOT NULL PRIMARY KEY,
zapis_id INTEGER NOT NULL,
wartosc REAL NOT NULL check(wartosc between -0.5 and 6.0),
waga REAL NOT NULL default 1.0 check(waga between 0.0 and 1.0),
data DATE NOT NULL,
komentarz VARCHAR(65536),
CONSTRAINT zapis_fk FOREIGN KEY (zapis_id) references zapis(zapis_id)
);

--wewnetrzna tablica niemodyfikowalna (unikam w ten sposob drabinki switch case when)
create table typ_obecnosci(typ VARCHAR(2) PRIMARY KEY);

create table obecnosc(
obecnosc_id SERIAL NOT NULL PRIMARY KEY,
zapis_id INTEGER NOT NULL,
typ VARCHAR(2) NOT NULL REFERENCES typ_obecnosci(typ),
data DATE NOT NULL,
CONSTRAINT zapis_fk FOREIGN KEY (zapis_id) references zapis(zapis_id)
);

insert into typ_obecnosci values('ob');
insert into typ_obecnosci values('nb');
insert into typ_obecnosci values('zw');
insert into typ_obecnosci values('us');




--drop view klasa_zajecia;
create view klasa_zajecia as select uczen_id, imie, nazwisko, zajecia_id ,przedmiot_id, przedmiot.nazwa as przedmiot, klasa_id, klasa.id as klasa 
from klasa join uczen using(klasa_id) join zapis using(uczen_id) join zajecia using(zajecia_id) join przypisanie using(przypisanie_id) join przedmiot using (przedmiot_id) order by klasa.id, zajecia_id, uczen_id;




--wszystkie id miedzy zapis a przypisanie z zajecia polaczone jedna scierzka
create view id_asocjacja as select uczen_id, zapis_id, zajecia_id, przypisanie_id, nauczyciel_id, przedmiot_id 
from zapis join zajecia using(zajecia_id) join przypisanie using(przypisanie_id);


--krotki uczen_id - przedmiot.nazwa - zajecia_id - srednia wazona
create view przedmiot_zajecia_srednia as select uczen_id, przedmiot_id ,przedmiot.nazwa as przedmiot, zajecia_id, sum(case when wartosc >= 1.0 and waga > 0.0 then wartosc * waga end) / sum( case when wartosc >= 1.0 and waga > 0.0 then waga end) as srednia from ocena join id_asocjacja using(zapis_id) join przedmiot using(przedmiot_id) group by 
grouping sets((uczen_id, przedmiot_id, przedmiot, zajecia_id),(uczen_id, przedmiot_id, przedmiot));

--krotki uczen_id - przedmiot - srednia wazona
--spelnia ta sama funkcje co:
--create view przedmiot_srednia as select uczen_id, przedmiot_id ,przedmiot.nazwa as przedmiot, sum(case when wartosc >= 1.0 and waga > 0.0 then wartosc * waga end) / sum( case when wartosc >= 1.0 and waga > 0.0 then waga end) as srednia from ocena join id_asocjacja using(zapis_id) join przedmiot using(przedmiot_id) group by uczen_id, przedmiot_id, przedmiot;
create view przedmiot_srednia as select uczen_id, przedmiot_id , przedmiot, srednia from przedmiot_zajecia_srednia where zajecia_id is null;

--para id_zajecia - przedmiot
create view zajecia_przedmiot as select zajecia_id, przedmiot.nazwa from zajecia join przypisanie using(przypisanie_id) join przedmiot using(przedmiot_id);



--uczniowie z paskiem
--srednia >=4.75 niewazona z przedmiotow i z kazdego przedmiotu na ktory jest zapisany musi miec wyciagalna srednia (nie null w tablicy przedmiot_srednia).
create view pasek as select uczen_id, avg(srednia) as srednia from przedmiot_srednia ps 
where 
(select count(distinct przedmiot_id) from uczen join id_asocjacja using(uczen_id) group by uczen_id having uczen_id = ps.uczen_id) --wszystkich
= 
(select count(distinct przedmiot_id) from przedmiot_srednia where srednia is not null group by uczen_id having uczen_id = ps.uczen_id) --z ktorych dostal jakakolwiek ocene
group by uczen_id having avg(srednia) >= 4.75;






--funkcja wypisujaca wszystkie oceny danej osoby z danego przedmiotu

create or replace function przedmiot_oceny_lista( uczen_id integer ) returns table(przedmiot_id integer, oceny text ) as
$$
DECLARE
	ocena float;
	_przedmiot_id integer;
BEGIN
	FOR _przedmiot_id in (select distinct s.przedmiot_id from id_asocjacja s where s.uczen_id = $1) LOOP
		oceny := '';
		przedmiot_id := _przedmiot_id;
		FOR ocena in (select wartosc from ocena o join id_asocjacja s using(zapis_id) where s.uczen_id = $1 and s.przedmiot_id = _przedmiot_id) LOOP
			oceny := oceny || (case when ocena = 0.5 then '+' when ocena = -0.5 then '-' else cast(ocena as text) end) || ', ';
		END LOOP;
		return next;
		
	END LOOP;
END
$$
LANGUAGE plpgsql;




--widok wypisujacy podsumowanie wszystkich obecnosci
--przenosi informacje o braku wpisu; null jesli brak wpisow
--drop view obecnosc_podsumowanie;
create view obecnosc_podsumowanie as 
with help as (select * from obecnosc inner join zapis using (zapis_id))
select zapis.zajecia_id, zapis.uczen_id,
 ( select count( case when typ = 'ob' then 1 else null end) from help where zapis.zajecia_id = help.zajecia_id and zapis.uczen_id = help.uczen_id group by zajecia_id, uczen_id) as obecnosci,
 ( select count( case when typ = 'nb' then 1 else null end) from help where zapis.zajecia_id = help.zajecia_id and zapis.uczen_id = help.uczen_id group by zajecia_id, uczen_id) as nieobecnosci,
 ( select count( case when typ = 'zw' then 1 else null end) from help where zapis.zajecia_id = help.zajecia_id and zapis.uczen_id = help.uczen_id group by zajecia_id, uczen_id) as zwolnien,
 ( select count( case when typ = 'us' then 1 else null end) from help where zapis.zajecia_id = help.zajecia_id and zapis.uczen_id = help.uczen_id group by zajecia_id, uczen_id) as usprawiedliwien,
 ( select count(*) from help where zapis.zajecia_id = help.zajecia_id and zapis.uczen_id = help.uczen_id group by zajecia_id, uczen_id) as rekordow,
 (select count(distinct data) from help where zapis.zajecia_id = help.zajecia_id group by zajecia_id )  as zajec
 from 
 zapis
 ;

--info o zajeciach - identyfikatory, kto prowadzi, przedzial czasowy odbywania sie, nazwa
create view info_zajecia as select zajecia_id, nauczyciel_id , imie || ' ' || nazwisko as nauczyciel, przypisanie_id,przedmiot.nazwa as przedmiot, dzien_rozp, dzien_zak from zajecia join przypisanie using(przypisanie_id) join przedmiot using(przedmiot_id) join nauczyciel using(nauczyciel_id);

--podsumowanie zajec dla kazdego ucznia i przedmiotu - % obecnosci ucznia i jego srednia
create view zajecia_podsumowanie as
select 
zajecia_id ,
info_zajecia.przedmiot || ' z: ' || nauczyciel || ' (' || dzien_rozp || ' - ' || dzien_zak || ') [' || nauczyciel_id || ']' as zajecia,
 uczen_id, 
 imie || ' ' || nazwisko as uczen , 
 srednia ,
 100* obecnosci / zajec as procent_obecnosci from uczen join obecnosc_podsumowanie using(uczen_id) join przedmiot_zajecia_srednia using(uczen_id, zajecia_id) join info_zajecia using(zajecia_id) order by zajecia_id, uczen_id;



--funkcje zapewniajace dodatkowa funkcjonalnosc




--funkcja zapisujaca cala klase na zajecia
create or replace function zapisz_klase(_klasa_id integer, _zajecia_id integer) returns boolean as
$$
DECLARE
	_osoba_id integer;
BEGIN
	FOR _osoba_id in (select uczen_id from uczen where uczen.klasa_id = _klasa_id) LOOP
		insert into zapis(uczen_id, zajecia_id) values(_osoba_id, _zajecia_id);
	END LOOP;
	return true;
END
$$
LANGUAGE 'plpgsql';


--widok pozwalajacy na losowe wybranie n osob z obecnych

--drop view obecnosc_rng;
create view obecnosc_rng as select * from obecnosc join zapis using(zapis_id) order by RANDOM();







--trigger zamieniajacy TG_ARGV[0] ocen "+" na ocene 5 z waga TG_ARGV[1]
create or replace function trigger_aktywnosc() returns trigger as
$$
DECLARE
	_plus_liczba integer := (select count(*) from ocena where new.zapis_id = ocena.zapis_id and new.wartosc = 0.5);
	
BEGIN
	if _plus_liczba + 1 >= cast(TG_ARGV[0] as integer) then
		delete from ocena where ocena.ocena_id in ( select ocena_id from ocena where ocena.zapis_id = new.zapis_id and new.wartosc = 0.5 limit cast(TG_ARGV[0] as integer));
		insert into ocena (zapis_id, wartosc, waga, data, komentarz) values(new.zapis_id, 5.0, cast(TG_ARGV[1] as real), now(), 'Automatycznie wygenerowana za: aktywnosc');
		return null;
	end if;

	return new;
END
$$
LANGUAGE 'plpgsql';
create trigger trigger_aktywnosc BEFORE INSERT ON ocena FOR EACH ROW EXECUTE PROCEDURE trigger_aktywnosc(5,0.5);











--triggery odpowiedzialne za poprawne usuwanie danych


--trigger ktory lancuchowo usunie wszystkie oceny i obecnosci dla danego zapisu
create or replace function delete_zapis() returns TRIGGER as
$$
DECLARE
BEGIN
	DELETE from ocena where ocena.zapis_id = old.zapis_id;
	DELETE from obecnosc where obecnosc.zapis_id = old.zapis_id;
	return OLD;
END
$$
LANGUAGE 'plpgsql';
create trigger zapis_delete BEFORE DELETE ON zapis FOR EACH ROW EXECUTE PROCEDURE delete_zapis();




--trigger ktory lancuchowo usuwa wszystkie zapisy powiazane z uczniem
create or replace function delete_uczen() returns TRIGGER as
$$
DECLARE
BEGIN
	DELETE FROM zapis where zapis.uczen_id = old.uczen_id;
	return OLD;
END
$$
LANGUAGE 'plpgsql';
create trigger uczen_delete BEFORE DELETE ON uczen FOR EACH ROW EXECUTE PROCEDURE delete_uczen();



--trigger lancuchowo usuwajacy wszystkie zajecia zwiazane z zapisem
create or replace function delete_przypisanie() returns TRIGGER as
$$
DECLARE
niezerowe integer := 0;
BEGIN

	select count(*) into niezerowe from zajecia where zajecia.przypisanie_id = old.przypisanie_id and zajecia.dzien_rozp <= now() and now() <= zajecia.dzien_zak;
	
	IF niezerowe >0 THEN
		raise exception 'Nie mozna usunac - ktores zajecia nadal trwaja. Usun trwajace zajecia bezposrednio.';
		return null;
	else
		delete from zajecia where zajecia.przypisanie_id = old.przypisanie_id;
		return old;
	end if;

END
$$
LANGUAGE 'plpgsql';
create trigger przypisanie_delete BEFORE DELETE ON przypisanie FOR EACH ROW EXECUTE PROCEDURE delete_przypisanie();



--usuwa wszystkie powiazane zajecia
--trwajace zajecia mozna usunac jedynie bezposrednio, poprzez usuwanie z tablie zajecia.
create or replace function delete_zajecia() returns trigger as
$$
DECLARE
BEGIN
	delete from zapis where zapis.zajecia_id = old.zajecia_id;
	return old;
END
$$
LANGUAGE 'plpgsql';
create trigger zajecia_delete BEFORE DELETE ON zajecia FOR EACH ROW EXECUTE PROCEDURE delete_zajecia();




--usuwa, jesli to mozliwe, nauczyciela i wszystkie powiazane zajecia oraz uprawnienia
--aby usuniecie bylo mozliwe, wszystkie zajecia musza ulec zakonczeniu, lub musza dopiero w przyszlosci sie rozpoczynac
create or replace function delete_nauczyciel() returns trigger as
$$
DECLARE
	trwajace integer := 0;
BEGIN
	select count( case when  dzien_rozp <= now() and now() <= dzien_zak then 1 else null end) into trwajace from nauczyciel join przypisanie using(nauczyciel_id) join zajecia using(przypisanie_id) where nauczyciel_id = old.nauczyciel_id;
	
	IF trwajace > 0 THEN
		raise exception 'Nie mozna usunac - ktores zajecia nadal trwaja. Usun trwajace zajecia bezposrednio.';
		return null;
	else
		delete from przypisanie where przypisanie.nauczyciel_id = old.nauczyciel_id;
		return old;
	end if;
END
$$
LANGUAGE 'plpgsql';
create trigger nauczyciel_delete BEFORE DELETE ON nauczyciel FOR EACH ROW EXECUTE PROCEDURE delete_nauczyciel();



--usuwa, jesli to mozliwe, przedmiot i wszelkie powiazania z nim zwiazane.
--aby usuniecie bylo mozliwe, wszystkie zajecia musza ulec zakonczeniu, lub musza dopiero w przyszlosci sie rozpoczynac
create or replace function delete_przedmiot() returns trigger as
$$
DECLARE
	trwajace integer := 0;
BEGIN
	select count( case when  dzien_rozp <= now() and now() <= dzien_zak then 1 else null end) into trwajace from przedmiot join przypisanie using(przedmiot_id) join zajecia using(przypisanie_id) where przedmiot_id = old.przedmiot_id;
	
	IF trwajace > 0 THEN
		raise exception 'Nie mozna usunac - ktores zajecia nadal trwaja. Usun trwajace zajecia bezposrednio.';
		return null;
	else
		delete from przypisanie where przypisanie.przedmiot_id = old.przedmiot_id;
		return old;
	end if;
END
$$
LANGUAGE 'plpgsql';
create trigger przedmiot_delete BEFORE DELETE ON przedmiot FOR EACH ROW EXECUTE PROCEDURE delete_przedmiot();






--usuwa wszystkich uczniow z klasy
create or replace function delete_klasa() returns trigger as
$$
DECLARE
BEGIN
	delete from uczen where uczen.klasa_id = old.klasa_id;
	return old;
END
$$
LANGUAGE 'plpgsql';
create trigger klasa_delete BEFORE DELETE ON klasa FOR EACH ROW EXECUTE PROCEDURE delete_klasa();



--triggery odpowiedzialne za poprawne wprowadzanie danych

create or replace function insert_obecnosc() returns trigger as
$$
DECLARE
_zajecia zajecia%ROWTYPE;
_obecnosc obecnosc%ROWTYPE;
BEGIN

	select zajecia.* into _zajecia from zajecia join zapis using(zajecia_id) where (new.zapis_id = zapis_id);
	IF 
		new.data < _zajecia.dzien_rozp  
		OR 
		new.data > _zajecia.dzien_zak 
		OR 
		extract( ISODOW FROM new.data) != extract( ISODOW FROM _zajecia.dzien_rozp) THEN
			raise exception 'Data obecnosci nie jest poprawna.';
			return null;
		elsif (select count(*) from obecnosc where new.data = data and new.zapis_id = zapis_id) > 0 THEN
		
		
			select * into _obecnosc from obecnosc where new.data = data and new.zapis_id = zapis_id;
			
			IF new.typ = _obecnosc.typ then
				raise exception 'Wpis juz istnieje.';
				return null;
			else
				update obecnosc SET typ = new.typ where new.zapis_id = zapis_id;
				raise notice 'Wpis juz istnieje. Zostanie zmodyfikowany.';
				return null;
			end if;
		else
			return new;
		end if;
END
$$
LANGUAGE 'plpgsql';
create trigger obecnosc_insert BEFORE INSERT ON obecnosc FOR EACH ROW EXECUTE PROCEDURE insert_obecnosc();




--trigger zapobiegajacy powstaniu nadmiaru w relacji zapis
create or replace function insert_zapis() returns trigger as
$$
DECLARE
BEGIN
--dokonczyc ochrone przed duplikatami
if (select count(*) from (select * from zapis where zajecia_id = new.zajecia_id and uczen_id = new.uczen_id) as powtorki) > 0 then
	raise exception 'Nie mozna dodac - wpis juz istnieje.';
	return null;
	else
	return new;
end if;
END
$$
LANGUAGE 'plpgsql';

create trigger zapis_insert BEFORE INSERT ON zapis FOR EACH ROW EXECUTE PROCEDURE insert_zapis();






--dla danych zajec i danego ucznia zwraca jego przypisanie
create or replace function get_zapis(_uczen_id INTEGER, _zajecia_id INTEGER) returns INTEGER as
$$
 SELECT zapis_id from zapis where uczen_id = _uczen_id and zajecia_id = _zajecia_id LIMIT 1;
$$
LANGUAGE SQL;










--procedura dodajaca _num losowych ocen losowym uczniom na losowych zajeciach
create or replace function add_rand_ocena(_num integer) returns boolean as
$$
DECLARE
	i INTEGER := 0;
BEGIN
	FOR i in 1.._num LOOP
		insert into ocena(zapis_id, wartosc, waga, data, komentarz) values( (select zapis_id from zapis ORDER BY RANDOM() LIMIT 1),  -0.5 + (random()*13)::int * 0.5, random(), now(), 'Wygenerowana automatycznie'  );
	END LOOP;
	return true;
END
$$
LANGUAGE 'plpgsql';




--procedure dodajaca _num obecnosci losowego typu losowym uczniom na losowych zajeciach
create or replace function add_rand_obecnosc(_num integer) returns boolean as
$$
DECLARE
	_zapis_id INTEGER := 0;
	_typ VARCHAR(2);
	_data DATE;
BEGIN
	FOR i in 1.._num LOOP
		select zapis_id into _zapis_id from zapis order by random() limit 1;

		select typ into _typ from typ_obecnosci order by random() limit 1;

		with daty as (select dzien_rozp, dzien_zak from zapis join zajecia using(zajecia_id) where zapis_id = _zapis_id limit 1)
		select daty.dzien_rozp + (( (daty.dzien_zak - daty.dzien_rozp)*random())::int / 7)*7 into _data from daty;


		IF (select count(*) from obecnosc where zapis_id = _zapis_id and typ = _typ and data = _data) = 0 THEN --wpis nie istnieje
		insert into obecnosc(zapis_id, typ, data) values (
			_zapis_id, 
			_typ, 
			_data
		);
		end if;
	END LOOP;
	return true;
END
$$
LANGUAGE 'plpgsql';

select 'true';