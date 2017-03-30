// Agent judge in project crush.mas2j

/* Initial beliefs and rules */

tam(10).
movs(20).
totalPoints(0).
pointOnMov(0).
x(0).

y(9).

//mapa(L) :- mapa1(L) | mapa2(L).

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
color(N,C) :- color(N-1,C1) & C = C1*2.


chooseC(C) :- 
	.random(X) & Exp =math.floor(X*6) & color(Exp,C).

contiguas(X,X,Y1,Y2) :-Y2  < Y1 & tam(N) & X >=0 & X < N & Y1 < N-1 & Y1 = Y2+1.
contiguas(X,X,Y1,Y2) :-Y2  > Y1 & tam(N) & X >=0 & X < N & Y2 < N-1 & Y2 = Y1+1.
contiguas(X,X,Y1,Y2) :- Y2  < Y1  & Y2 >= 0 & 0 <= X & X < N & Y2 = Y1-1.
contiguas(X,X,Y1,Y2) :- Y2  > Y1  & Y1 >= 0 & 0 <= X & X < N & Y1 = Y2-1.
contiguas(X1,X2,Y,Y) :- X2  < X1 & tam(N) & 0 <= Y & Y < N & X1 < N-1 & X1 = X2+1.
contiguas(X1,X2,Y,Y) :- X2  > X1 & tam(N) & 0 <= Y & Y < N & X2 < N-1 & X2 = X1+1.
contiguas(X1,X2,Y,Y) :-  X2  < X1 & X2 >= 0 & 0 <= Y & Y < N & X2 = X1-1.
contiguas(X1,X2,Y,Y) :- X2  > X1 & X1 >= 0 & 0 <= Y & Y < N & X1 = X2-1.

freeGroup(X,Y,C) :- 
	not groupFileA(X,Y,C) & not groupFileB(X,Y,C) & not groupFileE(X,Y,C) & not groupColumnC(X,Y,C) & not groupColumnD(X,Y,C) & not groupColumnF(X,Y,C)
	& not groupColumn4C(X,Y,C) & not groupColumn4C(X,Y,C) & not groupFile4A(X,Y,C) & not groupFile4B(X,Y,C) & not groupFile5(X,Y,C) & not groupColumn5(X,Y,C)
	& not groupCuadradoA(X,Y,C) & not groupCuadradoB(X,Y,C) & not groupCuadradoC(X,Y,C) & not groupCuadradoD(X,Y,C) & not groupT(X,Y,C) & not groupT2(X,Y,C)
	& not groupT3(X,Y,C).

	//Agrupaciones de 3
groupFileA(X,Y,C) :- // OO_
	tam(N) & X-2 >= 0 & steak(C,X-1,Y) & steak(C,X-2,Y).

	groupFileB(X,Y,C) :- // _OO
	tam(N) & X+2 < N & steak(C,X+1,Y) & steak(C,X+2,Y).

	groupColumnC(X,Y,C) :- // Nueva abajo vertical
	tam(N) & Y-2 >= 0 & steak(C,X,Y-1) & steak(C,X,Y-2).

	groupColumnD(X,Y,C) :- // Nueva arriba vertical
	tam(N) & Y+2 < N & steak(C,X,Y+1) & steak(C,X,Y+2).

	groupFileE(X,Y,C) :- // O_O
	tam(N) & X-1 >= 0 & X+1 < N & steak(C,X+1,Y) & steak(C,X-1,Y).

	groupColumnF(X,Y,C) :- // Nueva medio vertical
	tam(N) & Y-1 >= 0 & Y+1 < N & steak(C,X,Y-1) & steak(C,X,Y+1).
	
	groupFile4A(X,Y,C) :- // OO_O
	tam(N) & X-2 >= 0 & X+1 < N & steak(C,X-1,Y) & steak(C,X-2,Y)& steak(C,X+1,Y).

groupFile4B(X,Y,C) :- // O_OO
	tam(N) &  X-1 >= 0 & X+2 < N & steak(C,X+1,Y) & steak(C,X+2,Y) & steak(C,X-1,Y).
	
	groupFile5(X,Y,C) :- //OO_OO
	tam(N) & X-2 >= 0 & X+2 < N & steak(C,X-1,Y) & steak(C,X-2,Y)& steak(C,X+1,Y) & steak(C,X+2,Y).
	
	groupColumn4C(X,Y,C) :- //vertical hueco segundo
	tam(N) & Y-1 >= 0 & Y+2 < N & steak(C,X,Y-1) & steak(C,X,Y+1) & steak(C,X,Y+2).
	
	groupColumn4D(X,Y,C) :- //vertical hueco tercero
