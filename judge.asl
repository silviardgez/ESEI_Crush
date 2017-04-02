// Agent judge in project crush.mas2j

/* Initial beliefs and rules */

movs(20). //N�mero m�ximo de movimientos permitidos
totalPoints(0). //Puntos acumulados
pointOnMov(0). //Puntos asociados al movimiento
x(0).
y(9).

//mapa(L) :- mapa1(L) | mapa2(L). //Descomentar para hacer uso de los mapas

mapa1([[ 16, 32, 16, 64, 64, 64, 16, 32,512,256],
       [128,  4,256,512, 64,256,512,  4, 32, 64],
	   [128, 16, 32, 32,512,512,256,128, 64, 64],
	   [  4, 16, 16, 32, 32,512,512,512,512, 16],
	   [ 64, 64, 32,32, 32, 16,512,256,128, 64],
       [128,  16,256,32, 16,256,512,  4, 32, 64],
	   [128, 16, 32, 32,512,512,256,128, 64, 64],
	   [  4, 16, 16, 32, 32,512,256,128,128, 16],
	   [ 64, 16, 32,128, 32, 16,512,256,128, 64],
	   [16,16,32,16, 16,512,512, 64, 32, 64]]).

	   
mapa2([[ 16, 32, 16, 32, 64, 64, 16, 32,512,256],
       [128, 32,256,512, 16,256,512, 16, 32, 64],
	   [128, 16, 32, 32,512,512,256,128, 64, 64],
	   [ 64, 16, 16, 32, 32,512,256,128,128, 16],
	   [ 64, 64, 32,128, 32, 16,512,256,128, 64],
       [128, 64,256,512, 16,256,512,512, 32, 64],
	   [128, 16, 32, 32,512,512,256,128, 64, 64],
	   [ 32, 256, 16, 32, 32,512,256,128,128, 16],
	   [ 64, 256, 32,128, 32, 16,512,256,128, 64],
	   [256,256,256,128, 64,512,512, 64, 32, 64]]).

	   
//semilla(37).
//:- .add_plan({+!colocame: true <-.print("Caca de la vaca D---------------------------------------------------")}).

color(0,16).
color(N,C) :- color(N-1,C1) & C = C1*2. //Los colores son multiplos de 16


chooseC(C) :- 
	.random(X) & Exp =math.floor(X*6) & color(Exp,C). //escogemos color al azar

contiguas(X,X,Y1,Y2) :-Y2  < Y1 & sizeof(N) & X >=0 & X < N+1 & Y1 < N+1 & Y1 = Y2+1. //comprueba que las fichas a intercambiar estén juntas y no se salgan del tablero
contiguas(X,X,Y1,Y2) :-Y2  > Y1 & sizeof(N) & X >=0 & X < N+1 & Y2 < N+1 & Y2 = Y1+1.
contiguas(X,X,Y1,Y2) :- Y2  < Y1  & Y2 >= 0 & 0 <= X & X < N+1 & Y2 = Y1-1.
contiguas(X,X,Y1,Y2) :- Y2  > Y1  & Y1 >= 0 & 0 <= X & X < N+1 & Y1 = Y2-1.
contiguas(X1,X2,Y,Y) :- X2  < X1 & sizeof(N) & 0 <= Y & Y < N+1 & X1 < N+1 & X1 = X2+1.
contiguas(X1,X2,Y,Y) :- X2  > X1 & sizeof(N) & 0 <= Y & Y < N+1 & X2 < N+1 & X2 = X1+1.
contiguas(X1,X2,Y,Y) :-  X2  < X1 & X2 >= 0 & 0 <= Y & Y < N+1 & X2 = X1-1.
contiguas(X1,X2,Y,Y) :- X2  > X1 & X1 >= 0 & 0 <= Y & Y < N+1 & X1 = X2-1.

