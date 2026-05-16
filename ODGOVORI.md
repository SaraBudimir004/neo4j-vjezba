Korak1
Neo4j koristi dva porta:
    7474 - HTTP port za Neo4j Browser (web sučelje - pisanje i vizualiziranje Cypher upita)
    7687 - Bolt port za aplikacije i driver konekcije (Python, Java, JavaScript...)

Korak2
CREATE uvijek napravi novi čvor ili vezu, čak i ako isti već postoji u bazi, pa može doći do duplikata. MERGE prvo provjeri postoji li već takav čvor ili veza, i ako postoji koristi ga, a ako ne postoji onda ga kreira. MERGE se koristi kada želimo izbjeći duplikate u bazi.
