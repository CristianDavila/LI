% Cristian Davila, 1-B

camino(E,E, C,C).
camino(EstadoActual, EstadoFinal, CaminoHastaAhora, CaminoTotal):-
    unPaso(EstadoActual, EstSiguiente),
    \+member(EstSiguiente, CaminoHastaAhora),
    camino(EstSiguiente, EstadoFinal, [EstSiguiente|CaminoHastaAhora], CaminoTotal).

solucionOptima:-
    nat(N),
    camino([[3, 3], [0,0], izq],  [[0, 0], [3,3], dre],  [[[3, 3], [0,0], izq]],  C),
    length(C,N),
    write('Coste: '), write(N), nl,
    write(C).




nat(0).
nat(N):- nat(M), N is M+1.

numeroCorrecto(0,_).
numeroCorrecto(M,C):- M>=C.


unPaso([[Mi, Ci], [Md,Cd], izq], [[Mi2, Ci2], [Md2, Cd2], dre]):-
                    cruzar(Mi,Ci,Md,Cd,Mi2,Ci2,Md2,Cd2).

unPaso([[Mi, Ci], [Md,Cd], dre], [[Mi2, Ci2], [Md2, Cd2], izq]):-
                    cruzar(Md,Cd,Mi,Ci,Md2,Cd2,Mi2,Ci2).


cruzar(Mi,Ci,Md,Cd,Mi2,Ci2,Md2,Cd2):-
                    between(0,2,BarcaM),
                    between(0,2,BarcaC),
                    Barca is BarcaM+BarcaC,
                    Barca =<2,
                    Barca > 0,

                    Mi2 is Mi - BarcaM,
                    Ci2 is Ci - BarcaC,
                    Mi2 >=0,
                    Ci2 >=0,
                    Md2 is Md + BarcaM,
                    Cd2 is Cd + BarcaC,
                    numeroCorrecto(Md2,Cd2),
                    numeroCorrecto(Mi2,Ci2).