freeGroup(X,Y,C) :- //Un grupo est� libre si no se da ninguna de las agrupaciones
	not groupFileA(X,Y,C) & not groupFileB(X,Y,C) & not groupFileE(X,Y,C) & not groupColumnC(X,Y,C) & not groupColumnD(X,Y,C) & not groupColumnF(X,Y,C)
	& not groupColumn4C(X,Y,C) & not groupColumn4C(X,Y,C) & not groupFile4A(X,Y,C) & not groupFile4B(X,Y,C) & not groupFile5(X,Y,C) & not groupColumn5(X,Y,C)
	& not groupCuadradoA(X,Y,C) & not groupCuadradoB(X,Y,C) & not groupCuadradoC(X,Y,C) & not groupCuadradoD(X,Y,C) & not groupT(X,Y,C) & not groupT2(X,Y,C)
	& not groupT3(X,Y,C).

	//GRUPOS DE 5
	groupFile5(X,Y,C) :- //OO_OO
	sizeof(N) & X-2 >= 0 & X+2 < N+1 & steak(C,X-1,Y) & steak(C,X-2,Y)& steak(C,X+1,Y) & steak(C,X+2,Y).
	
	groupColumn5(X,Y,C) :- //Nueva en el medio de columna de 5
	sizeof(N) & Y+2 < N+1 & Y-2 >= 0 & steak(C,X,Y+1) & steak(C,X,Y+2) & steak(C,X,Y-1) & steak(C,X,Y-2).
	
	
	//GRUPOS DE CUADRADOS
	//Cuadrado hueco arriba der
	groupCuadradoA(X,Y,C) :-
	sizeof(N) & X-1  >= 0 & Y+1 < N+1 & steak(C,X-1,Y) & steak(C,X-1,Y+1) & steak(C,X,Y+1).
	
	//Cuadrado hueco arriba izq
	groupCuadradoB(X,Y,C):-
	sizeof(N) & X+1 < N+1 & Y+1 < N+1 & steak(C,X+1,Y+1) & steak(C,X+1,Y) & steak(C,X,Y+1).
	
	//Cuadrado hueco abajo izq
	groupCuadradoC(X,Y,C):-
	sizeof(N) & X+1 < N+1 & Y-1 >= 0 & steak(C,X+1,Y) & steak(C,X+1,Y-1) & steak(C,X,Y-1).

	//Cuadrado hueco abajo der
	groupCuadradoD(X,Y,C):-
	sizeof(N) & X-1 >= 0 & Y-1 >= 0 & steak(C,X-1,Y) & steak(C,X-1,Y-1) & steak(C,X,Y-1).

	
	
	
	//GRUPOS DE Ts	
	groupT(X,Y,C) :- //T normal
	sizeof(N) & Y+2 < N+1 & X+1 < N+1 & X-1 >= 0 & steak(C,X-1,Y) & steak(C,X+1,Y) & steak(C,X,Y+1) & steak(C,X,Y+2).
	
	groupT2(X,Y,C) :- //T invertida
	sizeof(N) & Y-2 >= 0 & X+1 < N+1 & X-1 >=0 & steak(C,X,Y-1) & steak(C,X,Y-2) & steak(C,X+1,Y) & steak(C,X-1,Y).
	
	groupT3(X,Y,C) :- //T derecha
	sizeof(N) & Y+1 < N+1 & Y-1 >= 0 & X-2 >= 0 & steak(C,X,Y+1) & steak(C,X,Y-1) & steak(C,X-1,Y) & steak(C,X-2,Y).

	groupT4(X,Y,C) :- //T izquierda
	sizeof(N) & Y+1 < N+1 & Y-1 >= 0 & X+2 < N+1 & steak(C,X,Y+1) & steak(C,X,Y-1) & steak(C,X+1,Y) & steak(C,X+2,Y).
	
	
	//GRUPOS DE 4
	groupFile4A(X,Y,C) :- // OO_O
	sizeof(N) & X-2 >= 0 & X+1 < N+1 & steak(C,X-1,Y) & steak(C,X-2,Y)& steak(C,X+1,Y).

groupFile4B(X,Y,C) :- // O_OO
	sizeof(N) &  X-1 >= 0 & X+2 < N+1 & steak(C,X+1,Y) & steak(C,X+2,Y) & steak(C,X-1,Y).
	
		groupColumn4C(X,Y,C) :- //vertical hueco segundo
	sizeof(N) & Y-1 >= 0 & Y+2 < N+1 & steak(C,X,Y-1) & steak(C,X,Y+1) & steak(C,X,Y+2).
	
	groupColumn4D(X,Y,C) :- //vertical hueco tercero
sizeof(N)  & Y-2 >=0 & Y+1 < N+1 & steak(C,X,Y-2) & steak(C,X,Y-1) & steak(C,X,Y+1).

	
	


	
	////GRUPOS DE 5
groupFileA(X,Y,C) :- // OO_
	sizeof(N) & X-2 >= 0 & steak(C,X-1,Y) & steak(C,X-2,Y).

	groupFileB(X,Y,C) :- // _OO
	sizeof(N) & X+2 < N+1 & steak(C,X+1,Y) & steak(C,X+2,Y).

	groupColumnC(X,Y,C) :- // Nueva abajo vertical
	sizeof(N) & Y-2 >= 0 & steak(C,X,Y-1) & steak(C,X,Y-2).

	groupColumnD(X,Y,C) :- // Nueva arriba vertical
	sizeof(N) & Y+2 < N+1 & steak(C,X,Y+1) & steak(C,X,Y+2).

	groupFileE(X,Y,C) :- // O_O
	sizeof(N) & X-1 >= 0 & X+1 < N+1 & steak(C,X+1,Y) & steak(C,X-1,Y).

	groupColumnF(X,Y,C) :- // Nueva medio vertical
	sizeof(N) & Y-1 >= 0 & Y+1 < N+1 & steak(C,X,Y-1) & steak(C,X,Y+1).
	