tam(N)  & Y-2 >=0 & Y+1 < N & steak(C,X,Y-2) & steak(C,X,Y-1) & steak(C,X,Y+1).

	
	groupColumn5(X,Y,C) :- //Nueva en el medio de columna de 5
	tam(N) & Y+2 < N & Y-2 >= 0 & steak(C,X,Y+1) & steak(C,X,Y+2) & steak(C,X,Y-1) & steak(C,X,Y-2).
	
	//Cuadrado hueco arriba der
	groupCuadradoA(X,Y,C) :-
	tam(N) & X-1  >= 0 & Y+1 < N & steak(C,X-1,Y) & steak(C,X-1,Y+1) & steak(C,X,Y+1).
	
	//Cuadrado hueco arriba izq
	groupCuadradoB(X,Y,C):-
	tam(N) & X+1 < N & Y+1 < N & steak(C,X+1,Y+1) & steak(C,X+1,Y) & steak(C,X,Y+1).
	
	//Cuadrado hueco abajo izq
	groupCuadradoC(X,Y,C):-
	tam(N) & X+1 < N & Y-1 >= 0 & steak(C,X+1,Y) & steak(C,X+1,Y-1) & steak(C,X,Y-1).

	//Cuadrado hueco abajo der
	groupCuadradoD(X,Y,C):-
	tam(N) & X-1 >= 0 & Y-1 >= 0 & steak(C,X-1,Y) & steak(C,X-1,Y-1) & steak(C,X,Y-1).

	groupT(X,Y,C) :- //T normal
	tam(N) & Y+2 < N & X+1 < N & X-1 >= 0 & steak(C,X-1,Y) & steak(C,X+1,Y) & steak(C,X,Y+1) & steak(C,X,Y+2).
	
	groupT2(X,Y,C) :- //T invertida
	tam(N) & Y-2 >= 0 & X+1 < N & X-1 >=0 & steak(C,X,Y-1) & steak(C,X,Y-2) & steak(C,X+1,Y) & steak(C,X-1,Y).
	
	groupT3(X,Y,C) :- //T derecha
	tam(N) & Y+1 < N & Y-1 >= 0 & X-2 >= 0 & steak(C,X,Y+1) & steak(C,X,Y-1) & steak(C,X-1,Y) & steak(C,X-2,Y).

	groupT4(X,Y,C) :- //T izquierda
	tam(N) & Y+1 < N & Y-1 >= 0 & X+2 < N & steak(C,X,Y+1) & steak(C,X,Y-1) & steak(C,X+1,Y) & steak(C,X+2,Y).



/* Initial goals */

!start.

/* Plans */

+!start : true & sizeof(N)<- 
	//!putObstacle(3,2); //put(3,2,4,0);
	//!putObstacle(7,8); //put(7,8,4,0);
	!iniciarTablero;
	/*for(.range(Y,N,0,-1)){
		for(.range(X,0,N)){
				+detect(X,Y);
		};
	};*/
	//!putObstacle(5,6); //
	.all_names(L);
	.wait(100);
	//!iniciarJuego;	
	if (.member(player,L)){
		.send(player,tell,canExchange);}
	else {
		.print("El agente player no existe mas.");
	};
	//!colocame;
	.print("Goodbye world.").

+!clearColor(C) : sizeof(N) <-
	for (.range(X,0,N)) {
		for (.range(Y,N,0,-1)) {
			if (steak(C,X,Y)) {}
			else{
				.print("Intentamos eliminar la ficha en: (", X, ", ", Y,"), que es de color: ",C);
				//.wait(700);
				deleteSteak(C,X,Y);
				-steak(C,X,Y)[source(percept)];
				put(X,Y,0,0);}			
		}
	}.

+!clearFile(Y) : sizeof(N) <-
	for (.range(X,0,N)) {
		if (steak(C,X,Y)) {
		-steak(C,X,Y)[source(percept)];
		deleteSteak(C,X,Y)};
		put(X,Y,0,0);	}.
	
