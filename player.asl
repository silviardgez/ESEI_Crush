// Agent player in project conecta4.mas2j

/* Initial beliefs and rules */


iguales(X1,Y1,X2,Y2) :- steak(Color, X1, Y1)& steak(Color, X2, Y2). //dos fichas son iguales si tienen el mismo color



/* Initial goals */

//!start.



/* Plans */

+canExchange <- !start.

+!start : sizeof(T) <-for(.range(X, 0, T)){
							for(.range(Y, 0, T)){ //Solo solicita exchange fichas que produzcan una agrupación de 3 con los movimientos permitidos en el candy crush
							if(not(stop)){
								if(not(iguales(X,Y,X-1,Y)) & iguales(X,Y,X-2,Y)& iguales(X,Y,X-3,Y)){
								.print("Solicito exchange ficha en (",X-1,",",Y,") por ficha en (",X,",",Y,")");
								.send(judge,tell,exchange(X,Y,X-1,Y));.wait(3000);
								  
								}
								
								if(not(iguales(X,Y,X+1,Y)) & iguales(X,Y,X+1,Y+1)& iguales(X,Y,X+1,Y+2)){
								.print("Solicito exchange ficha en (",X,",",Y,") por ficha en (",X+1,",",Y,")");
								.send(judge,tell,exchange(X,Y,X+1,Y));.wait(3000);
								 
								}}
							
					}}.
	/* Igual este mecanismo de control sobre las piezas no es muy adecuado para el tablero elegido */

+tryAgain(X,Y)<- ?sizeof(T);
	for(.range(X+1, 0, T)){
							for(.range(Y, 0, T)){ //Solo solicita exchange fichas que produzcan una agrupación de 3 con los movimientos permitidos en el candy crush
							if(not(stop)){
								if(not(iguales(X,Y,X-1,Y)) & iguales(X,Y,X-2,Y)& iguales(X,Y,X-3,Y)){
								.print("Solicito exchange ficha en (",X-1,",",Y,") por ficha en (",X,",",Y,")");
								.send(judge,tell,exchange(X,Y,X-1,Y));.wait(3000);
								  
								}
								
								if(not(iguales(X,Y,X+1,Y)) & iguales(X,Y,X+1,Y+1)& iguales(X,Y,X+1,Y+2)){
								.print("Solicito exchange ficha en (",X,",",Y,") por ficha en (",X+1,",",Y,")");
								.send(judge,tell,exchange(X,Y,X+1,Y));.wait(3000);
								 
								}}
							
					}}.

+pos(Ag,X,Y)[source(S)] <- -pos(Ag,X,Y)[source(S)]. 
