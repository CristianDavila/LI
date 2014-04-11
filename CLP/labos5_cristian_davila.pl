:- use_module(library(clpfd)).

% Cristian Davila Carmona

% ============= Sudoku

exemple :- sudoku([ 6 ,_ ,_ ,4 ,2 ,_ ,_ ,3 ,_,
_ ,_ ,_ ,8 ,_ ,_ ,_ ,_ ,_,
_ ,_ ,7 ,_ ,3 ,_ ,_ ,_ ,_,
7 ,_ ,2 ,9 ,_ ,_ ,_ ,1 ,_,
_ ,9 ,_ ,_ ,7 ,_ ,6 ,_ ,_,
_ ,_ ,6 ,_ ,_ ,_ ,_ ,_ ,2,
_ ,7 ,_ ,_ ,4 ,_ ,_ ,8 ,_,
_ ,_ ,_ ,7 ,_ ,_ ,_ ,_ ,_,
_ ,6,_ ,_,9 ,_ ,_ ,_ ,_
            ]).

sudoku(L) :-
        L = [X11, X12, X13, X14, X15, X16, X17, X18, X19,
             X21, X22, X23, X24, X25, X26, X27, X28, X29,
             X31, X32, X33, X34, X35, X36, X37, X38, X39,
             X41, X42, X43, X44, X45, X46, X47, X48, X49,
             X51, X52, X53, X54, X55, X56, X57, X58, X59,
             X61, X62, X63, X64, X65, X66, X67, X68, X69,
             X71, X72, X73, X74, X75, X76, X77, X78, X79,
             X81, X82, X83, X84, X85, X86, X87, X88, X89,
             X91, X92, X93, X94, X95, X96, X97, X98, X99],

        L ins 1..9,
        % Files.
        Fila1 = [X11,X12,X13,X14,X15,X16,X17,X18,X19], all_different(Fila1),
        Fila2 = [X21,X22,X23,X24,X25,X26,X27,X28,X29], all_different(Fila2),
        Fila3 = [X31,X32,X33,X34,X35,X36,X37,X38,X39], all_different(Fila3),
        Fila4 = [X41,X42,X43,X44,X45,X46,X47,X48,X49], all_different(Fila4),
        Fila5 = [X51,X52,X53,X54,X55,X56,X57,X58,X59], all_different(Fila5),
        Fila6 = [X61,X62,X63,X64,X65,X66,X67,X68,X69], all_different(Fila6),
        Fila7 = [X71,X72,X73,X74,X75,X76,X77,X78,X79], all_different(Fila7),
        Fila8 = [X81,X82,X83,X84,X85,X86,X87,X88,X89], all_different(Fila8),
        Fila9 = [X91,X92,X93,X94,X95,X96,X97,X98,X99], all_different(Fila9),

        % Columnes.
        Columna1 = [X11,X21,X31,X41,X51,X61,X71,X81,X91], all_different(Columna1),
        Columna2 = [X12,X22,X32,X42,X52,X62,X72,X82,X92], all_different(Columna2),
        Columna3 = [X13,X23,X33,X43,X53,X63,X73,X83,X93], all_different(Columna3),
        Columna4 = [X14,X24,X34,X44,X54,X64,X74,X84,X94], all_different(Columna4),
        Columna5 = [X15,X25,X35,X45,X55,X65,X75,X85,X95], all_different(Columna5),
        Columna6 = [X16,X26,X36,X46,X56,X66,X76,X86,X96], all_different(Columna6),
        Columna7 = [X17,X27,X37,X47,X57,X67,X77,X87,X97], all_different(Columna7),
        Columna8 = [X18,X28,X38,X48,X58,X68,X78,X88,X98], all_different(Columna8),
        Columna9 = [X19,X29,X39,X49,X59,X69,X79,X89,X99], all_different(Columna9),

        % Quadrats 3x3.
        Quadrat1 = [X11,X21,X31,X12,X22,X32,X13,X23,X33], all_different(Quadrat1),
        Quadrat2 = [X14,X24,X34,X15,X25,X35,X16,X26,X36], all_different(Quadrat2),
        Quadrat3 = [X17,X27,X37,X18,X28,X38,X19,X29,X39], all_different(Quadrat3),
        Quadrat4 = [X41,X51,X61,X42,X52,X62,X43,X53,X63], all_different(Quadrat4),
        Quadrat5 = [X44,X54,X64,X45,X55,X65,X46,X56,X66], all_different(Quadrat5),
        Quadrat6 = [X47,X57,X67,X48,X58,X68,X49,X59,X69], all_different(Quadrat6),
        Quadrat7 = [X71,X81,X91,X72,X82,X92,X73,X83,X93], all_different(Quadrat7),
        Quadrat8 = [X74,X84,X94,X75,X85,X95,X76,X86,X96], all_different(Quadrat8),
        Quadrat9 = [X77,X87,X97,X78,X88,X98,X79,X89,X99], all_different(Quadrat9),

        label(L),

        pinta(L).

pinta(L):- pinta_aux(L, 9).