+!clearNFile(N,X,Y) <-
	for (.range(I,0,N-1)) {
		if (steak(C,X+I,Y)) {
		-steak(C,X+I,Y)[source(percept)];
		deleteSteak(C,X+I,Y)};
		put(X+I,Y,0,0);	}.

+!clearNColumn(N,X,Y) <-
	for (.range(J,0,N-1)) {
		if (steak(C,X,Y+J)) {
		-steak(C,X,Y+J)[source(percept)];
		deleteSteak(C,X,Y+J)};
		put(X,Y+J,0,0);	}.
		
+!clearColumn(X) : sizeof(N) <-
	for (.range(Y,0,N)) {
		if (steak(C,X,Y)) {
		-steak(C,X,Y)[source(percept)];
		deleteSteak(C,X,Y)};
		put(X,Y,0,0);
	}.
	
+!recorreMapa(Mapa) : sizeof(N) <-
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
	
+!iniciarTablero : mapa(Mapa) & sizeof(N) <-
	!recorreMapa(Mapa).
	
+!iniciarTablero : not mapa(Mapa) & sizeof(N) <-
	!putObstacle(1,7);
	!putObstacle(7,3);
	!putObstacle(4,1);

	


	
	for (.range(Y,N,0,-1)) {
		for (.range(X,0,N)) {
			
			?chooseC(C);
			if (freeGroup(X,Y,C)) {
				.print("Pongo ficha de color: ",C);
				put(X,Y,C,0);
			} else {
			    .print("Detectada agrupación de color: ",C," ......................");
				if (C<512) {C1 = C*2;} else {C1 = 16;};
				
				.print("Pongo ficha de color: ",C1);
				put(X,Y,C1,0);
			}
		}
	};
	//!checkGroups.
	!initSpecials.

+!initSpecials : sizeof(N) <-
	!putIp(N-5,6);
	!putIp(5,N-6);
	!putCt(0,6);
	!putCo(0,N-5);
	!putGs(N-6,3);
	.print("Se acabo la inicialización").

+!putGs(X,Y) : steak(C,X,Y) <-
	+gs(X,Y,C);
	deleteSteak(C,X,Y);
	put(X,Y,C,3);
	.send(player,tell,gs(X,Y,C)); 
	.
	
+!putGs(X,Y) <-
	.print("La posición: (",X,",",Y,"), no tiene ninguna pieza que promocionar.").
	
+!putCo(X,Y) : steak(C,X,Y) <-
	+co(X,Y,C);
	deleteSteak(C,X,Y);
	put(X,Y,C,4);
	.send(player,tell,co(X,Y,C));
.
	
+!putCo(X,Y) <-
	.print("La posición: (",X,",",Y,"), no tiene ninguna pieza que promocionar.").
	
+!putCt(X,Y) : steak(C,X,Y) <-
	+ct(X,Y,C);
	deleteSteak(C,X,Y);
	put(X,Y,C,2);
	.send(player,tell,ct(X,Y,C));
	.
	
+!putCt(X,Y) <-
	.print("La posición: (",X,",",Y,"), no tiene ninguna pieza que promocionar.").
	
+!putIp(X,Y) : steak(C,X,Y) <-
	+ip(X,Y,C);
	
	deleteSteak(C,X,Y);
	put(X,Y,C,1);
	.send(player,tell,ip(X,Y,C));
	.
	
+!putIp(X,Y) <-
	.print("La posición: (",X,",",Y,"), no tiene ninguna pieza que promocionar.").
	
+!putObstacle(X,Y) : sizeof(N) & X<N+1 & Y<N+1 & X>-1 & Y>-1 <-
	if (steak(C,X,Y)) {
		deleteSteak(C,X,Y);
		.print("Hay una pieza que debo eliminar antes de colocar el obstaculo en: (",X,",",Y,").");
	} else {
		.print("No hace falta eliminar ninguna pieza, la casilla esta vacia.");
	};
	+obstacle(X,Y);
	put(X,Y,4,0).
	
+!putObstacle(X,Y) : sizeof(N) <-
	.print("No puedo colocar un obstaculo en la celta: (", X,",",Y,") del tablero de dimensión: ",N+1,"x",N+1,".").
	
+!colaterales(X,Y): sizeof(N) <-
		for (.range(Y,0,N)) {
			
			+detect(X,Y);
		}
	.

