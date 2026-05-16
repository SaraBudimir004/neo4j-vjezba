// Korak 2 - Filmovi
CREATE (f1:Film {naslov: 'Inception', godina: 2010, ocjena: 8.8, zanr: 'sci-fi'})
CREATE (f2:Film {naslov: 'The Dark Knight', godina: 2008, ocjena: 9.0, zanr: 'akcija'})
CREATE (f3:Film {naslov: 'Interstellar', godina: 2014, ocjena: 8.6, zanr: 'sci-fi'})
CREATE (f4:Film {naslov: 'Parasite', godina: 2019, ocjena: 8.6, zanr: 'triler'})
CREATE (f5:Film {naslov: 'The Godfather', godina: 1972, ocjena: 9.2, zanr: 'drama'})
CREATE (f6:Film {naslov: 'Memento', godina: 2000, ocjena: 8.4, zanr: 'triler'})

// Korak 2 - Osobe
CREATE (o1:Osoba {ime: 'Christopher Nolan', dob: 54})
CREATE (o2:Osoba {ime: 'Bong Joon-ho', dob: 55})
CREATE (o3:Osoba {ime: 'Francis Ford Coppola', dob: 85})
CREATE (o4:Osoba {ime: 'Leonardo DiCaprio', dob: 50})
CREATE (o5:Osoba {ime: 'Christian Bale', dob: 50})

// Korak 2 - Gradovi
CREATE (g1:Grad {naziv: 'Los Angeles'})
CREATE (g2:Grad {naziv: 'London'})
CREATE (g3:Grad {naziv: 'Seoul'})

// Zadatak 2 
6. Dodavanje 2 Osobe
CREATE (o6:Osoba {ime: 'Rade Šerbedžija', dob: 78})
CREATE (o7:Osoba {ime: 'Goran Višnjić', dob: 52})
7. Dodavanje grada
CREATE (g4:Grad {naziv: 'Split'})

// Korak 3 - Kreiranje veza REZIRAO
MATCH (o:Osoba {ime: 'Christopher Nolan'}), (f:Film {naslov: 'Inception'})
CREATE (o)-[:REZIRAO]->(f)

MATCH (o:Osoba {ime: 'Christopher Nolan'}), (f:Film {naslov: 'The Dark Knight'})
CREATE (o)-[:REZIRAO]->(f)

MATCH (o:Osoba {ime: 'Christopher Nolan'}), (f:Film {naslov: 'Interstellar'})
CREATE (o)-[:REZIRAO]->(f)

MATCH (o:Osoba {ime: 'Christopher Nolan'}), (f:Film {naslov: 'Memento'})
CREATE (o)-[:REZIRAO]->(f)

MATCH (o:Osoba {ime: 'Bong Joon-ho'}), (f:Film {naslov: 'Parasite'})
CREATE (o)-[:REZIRAO]->(f)

MATCH (o:Osoba {ime: 'Francis Ford Coppola'}), (f:Film {naslov: 'The Godfather'})
CREATE (o)-[:REZIRAO]->(f)


// Korak3 - Kreiranje veza GLUMIO_U
MATCH (o:Osoba {ime: 'Leonardo DiCaprio'}), (f:Film {naslov: 'Inception'})
CREATE (o)-[:GLUMIO_U]->(f)

MATCH (o:Osoba {ime: 'Christian Bale'}), (f:Film {naslov: 'The Dark Knight'})
CREATE (o)-[:GLUMIO_U]->(f)

// Korak3 - Kreiranje veza ZIVI_U:
MATCH (o:Osoba {ime: 'Christopher Nolan'}), (g:Grad {naziv: 'London'})
CREATE (o)-[:ZIVI_U]->(g)

MATCH (o:Osoba {ime: 'Leonardo DiCaprio'}), (g:Grad {naziv: 'Los Angeles'})
CREATE (o)-[:ZIVI_U]->(g)

MATCH (o:Osoba {ime: 'Bong Joon-ho'}), (g:Grad {naziv: 'Seoul'})
CREATE (o)-[:ZIVI_U]->(g)

// Korak3 - Kreiranje veza PRIJATELJ (s property-em)
MATCH (a:Osoba {ime: 'Christopher Nolan'}), (b:Osoba {ime: 'Christian Bale'})
CREATE (a)-[:PRIJATELJ {od: 2000}]->(b)

MATCH (a:Osoba {ime: 'Leonardo DiCaprio'}), (b:Osoba {ime: 'Christopher Nolan'})
CREATE (a)-[:PRIJATELJ {od: 2010}]->(b)

MATCH (n)-[r]->(m) RETURN n, r, m

//Zadatak3 
//GLUMIO_U
MATCH (o:Osoba {ime: 'Rade Šerbedžija'}), (f:Film {naslov: 'The Godfather'})
CREATE (o)-[:GLUMIO_U]->(f)

