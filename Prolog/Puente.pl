% Cristian Davila, 1-C

camino(E,E, C,C).
camino(EstadoActual, EstadoFinal, CaminoHastaAhora, CaminoTotal):-
    unPaso(EstadoActual, EstSiguiente),
    \+member(EstSiguiente, CaminoHastaAhora),
    camino(EstSiguiente, EstadoFinal, [EstSiguiente|CaminoHastaAhora], CaminoTotal).

solucionOptima:-
    nat(N),
    camino([[1,2,5,8], [], 0 , izq],  [[], [1,2,5,8] , N, dre], [[1,2,5,8], [], 0 , izq], C),
    write('Tiempo: '), write(N), nl,write(C).



nat(0).
nat(N):- nat(M), N is M+1.





% cruzan 2
unPaso([Lista1, Lista2, C, izq], [Lista1Act, Lista2Act, CAct, dre]):-
                            member(P1, Lista1),
                            member(P2, Lista1),
                            cruzarDos(P1, P2, Lista1, Lista2, Lista1Act, Lista2Act),
                            max(P1,P2, Y),
                            CAct is C + Y.




% cruza 1 solo

unPaso([Lista1, Lista2, C, dre], [Lista1Act, Lista2Act, CAct, izq]):-
                            member(P1, Lista2),
                            cruzarUno(P1,  Lista2, Lista1, Lista2Act, Lista1Act),
                            CAct is C + P1.




cruzarDos(P1, P2, Lista1, Lista2, Lista1Act, Lista2Act):-
                            eliminar( P1, Lista1, Lista1Aux),
                            eliminar( P2, Lista1Aux, Lista1Act),
                            afegir(P2, Lista2, Lista2Aux),
                            afegir(P1, Lista2Aux, Lista2Act).

cruzarUno(P1, Lista1, Lista2, Lista1Act, Lista2Act):-
                            eliminar( P1, Lista1, Lista1Act),
                            afegir(P1, Lista2, Lista2Act).



eliminar( P1, [P1|L], L).
eliminar( P1, [X|L], [X|L1]):- eliminar( P1, L, L1).

afegir(P1, L, [P1|L]).


max(X,Y,X):- X>=Y.
max(X,Y,Y):- X<Y.

min(X,Y,X):- X=<Y.
min(X,Y,Y):- X>Y.