+movs(0)<- .send(player,tell,stop);.print("MOVIMIENTOS AGOTADOS");.print("FIN DE LA PARTIDA").

	
	+puntuaGroups4A(X2,Y2) : 	groupFile4A(X2,Y2,C)  <-
	
	-+pointOnMov(8);!actualize.

+puntuaGroups4B(X2,Y2) : 	groupFile4B(X2,Y2,C)  <-	
-+pointOnMov(8);!actualize.
	
	+puntuaGroups5A(X2,Y2) : 	groupFile5(X2,Y2,C)  <-
	
	-+pointOnMov(10); !actualize.
	
	
	+puntuaGroups4C(X2,Y2) : 	groupColumn4C(X2,Y2,C)  <-
	
	-+pointOnMov(4);!actualize.

+puntuaGroups4D(X2,Y2) : 	groupColumn4D(X2,Y2,C)  <-
	
	-+pointOnMov(4);!actualize.
	
	+puntuaGroups5B(X2,Y2) : 	groupColumn5(X2,Y2,C)  <-
	
	-+pointOnMov(10);!actualize.
	
	//Hueco arriba der
	+puntuaGroupsCuadrA(X2,Y2) : 	groupCuadradoA(X2,Y2,C)  <-
	
-+pointOnMov(8);!actualize.

	//Hueco arriba izq
	+puntuaGroupsCuadrB(X2,Y2):	groupCuadradoB(X2,Y2,C) <-

	-+pointOnMov(8);!actualize.

	//Hueco abajo izq 
	+puntuaGroupsCuadrC(X2,Y2):	groupCuadradoC(X2,Y2,C) <-

	-+pointOnMov(8);!actualize.

	//Hueco abajo der
	+puntuaGroupsCuadrD(X2,Y2):	groupCuadradoD(X2,Y2,C) <-

	-+pointOnMov(8);!actualize.

	
	+puntuaGroupsT(X2,Y2) : 	groupT(X2,Y2,C)  <-
	
	-+pointOnMov(6);!actualize.
	
	+puntuaGroupsT2(X2,Y2) : 	groupT2(X2,Y2,C)  <-
	
	-+pointOnMov(6);!actualize.
	
	+puntuaGroupsT3(X2,Y2) : 	groupT3(X2,Y2,C)  <-
	
	-+pointOnMov(6);!actualize.
	
	+puntuaGroupsT4(X2,Y2) : 	groupT4(X2,Y2,C)  <-
	
	-+pointOnMov(6);!actualize.
	

+detectGroupsA(X2,Y2) : 	groupFileA(X2,Y2,C)  <-
	
	.print("BORRANDO EN HORIZONTAL");+cleanSteaks(X2,Y2);+cleanSteaks(X2-1,Y2);+cleanSteaks(X2-2,Y2).

+detectGroupsB(X2,Y2) : 	groupFileB(X2,Y2,C)  <-
	
	.print("BORRANDO EN HORIZONTAL");+cleanSteaks(X2,Y2);+cleanSteaks(X2+1,Y2);+cleanSteaks(X2+2,Y2).

+detectGroupsC(X2,Y2) : 	groupColumnC(X2,Y2,C)  <-
	
	.print("BORRANDO EN VERTICAL");+cleanSteaks(X2,Y2);+cleanSteaks(X2,Y2-1);+cleanSteaks(X2,Y2-2).


+detectGroupsD(X2,Y2) : 	groupColumnD(X2,Y2,C)  <-
	
	.print("BORRANDO EN VERTICAL");+cleanSteaks(X2,Y2);+cleanSteaks(X2,Y2+1);+cleanSteaks(X2,Y2+2).

+detectGroupsE(X2,Y2) : 	groupFileE(X2,Y2,C)  <-
	
	.print("BORRANDO EN HORIZONTAL");+cleanSteaks(X2-1,Y2);+cleanSteaks(X2,Y2);+cleanSteaks(X2+1,Y2).