/* Initial goals */

!start.

/* Plans */

+!start : true <- 
	
	!iniciarTablero; //rellena el tablero, coloca obst�culos y especiales
	
	.all_names(L);
	.wait(100);
		
	if (.member(player,L)){ //comprueba que el player sea un miembro de la partida
		.send(player,tell,canExchange);}
	else {
		.print("El agente player no existe mas.");
	}.

	
+!recorreMapa(Mapa) : sizeof(N) <- //en caso de usar los arrays de mapa los usa para crear las piezas
	for (.member(Fila,Mapa)) {
		for (.member(C,Fila)) {
			?y(J);
			?x(I);
			.print("steak(",I,",",J,",",C,").");
			put(I,J,C,0);
			-+x(I+1);
		};
		?y(J);
		-+y(J-1);
		-+x(0);
	};
	-+y(9).
	
+!iniciarTablero : mapa(Mapa) & sizeof(N) <- //iniciación del tablero con mapa
	!recorreMapa(Mapa).
	
+!iniciarTablero : not mapa(Mapa) & sizeof(N) <- //iniciacion con piezas al azar
	!putObstacle(1,7); //colocamos los obstaculos
	!putObstacle(7,3);
	!putObstacle(4,1);
	!putObstacle(4,6);
	!putObstacle(2,0);
	


	
	for (.range(Y,N,0,-1)) {
		for (.range(X,0,N)) {
			
			?chooseC(C);
			if (freeGroup(X,Y,C)) {
				.print("Pongo ficha de color: ",C);
				put(X,Y,C,0);
			} else { //en caso de que s encuentren agrupaciones iniciales, se cambia el color de la pieza
			    .print("Detectada agrupación de color: ",C," ......................");
				if (C<512) {C1 = C*2;} else {C1 = 16;};
				
				.print("Pongo ficha de color: ",C1);
				put(X,Y,C1,0);
			}
		}
	};
	
	!initSpecials.

+!initSpecials : sizeof(N) <- //Ponemos las piezas especiales

	
	!putIp(2,N-6); 
	!putCt(0,6);
	!putCo(4,N-4);
	!putGs(N-6,3);
	
	.print("Se acabo la inicialización").

+!putGs(X,Y) : steak(C,X,Y) <- //Coloca GS en X,Y
	+gs(X,Y,C);
	deleteSteak(C,X,Y);
	put(X,Y,C,3);
	.send(player,tell,gs(X,Y,C)); 
	.
	
+!putGs(X,Y) <-
	.print("La posición: (",X,",",Y,"), no tiene ninguna pieza que promocionar.").
	
+!putCo(X,Y) : steak(C,X,Y) <-//Coloca CO en X,Y
	+co(X,Y,C);
	deleteSteak(C,X,Y);
	put(X,Y,C,4);
	.send(player,tell,co(X,Y,C));
.
	
+!putCo(X,Y) <-
	.print("La posición: (",X,",",Y,"), no tiene ninguna pieza que promocionar.").
	
+!putCt(X,Y) : steak(C,X,Y) <- //Coloca CT en X,Y
	+ct(X,Y,C);
	deleteSteak(C,X,Y);
	put(X,Y,C,2);
	.send(player,tell,ct(X,Y,C));
.
	
+!putCt(X,Y) <-
	.print("La posición: (",X,",",Y,"), no tiene ninguna pieza que promocionar.").
	
+!putIp(X,Y) : steak(C,X,Y) <- //Coloca IP en X,Y
	+ip(X,Y,C);
	
	deleteSteak(C,X,Y);
	put(X,Y,C,1);
	.send(player,tell,ip(X,Y,C));.
	
+!putIp(X,Y) <-
	.print("La posición: (",X,",",Y,"), no tiene ninguna pieza que promocionar.").
	
+!putObstacle(X,Y) : sizeof(N) & X<N+1 & Y<N+1 & X>-1 & Y>-1 <-//Coloca obstáculo en X,Y
	if (steak(C,X,Y)) {
		deleteSteak(C,X,Y);
		.print("Hay una pieza que debo eliminar antes de colocar el obstaculo en: (",X,",",Y,").");
	} else {
		.print("No hace falta eliminar ninguna pieza, la casilla esta vacia.");
	};
	+obstacle(X,Y); .send(player,tell,obstacle(X,Y));
	put(X,Y,4,0).
	
+!putObstacle(X,Y) : sizeof(N) <-
	.print("No puedo colocar un obstaculo en la celta: (", X,",",Y,") del tablero de dimensión: ",N+1,"x",N+1,".").
	
