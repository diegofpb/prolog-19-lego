% Autores de la practica.
alumno_prode('Fernandez','Peces Barba','Diego','T110271').
alumno_prode('Garcia', 'Garcia', 'Ruben', 'W140186').
alumno_prode('Maldonado','Quispe','Idania','Q080182').

% color: Base de hechos de colores para la pieza.
color('r').
color('a').
color('v').
color('am').


% esPieza/4: Estructura que representa la anchura, la altura, la profundidad y el color.
esPieza(pieza(Anchura, Altura, Profundidad, Color)):-
	color(Color),
	nat(Anchura),
	nat(Altura),
	nat(Profundidad).


% esTorre/1: Predicado que verifica si la Construccion cumple condiciones para ser torre.
% Comprobar que la primera pieza tiene un largo y ancho menor o igual que la segunda pieza.

esTorre([PP]):-
	 esPieza(PP).

esTorre([pieza(AP1,_,PP1,_), pieza(AP2,_,PP2,_)]):-
	esMenorIgual(AP1,AP2),
	esMenorIgual(PP1,PP2).

esTorre( [pieza(AP1,_,PP1,_), SP | RP] ):-
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

tamanoTorre([pieza(_,A,_,_)|RP], TT, R):-
	sumaPeano(A, TT, PR),
	tamanoTorre(RP, PR, R).

tamanoTorre([], TT, R):-
	TT = R.
	
% coloresTorre/2: Predicado que verifica si el primer arguento es una torre y el segundo es una lista con los colores de la torre.

coloresTorre(T, CT):-
	esTorre(T),
	addColoresTorre(T, CT, []),
	CT = CT.

addColoresTorre([pieza(_,_,_,C)|RP],CT, L):-
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


% esEdificioPar/1: Predicado que comprueba si el edificio tiene un numero par de clavos.

esEdificioPar(C):-
	contarClavos(C,0,_).

% contarClavos/1: Predicado que devuelve el numero de clavos de una construccion.

contarClavos([],R,R).

contarClavos([PPIEZAS|RP],A,R):-
	contarClavosLista(PPIEZAS,0,R1),
	esPar(R1),
	sumaPeano(A,R1,R2),
	contarClavos(RP,R2,R).

% contarClavosLista/3: Preficado que devuelve en R el numero de clavos de una lista.
contarClavosLista([PPIEZA|RP],N,R):-
	PPIEZA = 'b',
	contarClavosLista(RP,N,R).

contarClavosLista([PPIEZA|RP],N,R):-
	color(PPIEZA),
	sumaPeano(N, s(0), RES),
	contarClavosLista(RP,RES,R).

contarClavosLista(PIEZA,N,R):-
	PIEZA = 'b',
	N = R.

contarClavosLista(PIEZA,N,R):-
	color(PIEZA),
	sumaPeano(N, N, R).
	
contarClavosLista([],N,R):-
	N = R.


% esEdificioPiramide/1: Preficado que se verifica si la construccion es un edificio que cumple que cada nivel tiene un ancho estrictamente mayor que el nivel de arriba.

esEdificioPiramide(C):-
	contarClavosPiramide(C).

contarClavosPiramide([]).

contarClavosPiramide([PFILA,SFILA|RP]):-
	contarClavosLista(PFILA,0,R1F),
	contarClavosLista(SFILA,0,R2F),
	sumaPeano(0,R1F,RS1),
	sumaPeano(0,R2F,RS2),
	esEstrictamenteMenor(RS1,RS2),
	contarClavosPiramide([SFILA|RP]).

contarClavosPiramide([PFILA,UFILA]):-
	contarClavosLista(PFILA,0,R1F),
	contarClavosLista(UFILA,0,R2F),
	sumaPeano(0,R1F,RS1),
	sumaPeano(0,R2F,RS2),
	esEstrictamenteMenor(RS1,RS2).

% esMenorIgual/2: Predicado que comprueba si es el numero de peano es menor o igual que el siguiente.
esMenorIgual(0, 0).
esMenorIgual(0, s(_)).
esMenorIgual(s(X), s(Y)):-
	esMenorIgual(X, Y).

% esEstrictamenteMenor/2: Predicado que comprueba sie l numero de peano es estrictamente menor que el siguente.
esEstrictamenteMenor(0, s(_)).
esEstrictamenteMenor(s(X), s(Y)):-
	esEstrictamenteMenor(X, Y).

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

% invertir/2: Predicado que invierte la lista.
invertir([],[]).
invertir([X|L1],L2):-
	invertir(L1,L3),
	meterElemento(L3,[X],L2).

% nat/1: Predicado que verifica que el numero en peano es natural.
nat(0).
nat(s(X)):-
	nat(X).

% esPar/1: Predicado que verifica que el numero en peano es par.
esPar(0).
esPar(s(s(X))):-
	esPar(X).