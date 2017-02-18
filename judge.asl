// Agent judge in project conecta4.mas2j


/* Initial beliefs and rules */
size(10).

contiguas(X,Y1,X,Y2) :- size(N) & Y2< N-1 & Y1 = Y2+1.
contiguas(X,Y1,X,Y2) :- Y2 > 1 & Y1 = Y2-1.
contiguas(X1,Y,X2,Y) :- size(N) & X2< N-1 & X1 = X2+1.
contiguas(X1,Y,X2,Y) :-  X1 = X2+1.

/* Initial goals */

!start.

/* Plans */


+!start : true <- !iniciarTablero;
		.all_names(L); //get the names of all agents in the system
			if (.member(player,L)){ //Check if player exists
				.send(player,tell,empezar);}
			else {
				.print("El agente player no existe.");
			}. 

+!iniciarTablero : size(N) <- 
	for (.range(X,1,N)) {
		for (.range(Y,1,N)) {
			.random(Z);
			put(Y, math.floor(Z * 5));
		}
	}. 
//& contiguas(X1,Y1,X2,Y2)
+intercambiar(X1,Y1,X2,Y2)[source(Source)]: steak(C1,X1,Y1) & steak(C2,X2,Y2) & not C1 == C2 <-
	.print(Source, " va a mover ", X1,",",Y1, " por ", X2,",",Y2, ".");
	.wait(1000);
	intercambiarColores(C1,X1,Y1,C2,X2,Y2);
	.wait(3000).

+intercambiar(X1,Y1,X2,Y2)[source(Source)] <-
	.print(Source, " intenta realizar movimiento incorrecto.").


