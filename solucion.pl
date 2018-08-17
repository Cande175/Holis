%originarioDe(Genero,Pais).
originarioDe(tango,argentina).
originarioDe(chacarera, argentina).
originarioDe(enka, japon).
originarioDe(deathMetalMelodico, suecia).
originarioDe(celta, europaOccidental).
originarioDe(popLatino, latinoamerica).

%pais(Pais,Region).
pais(noruega, escandinavia).
pais(dinamarca, escandinavia).
pais(suecia, escandinavia).
pais(suecia, europaOccidental).
pais(alemania, europaOccidental).
pais(argentina, latinoamerica).
pais(colombia, latinoamerica).
pais(argentina, tercerMundo).

% produccon(Artista, Trabajo)
produccion(piazzolla, disco(tango,10,acmeMusic) ). 
produccion(goyeneche, disco(tango,10,acmeMusic) ). 
produccion(leonGieco, disco(rock, 12, utnMusic)).
produccion(darkTranquility, recital(argentina, [deathMetalMelodico, celta])).
produccion(faun, disco(folk, 45, deustcheMusic)).
produccion(faun, homenaje(goyeneche)).
produccion(sayuriIshikawa, homenaje(mercedesSosa)).
produccion(sayuriIshikawa, recital(japon, [enka])).
produccion(shakira, disco(popLatino, 10, antonitoMusic)).
produccion(shakira, disco(popLatino, 5, piqueMusic)).
produccion(mercedesSosa, disco(chacarera, 20, acmeMusic)).

%artista(Artista, Pais)
artista(piazzolla, argentina).
artista(leonGieco, argentina).
artista(darkTranquility, suecia).
artista(faun, alemania).
artista(sayuriIshikawa, japon).
artista(shakira, colombia).
artista(mercedesSosa, argentina).
artista(goyeneche, polonia). 

%discografica(Discografica,Pais).
discografica(utnMusic, argentina).
discografica(deustcheMusic, alemania).

%Punto 1

seEscuchaEn(Genero,Lugar):-
    originarioDe(Genero,Lugar).

seEscuchaEn(Genero,Lugar):-
    pais(Lugar,Region),
    originarioDe(Genero,Region).

%Punto 2

fomentaLaCulturaDe(Artista,Pais):-
    produccion(Artista, disco(Genero,_,_)),
    seEscuchaEn(Genero,Pais). 

fomentaLaCulturaDe(Artista,Pais):-
    produccion(Artista,disco(_,_,Discografica)),   
    discografica(Discografica,Pais).

fomentaLaCulturaDe(Artista,Pais):-
  produccion(Artista, recital(_,ListaGeneros)),
  seEscuchaEn(Genero,Pais),
  member(Genero,ListaGeneros).
    
fomentaLaCulturaDe(Artista, Pais):-
    produccion(Artista, recital(Pais,_)).

fomentaLaCulturaDe(Artista,Pais):-
    produccion(Artista,homenaje(Persona)),
    artista(Persona,Pais).

fomentaLaCulturaDe(Artista,Pais):-
    produccion(Artista,homenaje(Persona)),
    fomentaLaCulturaDe(Persona,Pais).

    
%Punto 3
paisMulticultural(Pais):-
    masDeTres(Pais),
    artista(Artista,Pais),
    fomentaLaCulturaDe(Artista,Pais).

masDeTres(Pais):-
    findall(Genero,originarioDe(Genero,Pais),ListaGeneros),
    length(ListaGeneros,Cantidad),
    Cantidad > 3.


%Punto 4
referenteMusical(P1,P2):-
    tieneTodos(P1,P2),
    not(tieneTodos(P1,P1)).

tieneTodos(P1,P2):-
    findall(Genero,originarioDe(Genero,P1),LGeneros1),
    forall(originarioDe(Generos,P2),member(Generos,LGeneros1)).  

    
/*
a- El predicado mencionado es completamente inversible. 

fomentaLaCulturaDe(Artista,Pais).
Artista = piazzolla,
Pais = argentina ;
Artista = goyeneche,
Pais = argentina ;
Artista = shakira,
.
.
.
Artista = sayuriIshikawa,
Pais = argentina ;
false.

c- Ya que Prolog trabaja con hechos y sólo lo declarado como tal es verdadero. Por lo tanto, como no existe un artista con el nombre de "rataBlanca" es imposible que el predicado fomentaLaCulturaDe(rataBlanca, argentina) sea verdadero ya que "rataBlanca" no existe para Prolog.

*/
    
 