+detectGroupsF(X2,Y2) : 	groupColumnF(X2,Y2,C)  <-
	
	.print("BORRANDO EN VERTICAL");+cleanSteaks(X2,Y2-1);+cleanSteaks(X2,Y2);+cleanSteaks(X2,Y2+1).

	
	+detectGroups4A(X2,Y2) : 	groupFile4A(X2,Y2,C)  <-
	
	.print("BORRANDO 4 EN HORIZONTAL");!putIp(X2-2,Y2)  ;.print("He creado un IP (+4)") ;+cleanSteaks(X2,Y2);+cleanSteaks(X2+1,Y2);+cleanSteaks(X2-1,Y2).

+detectGroups4B(X2,Y2) : 	groupFile4B(X2,Y2,C)  <-
	
	.print("BORRANDO 4 EN HORIZONTAL");!putIp(X2+2,Y2)  ;.print("He creado un IP (+4)") ;+cleanSteaks(X2,Y2);+cleanSteaks(X2+1,Y2);+cleanSteaks(X2-1,Y2).
	
	+detectGroups5A(X2,Y2) : 	groupFile5(X2,Y2,C)  <-
	
	.print("BORRANDO 5 EN HORIZONTAL");!putCt(X2,Y2)     ;.print("He creado un CT (+10)") ;+cleanSteaks(X2-1,Y2);+cleanSteaks(X2-2,Y2);+cleanSteaks(X2+1,Y2);+cleanSteaks(X2+2,Y2).
	
	
	+detectGroups4C(X2,Y2) : 	groupColumn4C(X2,Y2,C)  <-
	
	.print("BORRANDO 4 EN VERTICAL");!putIp(X2,Y2+2)    ;.print("He creado un IP (+4)") ;+cleanSteaks(X2,Y2);
	+cleanSteaks(X2,Y2+1);
	+cleanSteaks(X2,Y2-1).

+detectGroups4D(X2,Y2) : 	groupColumn4D(X2,Y2,C)  <-
	
	.print("BORRANDO 4 EN VERTICAL");!putIp(X2,Y2-2)    ;.print("He creado un IP (+4)") ;+cleanSteaks(X2,Y2);
	+cleanSteaks(X2,Y2+1);
	+cleanSteaks(X2,Y2-1).
	
	+detectGroups5B(X2,Y2) : 	groupColumn5(X2,Y2,C)  <-
	
	.print("BORRANDO 5 EN VERTICAL");!putCt(X2,Y2)     ;.print("He creado un CT (+10)") ;+cleanSteaks(X2,Y2+1);
	+cleanSteaks(X2,Y2+2);
	+cleanSteaks(X2,Y2-1);+cleanSteaks(X2,Y2-2).
	
	//Hueco arriba der
	+detectGroupsCuadrA(X2,Y2) : 	groupCuadradoA(X2,Y2,C)  <-
	
	.print("BORRANDO CUADRADO");!putGs(X2-1,Y2+1)  ;.print("He creado un GS (+8)") ;+cleanSteaks(X2,Y2);
	+cleanSteaks(X2-1,Y2);
	+cleanSteaks(X2,Y2+1).

	//Hueco arriba izq
	+detectGroupsCuadrB(X2,Y2):	groupCuadradoB(X2,Y2,C) <-

	.print("BORRANDO CUADRADO");!putGs(X2,Y2+1)  ;.print("He creado un GS (+8)") ;+cleanSteaks(X2,Y2);
	+cleanSteaks(X2+1,Y2);
	+cleanSteaks(X2+1,Y2+1).

	//Hueco abajo izq 
	+detectGroupsCuadrC(X2,Y2):	groupCuadradoC(X2,Y2,C) <-

	.print("BORRANDO CUADRADO");!putGs(X2,Y2)  ;.print("He creado un GS (+8)") ;+cleanSteaks(X2,Y2);
	+cleanSteaks(X2,Y2-1);
	+cleanSteaks(X2+1,Y2-1);
	+cleanSteaks(X2+1,Y2).

	//Hueco abajo der
	+detectGroupsCuadrD(X2,Y2):	groupCuadradoD(X2,Y2,C) <-

	.print("BORRANDO CUADRADO");!putGs(X2-1,Y2)  ;.print("He creado un GS (+8)") ;+cleanSteaks(X2,Y2);
	+cleanSteaks(X2-1,Y2-1);
	+cleanSteaks(X2,Y2-1).

	
	+detectGroupsT(X2,Y2) : 	groupT(X2,Y2,C)  <-
	
	.print("BORRANDO T 0º");!putCo(X2,Y2)   ;.print("He creado un CO (+6)") ;+cleanSteaks(X2-1,Y2);
	+cleanSteaks(X2+1,Y2);
	+cleanSteaks(X2,Y2+1);+cleanSteaks(X2,Y2+2).
	
	+detectGroupsT2(X2,Y2) : 	groupT2(X2,Y2,C)  <-
	
	.print("BORRANDO T 180º");!putCo(X2,Y2)   ;.print("He creado un CO (+6)") ;+cleanSteaks(X2+1,Y2);
	+cleanSteaks(X2-1,Y2);+cleanSteaks(X2,Y2-1);
	+cleanSteaks(X2,Y2-2).
	
	+detectGroupsT3(X2,Y2) : 	groupT3(X2,Y2,C)  <-
	
	.print("BORRANDO T 90º");!putCo(X2,Y2)   ;.print("He creado un CO (+6)") ;+cleanSteaks(X2,Y2+1);
	+cleanSteaks(X2,Y2-1);
	+cleanSteaks(X2-1,Y2);+cleanSteaks(X2-2,Y2).
	
	+detectGroupsT4(X2,Y2) : 	groupT4(X2,Y2,C)  <-
	
	.print("BORRANDO T 270º");!putCo(X2,Y2)   ;.print("He creado un CO (+6)") ;+cleanSteaks(X2+1,Y2);
	+cleanSteaks(X2+2,Y2);
	+cleanSteaks(X2,Y2-1);+cleanSteaks(X2,Y2+1).
	



