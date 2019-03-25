% Autores de la practica.
alumno_prode('Fernandez','Peces Barba','Diego','T110271').

% pieza/4: Estructura que representa la anchura, la altura, la profundidad y el color.

% esTorre/1: Predicado que verifica si la Construccion cumple condiciones para ser torre.
% Comprobar que la primera pieza tiene un largo y ancho menor o igual que la segunda pieza.

esTorre([PP,SP]):-
	PP = pieza(AP1,_,PP1,_),
	SP = pieza(AP2,_,PP2,_),
	esMenorIgual(AP1,AP2),
	esMenorIgual(PP1,PP2).

esTorre( [PP, SP | RP] ):-
	PP = pieza(AP1,_,PP1,_),
	SP = P2,
	SP = pieza(AP2,_,PP2,_),
	esMenorIgual(AP1,AP2),
	esMenorIgual(PP1,PP2),
	esTorre([P2|RP]).


% alturaTorre/2: Predicado que verifica si el primer argumento es una torre y el segundo su altura.
alturaTorre(T, AT):-
	esTorre(T),
	tamanoTorre(T, 0, R),
	AT = R.

tamanoTorre([PP|RP], TT, R):-
	PP = pieza(_,A,_,_),
	sumaPeano(A, TT, PR),
	tamanoTorre(RP, PR, R).

tamanoTorre([], TT, R):-
	TT = R.
	
% coloresTorre/2: Predicado que verifica si el primer arguento es una torre y el segundo es una lista con los colores de la torre.

coloresTorre(T, CT):-
	esTorre(T),
	addColoresTorre(T, CT, []),
	CT = CT.

addColoresTorre([PP|RP],CT, L):-
	PP = pieza(_,_,_,C),
	addColoresTorre(RP, CT, [C|L]).

addColoresTorre([], L, L2):-
	invertir(L,L2).

% coloresIncluidos/2: Predicado que verifica si ambos predcados son torres y si todos los colores de la torre 1 estan en la torre 2.

coloresIncluidos(T1,T2):-
	coloresTorre(T1, CT1),
	coloresTorre(T2, CT2),
	coloresIguales(CT1, CT2).

coloresIguales([E1|R], L2):-
	esMiembro(E1,L2),
	coloresIguales(R, L2).

coloresIguales([], _).

% esMenorIgual/2: Predicado que comprueba si es el numero de peano es mayor o igual que el siguiente.

esMenorIgual(0, 0).
esMenorIgual(0, s(_)).
esMenorIgual(s(X), s(Y)):-
	esMenorIgual(X, Y).

% sumaPeano/3: Predicado para sumar al primer elemento en peano, el segundo en peano.
sumaPeano(R, 0, R).
sumaPeano(M, s(N), R):-
	sumaPeano(s(M), N, R).

% esMiembro/2: Predicado que verifica que el primer elemento pertenece a la lista.
esMiembro(X, [X|_]).
esMiembro(X, [_|L]):-
	esMiembro(X, L).

% meterElemento/2: Predicado que verifica que el tercer argumento es la lista obtenida de meter los elementos de L2 despues de los de L1.
meterElemento([], L, L).
meterElemento([X|L1], L2, [X|L3]) :-
	meterElemento(L1, L2, L3).

invertir([],[]).
invertir([X|L1],L2):-
	invertir(L1,L3),
	meterElemento(L3,[X],L2).