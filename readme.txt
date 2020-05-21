PRZEKAZAC IDEE #roastMyCode jej cele, profity i why so fun

Pytania które sobie zadamy:
- co tu testować ? Jakimi testami? @SmartTesting ? Podpytać @korol
- gdzie uzyc jakich patternow
- czy moze calkiem przeorganizowac strukture kodu
- jak obslugiwac bledy / railway oriented programming ?






#Cel gry:
  Wykonać 10 poprawnych sztagów.


#Możliwe errory
  1)  W momencie próby wykonania operacji na żaglu: Kausza na żaglu zepsuta  - na kazdym zaglu po 10 wybraniach ( pull, haul )
   a na foku dodatkowo losowo z prawdopodobienstwem 20%
  (jezeli się przyda to kolejne sprawdzenie do fixa ma zwracac info ze zepusty) - trzeba naparwić
  2) W momencie próby wykonania operacji na żaglu: Morale załoganta sa za niskie zagiel nie daje się wybrać,  fok: < 3, grot < 2, bezan - zawsze spoko - Skipper może go "zmotywować".
  3) W momencie próby wykonania operacji na sterze : Morale sternika sa za niske, nie daje rady skręcić sterem (morale < 2) "nie działa" - Skipper może go "zmotywować".
  4) Crewman nie usłyszał - trzeba powtórzyć komende (Steerman, ForeSailMan, MainSailMan, MizzenSailMan)
    - MizzenMail z prawdopodienstwem 40%, reszta 20%
  5) Każda komenda wykonana przez załoganta zmniejsza jego morale o 1. Początkowe morale każdego załoganta to 5


#Feature'y gry
Boat
  - załoga jest dopisana do łodzi, to samo takielunek
Crew:
    - musi zagrgować odpowiedzi od wszystkich załogantów i zwrócic info czy jest OK
Steerman, ForeSailMan, MainSailMan, MizzenMan:
    - załogant, wykonujący komendy i odpowiadający na nie, zgłaszający problemy w trakcie wykonywania poszczegołnych komend
Steer:
    - ster, może mięc 3 stany: wychylony na skręcoanie w lewo, prawo i 0
Left/Right JibSheet , MainSail, MizzenSail:
    - może być wybierany do pracy( haul ), wybierany na blache ( pull ),
luzowany całkiem ( release ), luzowany do pracy ( loosen ). Zwraca informację o swoim działaniu lub błędzie w działaniu
Bosun
   - może naprawiać elementy: Kausza
Skipper
  - może motywować załogna, przywracając jego morale do 5





#Założenia dot. przyszłego rozwoju gry:
  - załoganci mogą się różnić - różny % awaryjności, mdlenia itp
  - skipper decyduje o wymieniau załogantów
  - każdy żagiel otrzymuje inną kausze której naprawa ma inną logikę
  - # na duzych zaglowcach warto dodać bosmana jako proxy ktory odpowiada za przekazanie komendy odpowiedniemu załogantowi
    # dodatkowo kazdy zagiel posiada oficera + całą wachte do żagla - tam też stosujemy proxy


Założenia manewru: ( takie komendy muszą zostać wydane i wykonane )
* (Załoga)Do zwrotu przez sztag!
* (Steerman)Ster prawo!
* (Bezanman) bezana szot wybierz!
* (Fokman)Lewy foka szot luz!
* (Grotman) grota szot luz!
* (Bezanman) Bezana szot luz!
* (Bezanman) Bezana szot wybieraj!
* (Grotman) grota szot wybieraj!
* (Fokman)Prawy foka szot wybieraj!
* (Steerman)Ster zero!
* (Steerman)Sternik tak trzymać!



