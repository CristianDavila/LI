% Cristian Davila, Ex 2

datosEjemplo( [[1,2,6],[1,6,7],[2,3,8],[6,7,9],[6,8,9],[1,2,4],[3,5,6],[3,5,7],
[5,6,8],[1,6,8],[4,7,9],[4,6,9],[1,4,6],[3,6,9],[2,3,5],[1,4,5],
[1,6,7],[6,7,8],[1,2,4],[1,5,7],[2,5,6],[2,3,5],[5,7,9],[1,6,8]] ).



camino( EstadoActual,EstadoActual,[],N ):-
        longitud(EstadoActual,LONG),
        N = LONG.

camino( EstadoActual, EstadoFinal, [ListaActual|D], N):-
        longitud(EstadoActual,LONG),
        N >= LONG,
        afegirASlots(EstadoActual,ListaActual,EstSiguiente),
        camino( EstSiguiente, EstadoFinal, D, N).


nat(0).
nat(N):- nat(M), N is M+1.


solucionOptima:-
    nat(N),
    datosEjemplo(D),
    camino([[],[],[]],[A, B, C],D,N),
    longitud([A, B, C],LONG),
    write('Numero de charlas: '), write(LONG), nl, nl,
    write('Grupos en slot A: '), write(A), nl,
    write('Grupos en slot B: '), write(B), nl,
    write('Grupos en slot C: '), write(C).





afegirASlots([SlotA,SlotB,SlotC],[Grup1, Grup2, Grup3],[SlotANew,SlotBNew,SlotCNew]):-
        afegirSlot(Grup1, SlotA, SlotANew),
        afegirSlot(Grup2, SlotB, SlotBNew),
        afegirSlot(Grup3, SlotC, SlotCNew).

afegirASlots([SlotA,SlotB,SlotC],[Grup1, Grup2, Grup3],[SlotANew,SlotBNew,SlotCNew]):-
        afegirSlot(Grup1, SlotA, SlotANew),
        afegirSlot(Grup3, SlotB, SlotBNew),
        afegirSlot(Grup2, SlotC, SlotCNew).


afegirASlots([SlotA,SlotB,SlotC],[Grup1, Grup2, Grup3],[SlotANew,SlotBNew,SlotCNew]):-
        afegirSlot(Grup3, SlotA, SlotANew),
        afegirSlot(Grup1, SlotB, SlotBNew),
        afegirSlot(Grup2, SlotC, SlotCNew).

afegirASlots([SlotA,SlotB,SlotC],[Grup1, Grup2, Grup3],[SlotANew,SlotBNew,SlotCNew]):-
        afegirSlot(Grup3, SlotA, SlotANew),
        afegirSlot(Grup2, SlotB, SlotBNew),
        afegirSlot(Grup1, SlotC, SlotCNew).


afegirASlots([SlotA,SlotB,SlotC],[Grup1, Grup2, Grup3],[SlotANew,SlotBNew,SlotCNew]):-
        afegirSlot(Grup2, SlotA, SlotANew),
        afegirSlot(Grup1, SlotB, SlotBNew),
        afegirSlot(Grup3, SlotC, SlotCNew).

afegirASlots([SlotA,SlotB,SlotC],[Grup1, Grup2, Grup3],[SlotANew,SlotBNew,SlotCNew]):-
        afegirSlot(Grup2, SlotA, SlotANew),
        afegirSlot(Grup3, SlotB, SlotBNew),
        afegirSlot(Grup1, SlotC, SlotCNew).



afegirSlot(Grup, Slot, SlotActualitzat):-
        \+member(Grup,Slot),
        afegir(Grup,Slot,SlotActualitzat).

afegirSlot(Grup, Slot, SlotActualitzat):-
        member(Grup,Slot),
        noActualitza(Slot,SlotActualitzat).




afegir(P1, L, [P1|L]).


noActualitza(L, L).


longitud([A,B,C],Long):-
    length(A,N1),
    length(B,N2),
    length(C,N3),
    Long is N1+N2+N3.