+!colaterales(X2,Y2): sizeof(N) <- //Comprueba si se forman agrupamientos colaterales en la columna en la que se han hecho los cambios
		for (.range(Y,Y2,0,-1)) { //busca desde la fila del cambio hasta 0
		
		if(obstacle(X2,Y)){
	
		!colaterales(X2+1,Y);}
			else{
			.print("BUSCANDO AGRUPAMIENTOS COLATERALES EN  : (",X2,",",Y,")");
			if(steak(C,X2,Y)){
			?steak(C,X2,Y);
			.wait(15);
			-+detect(X2,Y,C);} //manda buscar las agrupaciones
			
		}};
		
	.
	
	+!actualize : pointOnMov(Points) & totalPoints(Total) <- //actualiza los puntos asociados al movimiento
 
 -+totalPoints(Points+Total);
 ?totalPoints(T);.print("PUNTOS: ",T);
 .send(player,tell,totalPoints(T));
 -+pointOnMov(0).
 
 +!actualizeMovs : movs(N)  <- //actualiza el número de movimientos restantes
 
 -+movs(N-1);
 ?movs(T);.print("------------QUEDAN ",T, " MOVIMIENTOS---------").

+movs(0)<- .send(player,tell,fin);.print("MOVIMIENTOS AGOTADOS");.print("FIN DE LA PARTIDA").


	//PUNTUAMOS LOS PATRONES DE 5
	+puntuaGroups5A(X2,Y2,C) : 	groupFile5(X2,Y2,C)  <-
	
	-+pointOnMov(10); .print("Agrupacion de 5 (+10)");!actualize .
	
	+puntuaGroups5B(X2,Y2,C) : 	groupColumn5(X2,Y2,C)  <-
	
	-+pointOnMov(10)  ;.print("Agrupacion de 5 (+10)");!actualize .
	
	
	//PUNTUAMOS LOS PATRONES CUADRADO
	//Hueco arriba der
	+puntuaGroupsCuadrA(X2,Y2,C) : 	groupCuadradoA(X2,Y2,C)  <-
	
-+pointOnMov(8)  ;.print("Agrupacion de cuadrado (+8)");!actualize .

	//Hueco arriba izq
	+puntuaGroupsCuadrB(X2,Y2,C):	groupCuadradoB(X2,Y2,C) <-

	-+pointOnMov(8);.print("Agrupacion de cuadrado (+8)");!actualize .

	//Hueco abajo izq 
	+puntuaGroupsCuadrC(X2,Y2,C):	groupCuadradoC(X2,Y2,C) <-

	-+pointOnMov(8);.print("Agrupacion de cuadrado (+8)");!actualize.

	//Hueco abajo der
	+puntuaGroupsCuadrD(X2,Y2,C):	groupCuadradoD(X2,Y2,C) <-

	-+pointOnMov(8);.print("Agrupacion de cuadrado (+8)");!actualize.

	
	
	//PUNTUAMOS LOS PATRONES T
	+puntuaGroupsT(X2,Y2,C) : 	groupT(X2,Y2,C)  <-
	
	-+pointOnMov(6);.print("Agrupacion de T (+6)");!actualize.
	
	+puntuaGroupsT2(X2,Y2,C) : 	groupT2(X2,Y2,C)  <-
	
	-+pointOnMov(6);.print("Agrupacion de T (+6)");!actualize.
	
	+puntuaGroupsT3(X2,Y2,C) : 	groupT3(X2,Y2,C)  <-
	
	-+pointOnMov(6);.print("Agrupacion de T (+6)");!actualize.
	
	+puntuaGroupsT4(X2,Y2,C) : 	groupT4(X2,Y2,C)  <-
	
	-+pointOnMov(6);.print("Agrupacion de T, (+6)");!actualize.
	
	
	
	//PUNTUAMOS LOS PATRONES DE 4
	+puntuaGroups4A(X2,Y2,C) : 	groupFile4A(X2,Y2,C)  <-
	
	-+pointOnMov(4) ;.print("Agrupacion de 4 (+4)");!actualize .

+puntuaGroups4B(X2,Y2,C) : 	groupFile4B(X2,Y2,C)  <-	
-+pointOnMov(4) ;.print("Agrupacion de 4 (+4)");!actualize .

	+puntuaGroups4C(X2,Y2,C) : 	groupColumn4C(X2,Y2,C)  <-
	
	-+pointOnMov(4)  ;.print("Agrupacion de 4 (+4)");!actualize .