pinta_aux([], _).
pinta_aux(L, 0):-
        L\=[],  nl,  pinta_aux(L, 9).
pinta_aux([X|L], N):-
        N>0,  write(X),  write(' '),
        N1 is N-1,  pinta_aux(L, N1).


% ============= Examen Final


china:- L = [A,B,C,D,E,F],
        L ins 0..80, 1*A + 2*B + 3*C + 5*D + 6*E + 7*F #=< 80,
        labeling( [ max( 1*A + 4*B + 7*C +11*D + 14*E + 15*F ) ], L), write(L), nl, !.



% ============= MONEY


sendMoreMoney :-
     X = [S,E,N,D,M,O,R,Y],
     X ins 0..9,
     M #> 0, S #> 0,
     1000*S + 100*E + 10*N + D + 1000*M + 100*O + 10*R + E #=
     10000*M + 1000*O + 100*N + 10*E + Y,
     all_different(X), label(X),
     write('Lletra M: '), write(M), nl,
     write('Lletra O: '), write(O), nl,
     write('Lletra N: '), write(N), nl,
     write('Lletra E: '), write(E), nl,
     write('Lletra Y: '), write(Y).

% ============== tareas
% Letra indica tarea, numero indica PC: A1 indica la tarea A en el pc 1


tasks :-
        L = [A1, A2, A3, A4, A5,
            B1, B2, B3, B4, B5,
            C1, C2, C3, C4, C5,
            D1, D2, D3, D4, D5,
            E1, E2, E3, E4, E5,
            F1, F2, F3, F4, F5,
            G1, G2, G3, G4, G5,
            H1, H2, H3, H4, H5,
            I1, I2, I3, I4, I5,
            J1, J2, J3, J4, J5,
            K1, K2, K3, K4, K5,
            L1, L2, L3, L4, L5,
            M1, M2, M3, M4, M5,
            N1, N2, N3, N4, N5],

        L ins 0..1,

        8*A1 + 6*B1 + 7*C1 + 5*D1 + 2*E1 + 3*F1 + 8*G1 + 6*H1 + 2*I1 + 6*J1 + 1*K1 + 2*L1 + 6*M1 + 4*N1 #< K,
        8*A2 + 6*B2 + 7*C2 + 5*D2 + 2*E2 + 3*F2 + 8*G2 + 6*H2 + 2*I2 + 6*J2 + 1*K2 + 2*L2 + 6*M2 + 4*N2 #< K,
        8*A3 + 6*B3 + 7*C3 + 5*D3 + 2*E3 + 3*F3 + 8*G3 + 6*H3 + 2*I3 + 6*J3 + 1*K3 + 2*L3 + 6*M3 + 4*N3 #< K,
        8*A4 + 6*B4 + 7*C4 + 5*D4 + 2*E4 + 3*F4 + 8*G4 + 6*H4 + 2*I4 + 6*J4 + 1*K4 + 2*L4 + 6*M4 + 4*N4 #< K,
        8*A5 + 6*B5 + 7*C5 + 5*D5 + 2*E5 + 3*F5 + 8*G5 + 6*H5 + 2*I5 + 6*J5 + 1*K5 + 2*L5 + 6*M5 + 4*N5 #< K,

        K in 0..66,

        A1 + A2 + A3 + A4 + A5 #= 1,
        B1 + B2 + B3 + B4 + B5 #= 1,
        C1 + C2 + C3 + C4 + C5 #= 1,
        D1 + D2 + D3 + D4 + D5 #= 1,
        E1 + E2 + E3 + E4 + E5 #= 1,
        F1 + F2 + F3 + F4 + F5 #= 1,
        G1 + G2 + G3 + G4 + G5 #= 1,
        H1 + H2 + H3 + H4 + H5 #= 1,
        I1 + I2 + I3 + I4 + I5 #= 1,
        J1 + J2 + J3 + J4 + J5 #= 1,
        K1 + K2 + K3 + K4 + K5 #= 1,
        L1 + L2 + L3 + L4 + L5 #= 1,
        M1 + M2 + M3 + M4 + M5 #= 1,
        N1 + N2 + N3 + N4 + N5 #= 1,


        labeling( [ min( K ) ], [K|L]),

        List1 = [A1 , B1 , C1 , D1 , E1 , F1 , G1 , H1 , I1 , J1 , K1 , L1 , M1 , N1 ],
        List2 = [A2 , B2 , C2 , D2 , E2 , F2 , G2 , H2 , I2 , J2 , K2 , L2 , M2 , N2 ],
        List3 = [A3 , B3 , C3 , D3 , E3 , F3 , G3 , H3 , I3 , J3 , K3 , L3 , M3 , N3 ],
        List4 = [A4 , B4 , C4 , D4 , E4 , F4 , G4 , H4 , I4 , J4 , K4 , L4 , M4 , N4 ],
        List5 = [A5 , B5 , C5 , D5 , E5 , F5 , G5 , H5 , I5 , J5 , K5 , L5 , M5 , N5 ],
        write(List1), nl,
        write(List2), nl,
        write(List3), nl,
        write(List4), nl,
        write(List5), nl,!.









