% Cristian Davila
:-include(entradaHornos).
:-dynamic(varNumber/3).
symbolicOutput(0).


% No he conseguido hacer que funcione el display, he creado otro display para facilitar la correcion
% indicando las horas de inicio y de fin de cada tarea



writeClauses:- restriccions.

restriccions:-

        exactlyOneTaskPerTime,
        timeOfStageActive,
        timeOfOvenActive,
        timeOfRefrigeratorActive,
        atmostThreePerStage,
        atmostTwoTaskOvens,
        atmostOneTaskPerRefrigerator.


restriccions.


% La variable t representa la tasca.
% La variable f representa el forn.
% La variable r representa el refrigerador.
% La variable p representa la plataforma.




exactlyOneTaskPerTime:-
    atLeastOneTaskPlanning, atmostOneTaskPlanning.
exactlyOneTaskPerTime.



atLeastOneTaskPlanning:-
    horastotales(N),
    tarea(T1,H1),
    N1 is N-H1-5-1-1,     % Si N=150, como muy tarde puede empezar en 150-6-H1-1 (vamos de 0 a 149)
    findall( t-T1-Time, between(0, N1, Time), C ), writeClause(C), fail.
atLeastOneTaskPlanning.



atmostOneTaskPlanning:-
            horastotales(N),
            tarea(T1,H1),
            N1 is N-1-H1-5-1,
            between(0, N1, Time1),
            between(0, N1, Time2),            
            Time1 < Time2,
            writeClause( [ \+t-T1-Time1, \+t-T1-Time2] ), fail.
atmostOneTaskPlanning.


atmostTwoTaskOvens:-
            horastotales(N),
            N1 is N-1,
            between(0, N1, Time),    % Siempre empieza por 1, porque los hornos pueden empezar en el instante 1
            tarea(T1,_),
            tarea(T2,_),
            tarea(T3,_),
            T1 < T2, T2 < T3,
            writeClause( [ \+f-T1-Time, \+f-T2-Time, \+f-T3-Time] ), fail.
atmostTwoTaskOvens.



atmostOneTaskPerRefrigerator:-
            horastotales(N),
            N1 is N-1,
            between(0, N1, Time),    % Puede ser 0 o 1, da igual, porque nunca tendremos refrigeradores en ese momento
            tarea(T1,_),
            tarea(T2,_),
            T1 < T2,
            writeClause( [ \+r-T1-Time, \+r-T2-Time] ), fail.
atmostOneTaskPerRefrigerator.



atmostThreePerStage:-
            horastotales(N),
            N1 is N-1,
            between(0, N1, Time),    % Siempre 0, tiene que estar en el inicio
            tarea(T1,_),
            tarea(T2,_),
            tarea(T3,_),
            tarea(T4,_),
            T1 < T2, T2 < T3, T3 < T4,
            writeClause( [ \+p-T1-Time, \+p-T2-Time, \+p-T3-Time, \+p-T4-Time] ), fail.
atmostThreePerStage.



timeOfOvenActive:-
        horastotales(N),
        N1 is N-1,                  % Iremos hasta 149
        tarea(T1,H1),
        between(0, N1, Time),       % El horno empezara como muy pronto en 1
        Time2 is Time+H1,
        Time2 =< N1-5,            % Y empezara como muy tarde en N1 - 5 horas de enfriamiento - Tiempo de Horneado
        Aux is Time+1,
        between(Aux,Time2,TimeOven),
        writeClause( [ \+t-T1-Time, f-T1-TimeOven] ), fail.

timeOfOvenActive.


timeOfStageActive:-
        horastotales(N),
        N1 is N-1,
        tarea(T1,H1),
        between(0, N1, Time),
        Time2 is Time+1+H1+5-1,
        Time2 =< N1,
        between(Time,Time2,TimeStage),
        writeClause( [ \+t-T1-Time, p-T1-TimeStage] ), fail.
timeOfStageActive.



timeOfRefrigeratorActive:-
        horastotales(N),
        N1 is N-1,
        tarea(T1,H1),
        between(0, N1, Time),
        TimeMaxRefr is Time+1+H1+5-1,
        TimeMaxRefr =< N1,
        Aux is Time + H1 + 1,
        between(Aux,TimeMaxRefr,TimeRefr),
        writeClause( [ \+t-T1-Time, r-T1-TimeRefr] ), fail.

timeOfRefrigeratorActive.




% El display saca las tareas en orden de inicio, indicando el tiempo de horno, el de inicio y el de final por tarea