+detect(X2,Y2)<-+puntuaGroups5A(X2,Y2);+puntuaGroups5B(X2,Y2);+puntuaGroupsCuadrA(X2,Y2);+puntuaGroupsCuadrB(X2,Y2);+puntuaGroupsCuadrC(X2,Y2);+puntuaGroupsCuadrD(X2,Y2); +puntuaGroupsT(X2,Y2);+puntuaGroupsT2(X2,Y2); +puntuaGroupsT3(X2,Y2);+puntuaGroupsT4(X2,Y2);+puntuaGroups4A(X2,Y2);+puntuaGroups4B(X2,Y2);+puntuaGroups4C(X2,Y2); +puntuaGroups4D(X2,Y2);+detectGroups5A(X2,Y2);+detectGroups5B(X2,Y2);+detectGroupsCuadrA(X2,Y2);+detectGroupsCuadrB(X2,Y2);+detectGroupsCuadrC(X2,Y2);+detectGroupsCuadrD(X2,Y2); +detectGroupsT(X2,Y2);+detectGroupsT2(X2,Y2); +detectGroupsT3(X2,Y2);+detectGroupsT4(X2,Y2);+detectGroups4A(X2,Y2);+detectGroups4B(X2,Y2);+detectGroups4C(X2,Y2); +detectGroups4D(X2,Y2);+detectGroupsA(X2,Y2);+detectGroupsB(X2,Y2);+detectGroupsC(X2,Y2);+detectGroupsD(X2,Y2);+detectGroupsE(X2,Y2);+detectGroupsF(X2,Y2).

+detect(X2,Y2)<-.print("caca de la vaca").
+!actualize : pointOnMov(Points) & totalPoints(Total) <-
 
 -+totalPoints(Points+Total);
 ?totalPoints(T);.print("PUNTOS: ",T);
 -+pointOnMov(0).
 
 +!actualizeMovs : movs(N)  <-
 
 -+movs(N-1);
 ?movs(T);.print("------------QUEDAN ",T, " MOVIMIENTOS-------------").

 

 