+puntuaGroups4D(X2,Y2,C) : 	groupColumn4D(X2,Y2,C)  <-
	
	-+pointOnMov(4)  ;.print("Agrupacion de 4 (+4)");!actualize .
	
	
	
	
	
	//....BORRAMOS Y COLOCAMOS ESPECIALES ....
	

	+detectGroups5A(X2,Y2,C) : 	groupFile5(X2,Y2,C)  <-
	
	.print("BORRANDO 5 EN HORIZONTAL");!putCt(X2,Y2)      ;-+cleanSteaks(X2+2,Y2);-+cleanSteaks(X2+1,Y2);-+cleanSteaks(X2-1,Y2);-+cleanSteaks(X2-2,Y2);!colaterales(X2+2,Y2);!colaterales(X2+1,Y2);!colaterales(X2,Y2);!colaterales(X2-1,Y2);!colaterales(X2-2,Y2);+borrado.
	
	+detectGroups5B(X2,Y2,C) : 	groupColumn5(X2,Y2,C)  <-
	
	.print("BORRANDO 5 EN VERTICAL");!putCt(X2,Y2)    ;-+cleanSteaks(X2,Y2-2);
	-+cleanSteaks(X2,Y2-1);
	-+cleanSteaks(X2,Y2+1);-+cleanSteaks(X2,Y2+2);!colaterales(X2,Y2+2);+borrado.
	
	
	
		//Grupos cuadrados
	//Hueco arriba der
	+detectGroupsCuadrA(X2,Y2,C) : 	groupCuadradoA(X2,Y2,C)  <-
	
	.print("BORRANDO CUADRADO");!putGs(X2-1,Y2+1)  ;-+cleanSteaks(X2,Y2);
	
	-+cleanSteaks(X2,Y2+1);-+cleanSteaks(X2-1,Y2);!colaterales(X2-1,Y2);!colaterales(X2,Y2+1);+borrado.

	//Hueco arriba izq
	+detectGroupsCuadrB(X2,Y2,C):	groupCuadradoB(X2,Y2,C) <-

	.print("BORRANDO CUADRADO");!putGs(X2,Y2+1)  ;
	-+cleanSteaks(X2+1,Y2);
	-+cleanSteaks(X2+1,Y2+1);-+cleanSteaks(X2,Y2);!colaterales(X2,Y2);!colaterales(X2,Y2+1);+borrado.

	//Hueco abajo izq 
	+detectGroupsCuadrC(X2,Y2,C):	groupCuadradoC(X2,Y2) <-

	.print("BORRANDO CUADRADO");!putGs(X2,Y2,C)  ;
	
	-+cleanSteaks(X2+1,Y2-1);
	-+cleanSteaks(X2+1,Y2);-+cleanSteaks(X2,Y2-1);!colaterales(X2,Y2);!colaterales(X2+1,Y2);+borrado.

	//Hueco abajo der
	+detectGroupsCuadrD(X2,Y2,C):	groupCuadradoD(X2,Y2,C) <-

	.print("BORRANDO CUADRADO");!putGs(X2-1,Y2);  -+cleanSteaks(X2,Y2-1);-+cleanSteaks(X2,Y2);	-+cleanSteaks(X2-1,Y2-1); !colaterales(X2,Y2);!colaterales(X2-1,Y2);

	+borrado.
	
		//Grupos T
	+detectGroupsT(X2,Y2,C) : 	groupT(X2,Y2,C)  <-
	
	.print("BORRANDO T 0º");!putCo(X2,Y2)   ;-+cleanSteaks(X2+1,Y2);
	-+cleanSteaks(X2-1,Y2); -+cleanSteaks(X2,Y2+1);-+cleanSteaks(X2,Y2+2);
	!colaterales(X2+1,Y2);!colaterales(X2,Y2+2);!colaterales(X2-1,Y2);+borrado.
	
	+detectGroupsT2(X2,Y2,C) : 	groupT2(X2,Y2)  <-
	
	.print("BORRANDO T 180º");!putCo(X2,Y2)    ;-+cleanSteaks(X2+1,Y2);
	-+cleanSteaks(X2,Y2-2);
	-+cleanSteaks(X2,Y2-1);-+cleanSteaks(X2-1,Y2);!colaterales(X2+1,Y2);!colaterales(X2,Y2);!colaterales(X2-1,Y2);+borrado.
	
	+detectGroupsT3(X2,Y2,C) : 	groupT3(X2,Y2,C)  <-
	
	.print("BORRANDO T 90º");!putCo(X2,Y2);  -+cleanSteaks(X2,Y2-1)  ;-+cleanSteaks(X2,Y2+1);
	
	-+cleanSteaks(X2-1,Y2);-+cleanSteaks(X2-2,Y2);!colaterales(X2,Y2+1);!colaterales(X2-1,Y2);!colaterales(X2-2,Y2);+borrado.
	
	+detectGroupsT4(X2,Y2,C) : 	groupT4(X2,Y2,C)  <-
	
	.print("BORRANDO T 270º");!putCo(X2,Y2)   ;	-+cleanSteaks(X2+2,Y2);-+cleanSteaks(X2+1,Y2);

	-+cleanSteaks(X2,Y2-1);-+cleanSteaks(X2,Y2+1);!colaterales(X2+2,Y2);!colaterales(X2+1,Y2);!colaterales(X2,Y2+1);+borrado.
	
	
		//Grupos de 4
	+detectGroups4A(X2,Y2,C) : 	groupFile4A(X2,Y2,C)  <-
	
	.print("BORRANDO 4 EN HORIZONTAL");!putIp(X2-2,Y2) ;-+cleanSteaks(X2+1,Y2)  ;-+cleanSteaks(X2,Y2);-+cleanSteaks(X2-1,Y2);!colaterales(X2+1,Y2);!colaterales(X2,Y2);!colaterales(X2-1,Y2);!colaterales(X2-2,Y2);+borrado.