displaySol(M):-

        write('SOL'), nl, tareasPendientes(TareasPendientes),        
        write('Plataforma 1: '), escribirPlataforma(M, TareasPendientes, PendientesAct), nl,        
        write('Plataforma 2: '), escribirPlataforma(M, PendientesAct, PendientesAct2), nl,        
        write('Plataforma 3: '), escribirPlataforma(M, PendientesAct2, _).
displaySol(_):- nl.


escribirPlataforma(M,Pendientes, PendientesAct):-
        horastotales(N),
        escribirTarea(M,0,N,Pendientes, PendientesAct).
escribirPlataforma.


escribirTarea(_,Time,N,Pendientes, Pendientes):- Time == N.

escribirTarea(M,Time,N,Pendientes, PendientesAct):-
            Time < N,
            member(V, M),
            num2var(V, t-ID-Time),
            member(ID, Pendientes),
            tarea(ID,H),
            escribirHorno(H),
            elimina(ID, Pendientes,PendientesAct2),
            Time2 is Time+1+H+5,
            escribirTarea(M,Time2,N,PendientesAct2, PendientesAct).

escribirTarea(M,Time,N,Pendientes, PendientesAct):-
            Time < N,
            member(V, M),            
            \+num2var(V, t-_-Time),
            write(' '),
            Time2 is Time+1,
            escribirTarea(M,Time2,N,Pendientes, PendientesAct).



tareasPendientes(TareasPendientes):- findall(T, tarea(T, _), TareasPendientes).

elimina(X,[X|T],T).
elimina(X,[H|T],[H|T1]):- elimina(X,T,T1).



% Para escribir tarea, seguira el siguiente formato:
% 'c' significa el tiempo de carga, 'h' las horas en el horno, y 'r' el tiempo en refrigerador
% Ejemplo: 'chhhhhhhhhhrrrrr' (indica 1 hora de carga, 10 de horno y 5 de refrigerador)
% Tambien saldra la hora de inicio y de final



% Escribe en formato 'chhhhhhhhhhrrrrr'

escribirHorno(H):-
     write('c'), between(1,H,I), write('h'), I==H, write('rrrrr'),  !.
     % write('c'), write(H), write('r'),  !.
escribirHorno.


% ========== No need to change the following: =====================================

main:- symbolicOutput(1), !, writeClauses, halt. % escribir bonito, no ejecutar
main:-  assert(numClauses(0)), assert(numVars(0)),
        tell(clauses), writeClauses, told,
        tell(header),  writeHeader,  told,
        unix('cat header clauses > infile.cnf'),
        unix('picosat -v -o model infile.cnf'),
        unix('cat model'),
        see(model), readModel(M), seen, displaySol(M),
        halt.

var2num(T,N):- hash_term(T,Key), varNumber(Key,T,N),!.
var2num(T,N):- retract(numVars(N0)), N is N0+1, assert(numVars(N)), hash_term(T,Key),
        assert(varNumber(Key,T,N)), assert( num2var(N,T) ), !.

writeHeader:- numVars(N),numClauses(C),write('p cnf '),write(N), write(' '),write(C),nl.

countClause:-  retract(numClauses(N)), N1 is N+1, assert(numClauses(N1)),!.
writeClause([]):- symbolicOutput(1),!, nl.
writeClause([]):- countClause, write(0), nl.
writeClause([Lit|C]):- w(Lit), writeClause(C),!.
w( Lit ):- symbolicOutput(1), write(Lit), write(' '),!.
w(\+Var):- var2num(Var,N), write(-), write(N), write(' '),!.
w(  Var):- var2num(Var,N),           write(N), write(' '),!.
unix(Comando):-shell(Comando),!.
unix(_).

readModel(L):- get_code(Char), readWord(Char,W), readModel(L1), addIfPositiveInt(W,L1,L),!.
readModel([]).

addIfPositiveInt(W,L,[N|L]):- W = [C|_], between(48,57,C), number_codes(N,W), N>0, !.
addIfPositiveInt(_,L,L).

readWord(99,W):- repeat, get_code(Ch), member(Ch,[-1,10]), !, get_code(Ch1), readWord(Ch1,W),!.
readWord(-1,_):-!, fail. %end of file
readWord(C,[]):- member(C,[10,32]), !. % newline or white space marks end of word
readWord(Char,[Char|W]):- get_code(Char1), readWord(Char1,W), !.
%========================================================================================
