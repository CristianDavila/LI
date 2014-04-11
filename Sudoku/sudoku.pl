% ==Cristian Davila
:-include(jocs/sud78).
:-dynamic(varNumber/3).
symbolicOutput(0). % set to 1 to see symbolic output only; 0 otherwise.

writeClauses:- completeClauses, atleastOneVarPerCell, atmostOneVarPerCell, uniqueVarInRow, uniqueVarInColumn, uniqueVarInSquare.


completeClauses:- filled(I, J, N),
    writeClause([ x-I-J-N ]),
    fail.
completeClauses.

atleastOneVarPerCell:- between(1, 9, I), between(1, 9, J),
    findall( x-I-J-K, between(1, 9, K), C ), writeClause(C), fail.
atleastOneVarPerCell.

atmostOneVarPerCell:- between(1, 9, I), between(1, 9, J),
            between(1, 9, K1), between(1, 9, K2), K1 < K2,
            writeClause( [ \+x-I-J-K1, \+x-I-J-K2 ] ), fail.
atmostOneVarPerCell.

uniqueVarInRow:-   between(1, 9, I), between(1, 9, K),  between(1, 9, J1), between(1, 9, J2), J1 < J2,
                writeClause( [ \+x-I-J1-K, \+x-I-J2-K ] ), fail.
uniqueVarInRow.

uniqueVarInColumn:-
            between(1, 9, J), between(1, 9, K),  between(1, 9, I1), between(1, 9, I2), I1 < I2,
            writeClause( [ \+x-I1-J-K, \+x-I2-J-K ] ), fail.
uniqueVarInColumn.

uniqueVarInSquare:-

    between(0, 2, Isquare), between(0, 2, Jsquare),
    I is Isquare * 3 + 1,
    J is Jsquare * 3 + 1,
    I1 is I + 2,
    J1 is J + 2,
    between(1, 9, K),
    between(I, I1, I2), between(J, J1, J2),
    between(I, I1, I3), I2 < I3,
    between(J, J1, J3), J2 \= J3,

    writeClause( [ \+x-I2-J2-K, \+x-I3-J3-K ] ), fail.
uniqueVarInSquare.

displaySol(M):- between(1,9,I),nl, between(1,9,J), tab(1), member(V, M),
                num2var(V, x-I-J-K), write(K), fail.
displaySol(_):- nl.


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