+detectGroups4B(X2,Y2,C) : 	groupFile4B(X2,Y2,C)  <-
	
	.print("BORRANDO 4 EN HORIZONTAL");!putIp(X2+2,Y2)  ;-+cleanSteaks(X2+1,Y2) ;-+cleanSteaks(X2,Y2);-+cleanSteaks(X2-1,Y2);!colaterales(X2+2,Y2);!colaterales(X2+1,Y2);!colaterales(X2,Y2);!colaterales(X2-1,Y2);+borrado.
	
	
	+detectGroups4C(X2,Y2,C) : 	groupColumn4C(X2,Y2,C)  <-
	
	.print("BORRANDO 4 EN VERTICAL");!putIp(X2,Y2+2);   -+cleanSteaks(X2,Y2-1)  ;-+cleanSteaks(X2,Y2);
	-+cleanSteaks(X2,Y2+1);
	!colaterales(X2,Y2+2);+borrado.

+detectGroups4D(X2,Y2,C) : 	groupColumn4D(X2,Y2,C)  <-
	
	.print("BORRANDO 4 EN VERTICAL");!putIp(X2,Y2-2);   -+cleanSteaks(X2,Y2-1)  ;-+cleanSteaks(X2,Y2);
	-+cleanSteaks(X2,Y2+1);
	!colaterales(X2,Y2+1);+borrado.
	
	
	
	//Grupos de 3
+detectGroupsA(X2,Y2,C) : 	groupFileA(X2,Y2,C)  <-
	
	.print("BORRANDO EN HORIZONTAL");-+cleanSteaks(X2,Y2);-+cleanSteaks(X2-1,Y2);-+cleanSteaks(X2-2,Y2);!colaterales(X2,Y2);!colaterales(X2-1,Y2);!colaterales(X2-2,Y2);+borrado.

+detectGroupsB(X2,Y2,C) : 	groupFileB(X2,Y2,C)  <-
	
	.print("BORRANDO EN HORIZONTAL");-+cleanSteaks(X2+2,Y2);-+cleanSteaks(X2+1,Y2);-+cleanSteaks(X2,Y2);!colaterales(X2+2,Y2);!colaterales(X2+1,Y2);!colaterales(X2,Y2);+borrado.

+detectGroupsC(X2,Y2,C) : 	groupColumnC(X2,Y2,C)  <-
	
	.print("BORRANDO EN VERTICAL");-+cleanSteaks(X2,Y2-2);-+cleanSteaks(X2,Y2-1);-+cleanSteaks(X2,Y2);!colaterales(X2,Y2);+borrado.


+detectGroupsD(X2,Y2,C) : 	groupColumnD(X2,Y2,C)  <-
	
	.print("BORRANDO EN VERTICAL");-+cleanSteaks(X2,Y2);-+cleanSteaks(X2,Y2+1);-+cleanSteaks(X2,Y2+2);!colaterales(X2,Y2+2);+borrado.

+detectGroupsE(X2,Y2,C) : 	groupFileE(X2,Y2,C)  <-
	
	.print("BORRANDO EN HORIZONTAL");-+cleanSteaks(X2-1,Y2);-+cleanSteaks(X2,Y2);-+cleanSteaks(X2+1,Y2);!colaterales(X2-1,Y2);!colaterales(X2,Y2);!colaterales(X2+1,Y2);+borrado.

+detectGroupsF(X2,Y2,C) : 	groupColumnF(X2,Y2,C)  <-
	
	.print("BORRANDO EN VERTICAL");-+cleanSteaks(X2,Y2-1);-+cleanSteaks(X2,Y2);-+cleanSteaks(X2,Y2+1);!colaterales(X2,Y2+1);+borrado.

	
	
	
	
	
	
	


