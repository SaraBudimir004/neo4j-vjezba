//Korak1


Neo4j koristi dva porta:
    7474 - HTTP port za Neo4j Browser (web sučelje - pisanje i vizualiziranje Cypher upita)
    7687 - Bolt port za aplikacije i driver konekcije (Python, Java, JavaScript...)

//Korak2


CREATE uvijek napravi novi čvor ili vezu, čak i ako isti već postoji u bazi, pa može doći do duplikata. MERGE prvo provjeri postoji li već takav čvor ili veza, i ako postoji koristi ga, a ako ne postoji onda ga kreira. MERGE se koristi kada želimo izbjeći duplikate u bazi.

//Korak4/ Zadatak 4 (17)


MATCH se koristi za traženje podataka u grafu i vraća samo one čvorove i veze koji stvarno postoje i odgovaraju uvjetu koji smo zadali. 
OPTIONAL MATCH radi slično, ali će vratiti i čvorove koji nemaju povezane podatke, pa će za njih prikazati prazno ili null. 
Npr, MATCH (o)-[:REZIRAO]->(f) prikazuje samo osobe koje su režirale film, dok OPTIONAL MATCH prikazuje sve osobe čak i ako nemaju nijedan film povezan s njima.

//Korak5 / Zadatak5 (21)


Ako shortestPath ne pronađe put između dva čvora, znači da ti čvorovi nisu povezani kroz graf ili je put predug pa ga Neo4j ne može naći u zadanom ograničenju. U tom slučaju upit ne vraća nikakav put, nego prazan rezultat (ništa se ne prikaže).


// ZAVRSNI ZADATAK


Koristila bi Neo4j umjesto PostgreSQL-a kada imam podatke koji su jako povezani, kao u glazbenoj bazi. Na primjer, izvođači su povezani s albumima, žanrovima i drugim izvođačima kroz različite veze. 
U takvim slučajevima graf baza je prirodnija jer se odnosi između podataka mogu odmah vidjeti i lako pratiti.

Neo4j je posebno dobar za stvari kao što su preporuke, npr. “koje albume slušati ako mi se sviđa neki izvođač”. Također je dobar za pronalazak sličnosti između izvođača ili za traženje putova povezanosti, kao npr. kako su dva izvođača povezana kroz suradnje ili zajedničke veze.

U relacijskim bazama kao što je PostgreSQL to bi bilo teže jer bi se moralo koristiti puno JOIN-ova, što može postati sporo i komplicirano. Graf baza to rješava jednostavnije jer direktno prati veze između čvorova. Zato je Neo4j bolji kada je glavni fokus na odnosima i povezanosti podataka, a ne samo na tablicama.
