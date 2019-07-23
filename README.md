# prolog-19-lego

Se disponen de piezas de LEGO para realizar construcciones. Estas piezas pueden
ser rectángulos o cuadrados. Las piezas se definen mediante un término compuesto
```pieza/4```, donde el primer argumento representa la anchura de la pieza (número de
clavos), el segundo argumento la altura de la pieza, el tercer argumento la profundidad
(número de clavos) y el último argumento el color de la pieza. 

Se pide escribir un programa para ordenar listas en el que el criterio de comparacion no este predefinido (se da en la ejecucion) y que ademas lleve a cabo la ordenacion mediante el algoritmo de “arboles flotantes” que se explica mas abajo. La practica consta de las siguientes partes:

- Las medidas de la pieza (anchura, altura y profundidad) se representan como
números de Peano.
- Los colores de los que se disponen son los siguientes: rojo (r), azul (a), verde
(v) y amarillo (am).
- Ejemplo: pieza(s(s(s(s(0)))),s(0),s(s(0)),r)


![Ejemplo de Pieza](/ejemplo_pieza.png)

Las piezas disponibles pueden estar apoyadas sobre el suelo o ensambladas sobre
otra pieza, formando una construcción. Las construcciones, que están compuestas al
menos por una pieza, pueden ser de dos tipos:

- **Torre**: cada nivel de la construcción cuenta con una única pieza. Además, cada
pieza sólo puede ensamblarse encima de una pieza igual o más grande que ella
(el largo y el ancho de la pieza de abajo deben ser mayor o igual que las mismas
dimensiones de la pieza de arriba).

- **Edificio**: cada nivel de la construcción puede estar formado por varias piezas
(siempre de la misma profundidad y de altura 1), las cuales pueden ensamblarse
de cualquier modo.

![Ejemplo de Torre y Edificio](/ejemplo_torre_edificio.png)

Las construcciones **tipo torre** se representan como listas, donde la última pieza de la
torre es la cabeza de la lista.

Las construcciones **tipo edificio** se representan mediante una matriz (una lista de
listas) que muestra el alzado del edificio. En dicha matriz, cada fila (cada lista interior) representa un nivel de la construcción (del edificio) y cada celda (elemento de la lista interior) representa un clavo de una pieza utilizando para ello el color de la pieza que se sitúa en dicho lugar del alzado. El número de filas de la matriz es el número de niveles del edificio, y el número de columnas es el número de clavos del nivel más ancho. Las celdas de la matriz que no incluyen clavos de piezas se representan con la
constante 'b'. 

La siguiente matriz representa el edificio mostrado en el ejemplo (b).

|   |   |   |   |   |   |   |   |   |   |
|---|---|----|----|----|----|----|----|----|----|
| b | b | b  | r  | r  | r  | r  | b  | b  | b  |
| b | b | b  | b  | a  | a  | a  | a  | b  | b  |
| b | b | am | am | am | am | am | am | am | am |
| v | v | v  | v  | r  | r  | r  | r  | r  | r  |
| b | b | a  | a  | a  | a  | r  | r  | r  | r  |
| b | b | b  | b  | am | am | am | am | b  | b  |

**PRIMERA PARTE**: (6 puntos)

Se pide definir los siguientes predicados para las construcciones tipo torre:

- ```esTorre/1``` (esTorre(Construccion)): predicado que se verifica si Construccion
cumple las condiciones para ser una torre.

- ```alturaTorre/2``` (alturaTorre(Construccion,A)): predicado que se verifica si el
primer argumento (Construccion) es una torre, y el segundo argumento (A) es
la altura de la torre.

- ```coloresTorre/2``` (coloresTorre(Construccion,Colores)): predicado que se
verifica si el primer argumento (Construccion) es una torre y el segundo
argumento (Colores) es una lista con los colores de la torre.

- ```coloresIncluidos/2``` (coloresIncluidos(Construccion1,Construccion2)):
predicado que se verifica si (a) ambos predicados son torres y (b) todos los
colores de la Construccion1 también están en los de la Construccion2.

**SEGUNDA PARTE**: (4 puntos)

Se pide definir los siguientes predicados para las construcciones tipo edificio:

- ```esEdificioPar/1``` (esEdificioPar(Construccion)): predicado que es cierto si
Construccion es un edificio que cumple que cada nivel tiene un número par de
clavos.

- ```esEdificioPiramide/1``` (esEdificioPiramide(Construccion): predicado que se
verifica si Construccion es un edificio que cumple que cada nivel tiene un
ancho estrictamente mayor que el nivel de arriba.

**Nota**: En el programa lógico se deben usar los mismos nombres de predicado que se
utilizan en este enunciado. 