//Investiga la posición X2,Y2, primero sumando los puntos asociados a los patrones y después realizando solo el borrado correspondiente a la mayor puntuación
+detect(X2,Y2,C)<--+puntuaGroups5A(X2,Y2,C);-+puntuaGroups5B(X2,Y2,C);-+puntuaGroupsCuadrA(X2,Y2,C);-+puntuaGroupsCuadrB(X2,Y2,C);-+puntuaGroupsCuadrC(X2,Y2,C);-+puntuaGroupsCuadrD(X2,Y2,C); -+puntuaGroupsT(X2,Y2,C);-+puntuaGroupsT2(X2,Y2,C); -+puntuaGroupsT3(X2,Y2,C);-+puntuaGroupsT4(X2,Y2,C);-+puntuaGroups4A(X2,Y2,C);-+puntuaGroups4B(X2,Y2,C);-+puntuaGroups4C(X2,Y2,C); -+puntuaGroups4D(X2,Y2,C);if(not(borrado)){-+detectGroups5A(X2,Y2,C)};if(not(borrado)){-+detectGroups5B(X2,Y2,C)};if(not(borrado)){-+detectGroupsCuadrA(X2,Y2,C)};if(not(borrado)){-+detectGroupsCuadrB(X2,Y2,C)};if(not(borrado)){-+detectGroupsCuadrC(X2,Y2,C)};if(not(borrado)){-+detectGroupsCuadrD(X2,Y2,C)}; if(not(borrado)){-+detectGroupsT(X2,Y2,C)};if(not(borrado)){-+detectGroupsT2(X2,Y2,C)}; if(not(borrado)){-+detectGroupsT3(X2,Y2,C)};if(not(borrado)){-+detectGroupsT4(X2,Y2,C)};if(not(borrado)){-+detectGroups4A(X2,Y2,C)};if(not(borrado)){-+detectGroups4B(X2,Y2,C)};if(not(borrado)){-+detectGroups4C(X2,Y2,C)}; if(not(borrado)){-+detectGroups4D(X2,Y2,C)};if(not(borrado)){-+detectGroupsA(X2,Y2,C)};if(not(borrado)){-+detectGroupsB(X2,Y2,C)};if(not(borrado)){-+detectGroupsC(X2,Y2,C)};if(not(borrado)){-+detectGroupsD(X2,Y2,C)};if(not(borrado)){-+detectGroupsE(X2,Y2,C)};if(not(borrado)){-+detectGroupsF(X2,Y2,C)};if(borrado){-borrado};.wait(400); -detect(X2,Y2,C).



 

 
//Caida de las piezas
 
 +moveDown (X,S) :sizeof(N) & X<N+1 & S<N+1 & X>-1 & S>-1 <-
	
		for (.range(Y,S,0,-1)) {
		//En caso de encontrar un obstáculo, siguen cayendo las de la casilla arriba a la derecha (arena)
			if(obstacle(X,Y-1) & steak(K,X+1,Y-1)& (moveDown(X,S))){
				
				
				.print("Cambio a la columna: ", X+1);	
			
				 ?steak(K,X+1,Y-1);
				
				 deleteSteak(K,X+1,Y-1);
				 
				 put(X,Y,K,0);
				   if(ct(X+1,Y-1,Q)){ //Mantenemos las fichas especiales
				  -ct(X+1,Y-1,Q)
				  !putCt(X,Y); 
				  }
				  if(ip(X+1,Y-1,Q)){
				  -ip(X+1,Y-1,Q)
				  !putIp(X,Y); 
				  }
				  if(gs(X+1,Y-1,Q)){
				  -gs(X+1,Y-1,Q)
				  !putGs(X,Y); 
				  }
				  if(co(X+1,Y-1,Q)){
				  -co(X+1,Y-1,Q)
				  !putCo(X,Y); 
				  }
				  
				 +moveDown(X+1,Y-1);
				 .wait(300);
				 -moveDown(X,S);
				 
				
				 
				 
				 } 
			else {if(steak(Q,X,Y-1)& not(obstacle(Q,X,Y-1))&(moveDown(X,S))){
				.print("est� cayendo la columna: ", X);
				
				 ?steak(Q,X,Y-1);
			
				  
				  
				  
				 deleteSteak(Q,X,Y-1);
				 put(X,Y,Q,0);
				 if(ct(X,Y-1,Q)){ //mantenemos las especiales
				  -ct(X,Y-1,Q)
				  !putCt(X,Y); 
				  }
				  if(ip(X,Y-1,Q)){
				  -ip(X,Y-1,Q)
				  !putIp(X,Y); 
				  }
				  if(gs(X,Y-1,Q)){
				  -gs(X,Y-1,Q)
				  !putGs(X,Y); 
				  }
				  if(co(X,Y-1,Q)){
				  -co(X,Y-1,Q)
				  !putCo(X,Y); 
				  }
				 
				 }
				 if(not(steak(W,X,0))){
				
					?chooseC(C);
					
					put(X,0,C,0);
				
				}
				}
				
	}.wait(300);-moveDown(X,S).
	
+accionIlegal(Ag) : amarilla(N) <- //en caso de recibir tres amarillas, se considera tramposo al agente
	if (N<3) {-+amarilla(N+1)}
	else {+trampa(Ag)}.
	