/* 
Con esta solucion de piezas especiales, debe ser el juez el que avise al 
"player" de la localizaci�n de las piezas especiales
*/
 +moveDown (X,S) :sizeof(N) & X<N+1 & S<N+1 & X>-1 & S>-1 <-
	
		for (.range(Y,S,0,-1)) {
		
			if(obstacle(X,Y-1) & steak(K,X+1,Y-1)& (moveDown(X,S))){
				
				
				.print("Cambio a la columna: ", X-1);	
			
				 ?steak(K,X+1,Y-1);
				
				 deleteSteak(K,X+1,Y-1);
				 
				 put(X,Y,K,0);
				   if(ct(X+1,Y-1,Q)){
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
				 .wait(100);
				 -moveDown(X,S);
				 
				
				 
				 
				 } 
			else {if(steak(Q,X,Y-1)& not(obstacle(Q,X,Y-1))&(moveDown(X,S))){
				.print("estoy borrando la columna: ", X);
				
				 ?steak(Q,X,Y-1);
			
				  
				  
				  
				 deleteSteak(Q,X,Y-1);
				 put(X,Y,Q,0);
				 if(ct(X,Y-1,Q)){
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
				
	}.wait(200);-moveDown(X,S); .

+accionIlegal(Ag) : amarilla(N) <- 
	if (N<3) {-+amarilla(N+1)}
	else {+trampa(Ag)}.
	
+accionIlegal(Ag) : not amarilla(N) <- +amarilla(1). // Controla si algun player intenta realizar un movimiento ilegal
+cleanSteaks(X,Y): steak(C,X,Y)<- ?steak(C,X,Y); deleteSteak(C,X,Y);
	if(ip(X,Y)){
	-ip(X,Y);
	.print("He borrado un IP (+2)");
	 -+pointOnMov(2);!actualize}
	else {
	if(co(X,Y)){
	-co(X,Y);
	.print("He borrado un CO (+8)");
	 -+pointOnMov(8);!actualize}
	 else {if(ct(X,Y)){
	-ct(X,Y);
	.print("He borrado un CT (+10)");
	 -+pointOnMov(10);!actualize}
	 else {if(gs(X,Y)){
	-gs(X,Y);
	.print("He borrado un GS (+5)");
	 -+pointOnMov(5);!actualize}
	 
	 else{
	.print("He borrado un steak(+1)");
	 -+pointOnMov(1);!actualize;}
	 }}};
	+moveDown(X,Y);!colaterales(X,Y).
	
+cleanSteaks(C,X,Y) <- .print("No hay steak para borrar").
+trampa(Ag) <- 
	.kill_agent(Ag);
	.print("He tenido que matar el agente", Ag, " por tramposo."). // Elimina al tramposo reiterado
	
+putSteak(X)[source(Source)] <-
	.print("He recibido de ", Source, " la solicitud de colocar un steak en: ", X);
	putB(X).

+exchange(X1,Y1,X2,Y2)[source(Source)]:
	steak(C1,X1,Y1) & steak(C2,X2,Y2) & contiguas(X1,X2,Y1,Y2) & not C1 == C2 
<-
	.print("He recibido de ", Source, " la solicitud de intercambiar un steak ", C1, " en: ", X1, ", ",Y1);
	.print("por un steak ", C2, " en: ", X2, ", ",Y2, " que voy a atender inmediatamente.");
	exchange(C1,X1,X2,C2,Y1,Y2); .wait(100);
				  if(ct(X1,Y1,C1)){
				  -ct(X1,Y1);
				  !putCt(X2,Y2);
				  
				  }
				  if(ip(X1,Y1,C1)){
				  -ip(X1,Y1);
				  !putIp(X2,Y2);
				  }
				  if(gs(X1,Y1,C1)){
				  -gs(X1,Y1);
				  !putGs(X2,Y2);
				  }
				  if(co(X1,Y1,C1)){
				  -co(X1,Y1);
				  !putCo(X2,Y2);
				  };if(ct(X2,Y2,C2)){
				  -ct(X1,Y1);
				  !putCt(X1,Y1);
				  }
				  if(ip(X2,Y2,C2)){
				  	-ip(X2,Y2);
				  !putIp(X1,Y1);
				  }
				  if(gs(X2,Y2,C2)){
				  -gs(X2,Y2);
				  !putGs(X1,Y1);
				  }
				  if(co(X2,Y2,C2)){
				  -co(X2,Y2);
				  !putCo(X1,Y1);
				  };
	.print("Hecho el intercambio.");!actualizeMovs
;+detect(X2,Y2).

+exchange(X1,Y1,X2,Y2)[source(Source)] <-
	.print("He recibido de ", Source, " la solicitud de intercambiar dos steak que no son viables");
	.send(Source,tell,tryAgain(X2,Y2))
	.
	
+steak(0,X,Y)[source(Source)] <- -steak(0,X,Y)[source(Source)].

+steak(4,X,Y)[source(Source)] <- -steak(4,X,Y)[source(Source)].

+pos(Ag,X,Y)[source(S)] <- -pos(Ag,X,Y)[source(S)].