MATCH (o:Osoba {ime: 'Goran Višnjić'}), (f:Film {naslov: 'Inception'})
CREATE (o)-[:GLUMIO_U]->(f)

//ZIVI_U
MATCH (o:Osoba {ime: 'Rade Šerbedžija'}), (g:Grad {naziv: 'Split'})
CREATE (o)-[:ZIVI_U]->(g)

MATCH ()-[r]->() RETURN type(r) AS tip, count(*) AS broj ORDER BY broj DESC

MATCH (n)-[r]->(m) RETURN n,r,m

//Korak4- MATCH upiti: čitanje i filtriranje

//Svi filmovi u bazi
MATCH (f:Film)
RETURN f.naslov, f.godina, f.ocjena
ORDER BY f.ocjena DESC

//Filmovi s ocjenom većom od 8.7
MATCH (f:Film)
WHERE f.ocjena > 8.7
RETURN f.naslov, f.ocjena
ORDER BY f.ocjena DESC

//Svi filmovi određenog redatelja
MATCH (o:Osoba)-[:REZIRAO]->(f:Film)
WHERE o.ime = 'Christopher Nolan'
RETURN f.naslov, f.godina, f.ocjena
ORDER BY f.godina

//Tko je glumio u sci-fi filmovima
MATCH (o:Osoba)-[:GLUMIO_U]->(f:Film)
WHERE f.zanr = 'sci-fi'
RETURN o.ime AS glumac, f.naslov AS film

//Filmovi i njihovi redatelji — obostrani prikaz
MATCH (o:Osoba)-[:REZIRAO]->(f:Film)
RETURN o.ime AS redatelj, collect(f.naslov) AS filmovi
ORDER BY redatelj

//OPTIONAL MATCH — čvorovi koji možda nemaju vezu:
MATCH (o:Osoba)
OPTIONAL MATCH (o)-[:REZIRAO]->(f:Film)
RETURN o.ime, count(f) AS broj_reziranih_filmova
ORDER BY broj_reziranih_filmova DESC

//Zadata4
//13. filmovi žanra triler
MATCH (f:Film)
WHERE f.zanr = 'triler'
RETURN f.naslov, f.godina, f.ocjena
ORDER BY f.godina ASC

//14. redatelj + grad u kojem živi
MATCH (o:Osoba)-[:REZIRAO]->(f:Film)
MATCH (o)-[:ZIVI_U]->(g:Grad)
RETURN o.ime AS redatelj, g.naziv AS grad

//15. filmovi 2008–2015
MATCH (f:Film)
WHERE f.godina >= 2008 AND f.godina <= 2015
RETURN f.naslov, f.godina
ORDER BY f.godina

//16. redatelji s više od 1 filma
MATCH (o:Osoba)-[:REZIRAO]->(f:Film)
WITH o, count(f) AS brojFilmova
WHERE brojFilmova > 1
RETURN o.ime AS redatelj, brojFilmova

//Korak5 - Varijabilna dužina puta — tko je u dvije veze od filma Inception
MATCH (f:Film {naslov: 'Inception'})-[*1..2]-(n)
RETURN DISTINCT labels(n) AS tip, n.naslov AS naslov, n.ime AS ime

//Korak5 - Najkraći put između dvije osobe
MATCH p = shortestPath(
  (a:Osoba {ime: 'Christopher Nolan'})
  -[*]-
  (b:Osoba {ime: 'Bong Joon-ho'})
)
RETURN p, length(p) AS duljina_puta

//Korak5 - Postoji li direktna veza između dviju osoba:
MATCH (a:Osoba {ime: 'Leonardo DiCaprio'})
MATCH (b:Osoba {ime: 'Christopher Nolan'})
RETURN EXISTS {
  MATCH (a)-[:PRIJATELJ|GLUMIO_U|ZIVI_U*1..3]-(b)
} AS povezani

//Korak5 - Svi putovi između dvije osobe — ne samo najkraći:
MATCH p = (a:Osoba {ime: 'Leonardo DiCaprio'})
          -[*1..4]-
          (b:Osoba {ime: 'Bong Joon-ho'})
RETURN p, length(p) AS duljina
ORDER BY duljina
LIMIT 5

//Zadatak5
//18.Najkraci put
MATCH p = shortestPath(
  (a:Osoba {ime: 'Leonardo DiCaprio'})-[*1..5]-(b:Osoba {ime: 'Bong Joon-ho'})
)
RETURN p, length(p) AS duljina

//19. Cvorovi do 2 veze od Londona
MATCH (g:Grad {naziv: 'London'})-[*1..2]-(n)
RETURN DISTINCT labels(n), n.ime, n.naslov

//20 — provjera povezanosti (4 koraka)
MATCH (a:Osoba {ime: 'Francis Ford Coppola'})
MATCH (b:Osoba {ime: 'Leonardo DiCaprio'})
RETURN EXISTS {
  MATCH (a)-[*1..4]-(b)
} AS povezani