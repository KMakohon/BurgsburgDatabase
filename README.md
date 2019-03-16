# Projekt - Baza danych obywateli średniowiecznego miasta.

### Maciej Grochowski, Katarzyna Makohon

### 23 czerwca 2018

## 1 Cel

Celem projektu jest pomoc w organizacji i kontroli liczby mieszkańców średniowiecznego quasi-niemieckiego Burgsburgu. Możliwe będzie ustalenie profesji, majątku i miejsca zamieszkania każdego z obywateli oraz sprawdzenie historii jego transakcji. Baza pozwoli na sprawniejsze pobieranie podatków i wyszukiwanie określonych osób.

## 2 Model relacyjny (RM)

Oznaczenia: **Klucz podstawowy**, _Klucz obcy_

1. Persons: (**Id**, Name, Surname, _Houses.Id_ , _Profesion.Name_ , Height, Weight, Date_of_birth, Date_of_death,
    Money, Value)
2. Names: (**Name**, Gender)
3. Houses: (**Id**, District, Capacity, Type)
4. Items: (**Name**, Value, Description)
5. Owners: ( _Items.Name_ , _Persons.Id_ )
6. Transaction: ( **_Customer.Id_** , **_Provider.Id_** , Amount)
7. Proffesions: (**Name**, Salary)
8. Production: ( **_Proffesions.Name_** , **_Items.Name_** )

## 3 Opis funkcjonalności

- Dodanie nowego obywatela oraz modyfikacja jego danych.
- Dodanie nowego przedmiotu oraz modyfikacja jego danych.
- Dodanie nowej profesji oraz modyfikacja przedmiotów jakie wytwarza.
- Dodanie nowego budynku.
- Odnotowywanie usług świadczonych przez jednych mieszkańców miasta innym.
- Wypłacanie żołdu osobom pracującym w konkretnych profesjach.
- Pobieranie podatków od obywateli.
- Wygnanie obywatela.
- Obsługa więzienia. (Wtrącanie, zwalnianie z więzienia.)
- Obsługa koszar. (Pobór wojskowy, zwolnienie ze służby.)
- Obsługa cmentarza.

## 4 Logika Bazy

- Zapisana do bazy może zostać tylko osoba o wieku większym niż 14 lat.
- Osoba nie może mieć ujemnej ilości pieniędzy.
- Osoba nie może posiadać imienia spoza puli imion.
- Nie istnieje jednostka pieniężna mniejsza od jednej monety.
- Istnieją osoby bez przedmiotów.
- Istnieją przedmioty bez osób.
- Istnieją domy bez osób.
- Nie istnieją osoby bez domów.
- Do domu nie może być przypisane więcej osób niż ”maksymalna liczba osób”.
- Osoba w więzieniu i martwa(której domem jest cmentarz) nie może wytwarzać przedmiotów ani
    wykonywać usług.
- Od osób w więzieniu i martwych nie są pobierane podatki.
- Domy przydzielane są obywatelom przez radę miasta.
- Istnieją domy różnych typów. Niektóre z nich są dostęne tylko dla osób o określonej majętności.
- Cmentarz i Więzienie to domy, mogą więc ulec przepełnieniu.
- W wypadku przepełnienia Cmentarza z bazy usuwana jest osoba o najdawniejszej dacie śmierci.
- W przypadku przepełnienia Więzienia osoba, która ma zostać skazana zostaje wydalona z miasta.
- Most nie może ulec przepełnieniu.
- Po śmierci obywatela jego dobra przejmuje miasto.
- Każda profesja ma określone przedmioty, które jest w stanie wykonać.
- Istnieje jeden cmentarz, jedne koszary i jedno więzienie.
- Osoba nie może ważyć więcej niż 255 kg i mierzyć więcej niż 255cm.
- Mieszkańcy mogą się przeprowadzać.
- Mieszkańcy mogą handlować przedmiotami między sobą a miastem.
- Każda profesja albo wytwarza chociaż jeden typ przedmiotu, albo pracuje za żołd.
- Mieszkańcy nie mogą między sobą handlować bez udziału miasta.
- Mieszkańcy mogą wykonywać dla siebie usługi, co zostanie uznane za transakcje.
- Przechowywana powinna być lista wszystkich wykonanych transakcji.
- Osoba wygnana ma prawo przekazać swoje przedmioty dowolnej innej osobie, która jest obywa-
    telem miasta.
- Po powrocie z koszar osoba otrzymuje odprawę i zamieszkuje od tej chwili jedną z posiadłości.
- Osoba niezdolna do zapłacenia podatku (zbyt mała ilość pieniędzy) jest zabijana.
