% Cristian Davila, 1-A

camino(E,E, C,C).
camino(EstadoActual, EstadoFinal, CaminoHastaAhora, CaminoTotal):-
    unPaso(EstadoActual, EstSiguiente),
    \+member(EstSiguiente, CaminoHastaAhora),
    camino(EstSiguiente, EstadoFinal, [EstSiguiente|CaminoHastaAhora], CaminoTotal).

solucionOptima:-
    nat(N),
    camino([0,0],[0,4],[[0,0]],C),
    length(C,N),
    write('Coste: '), write(N), nl,
    write(C).

% , l is length(C), write(l)

% unPaso(EstadoActual, EstSiguiente) estado: [cubo5, cubo8]


nat(0).
nat(N):- nat(M), N is M+1.



unPaso([CUBO5, 0], [CUBO5, 8]).
unPaso([0, CUBO8], [5, CUBO8]).

unPaso([_, CUBO8], [0, CUBO8]).
unPaso([CUBO5, _], [CUBO5, 0]).

unPaso([0, CUBO8], [5, AUX]):- CUBO8 >= 5, AUX is (CUBO8-5).
unPaso([CUBO5, 0], [0, CUBO5]).

unPaso([0, CUBO8], [CUBO8, 0]):- CUBO8 < 5.


unPaso([CUBO5, CUBO8], [AUX, 8]):- (CUBO8+CUBO5) > 8, AUX is ((CUBO8+CUBO5)-8).
unPaso([CUBO5, CUBO8], [0, AUX]):- (CUBO8+CUBO5) < 9, AUX is (CUBO8+CUBO5).