+accionIlegal(Ag) : not amarilla(N) <- +amarilla(1). // Controla si algun player intenta realizar un movimiento ilegal
+cleanSteaks(X,Y): steak(C,X,Y)<- ?steak(C,X,Y);  //realizamos el borrado de las piezas con la correspondiente ca�da
	if(ip(X,Y,C)){ //puntuamos en caso de borrar especiales
	-ip(X,Y,C);
	.print("He borrado un IP (+2)");
	.send(player,untell,ip(X,Y,C));
	 -+pointOnMov(2);!actualize}
	else {
	if(co(X,Y,C)){
	-co(X,Y,C);
	.print("He borrado un CO (+8)");
	.send(player,untell,co(X,Y,C));
	 -+pointOnMov(8);!actualize}
	 else {if(ct(X,Y,C)){
	-ct(X,Y,C);
	.print("He borrado un CT (+10)");
	.send(player,untell,ct(X,Y,C));
	 -+pointOnMov(10);!actualize}
	 else {if(gs(X,Y,C)){
	-gs(X,Y,C);
	.print("He borrado un GS (+5)");
	.send(player,untell,gs(X,Y,C));
	 -+pointOnMov(5);!actualize}
	 
	 else{
	.print("He borrado un steak(+1)");
	 -+pointOnMov(1);!actualize;}
	 }}};deleteSteak(C,X,Y);
	+moveDown(X,Y).
	
+cleanSteaks(C,X,Y) <- .print("No hay steak para borrar").
+trampa(Ag) <- 
	.kill_agent(Ag);
	.print("He tenido que matar el agente", Ag, " por tramposo."). // Elimina al tramposo reiterado
	
+exchange(X1,Y1,X2,Y2)[source(Source)]: //realiza el intercambio entre dos fichas
	steak(C1,X1,Y1) & steak(C2,X2,Y2) & contiguas(X1,X2,Y1,Y2) & not C1 == C2 & not(obstacle(X1,Y1)) & not (obstacle(X2,Y2)) & ( not (freeGroup(X1,Y1,C2)) | not (freeGroup(X2,Y2,C1))  )
<- //manda parar al jugador para que no pida m�s movimientos hasta que termine
	.send(player,tell,para);-exchange(X1,Y1,X2,Y2); deleteSteak (C1, X1, Y1); -steak(C1,X1,Y1);.send(player,untell,steak(C1,X1,Y1)) ;deleteSteak (C2, X2, Y2); .send(player,untell,steak(C2,X2,Y2));-steak(C2,X2,Y2); put(X1,Y1,C2,0); put(X2,Y2,C1,0);
 if(ct(X1,Y1,C1)){
				  -ct(X1,Y1);
				  !putCt(X2,Y2);
				  .send(player,untell,ct(X1,Y1));
				  } 
				  if(ip(X1,Y1,C1)){
				  -ip(X1,Y1);
				  !putIp(X2,Y2);
				    .send(player,untell,ip(X1,Y1));
				  } 
				  if(gs(X1,Y1,C1)){
				  -gs(X1,Y1);
				  !putGs(X2,Y2);
				    .send(player,untell,gs(X1,Y1));
				  } 
				  if(co(X1,Y1,C1)){
				  -co(X1,Y1);
				  !putCo(X2,Y2);
				    .send(player,untell,co(X1,Y1));
				  } 
				 ;
				  
				  
				  if(ct(X2,Y2,C2)){
				  -ct(X2,Y2);
				  !putCt(X1,Y1);
				    .send(player,untell,ct(X2,Y2));
				}
				  if(ip(X2,Y2,C2)){
				  	-ip(X2,Y2);
				  !putIp(X1,Y1);
				  .send(player,untell,ct(X2,Y2));
				  }
				  if(gs(X2,Y2,C2)){
				  -gs(X2,Y2);
				  !putGs(X1,Y1);
				  .send(player,untell,ct(X2,Y2));
				  }
				  if(co(X2,Y2,C2)){
				  -co(X2,Y2);
				  !putCo(X1,Y1);
				  .send(player,untell,ct(X2,Y2));
				  };.print("Hecho el intercambio.");!actualizeMovs
;-+detect(X2,Y2,C1);.wait(100); -+detect(X1,Y1,C2) 
;while(detect(X,Y,K)){.wait(10)};.send(player,untell,para); 
.



+exchange(X1,Y1,X2,Y2)[source(Source)] <-
	.print("He recibido de ", Source, " la solicitud de intercambiar dos steak que no son viables");-exchange(X1,Y1,X2,Y2);
	.send(Source,tell,tryAgain(X1,Y1,X2,Y2)) //en caso de movimiento no permitido, se le notifica al player que el movimiento es inviable
	.
	
	+putSteak(X)[source(Source)] <-
	.print("He recibido de ", Source, " la solicitud de colocar un steak en: ", X);
	putB(X).
	
+steak(0,X,Y)[source(Source)] <- -steak(0,X,Y)[source(Source)].

+steak(4,X,Y)[source(Source)] <- -steak(4,X,Y)[source(Source)].

+pos(Ag,X,Y)[source(S)] <- -pos(Ag,X,Y)[source(S)].
