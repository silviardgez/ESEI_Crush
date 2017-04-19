// Agent player in project conecta4.mas2j

/* Initial beliefs and rules */


iguales(X1,Y1,X2,Y2) :- steak(Color, X1, Y1)& steak(Color, X2, Y2). //dos fichas son iguales si tienen el mismo color
nivel(1).

/* Initial goals */

//!start.



/* Plans */
+totalPoints(Total)[source(Source)]<- if(Total>=100){+ganador}. //el jugador comprueba si ya ha conseguido los 100 puntos necesarios para superar el nivel

+canExchange <- !start. //cuando el juez le permite intercambiar, comienza

+!start : sizeof(T)  <- while(not(fin)  & not(ganador)  ){ for(.range(X, 0, T)){for(.range(Y, 0, T)){ //mientras no se le hayan acabado los movimientos o haya ganado, recorre el tablero pidiendo intercambios posibles

							 //Solo solicita  intercambios de piezas que produzca la agrupación de cuadrado y de tres (todos los patrones se pueden conseguir con estos intercambios)
						if(not(para) & not(fin) & not(ganador)){
						
								if(not(invalido(X,Y,X+1,Y)) & not(iguales(X,Y,X+1,Y)) & iguales(X,Y,X+2,Y)& iguales(X,Y,X+1,Y+1)& iguales(X,Y,X+2,Y+1)){
								.print("Solicito exchange ficha en (",X,",",Y,") por ficha en (",X+1,",",Y,")");
								.send(judge,tell,exchange(X,Y,X+1,Y));.wait(7000);
								}
								if(not(invalido(X,Y,X,Y+1)) & not(iguales(X,Y,X,Y+1)) & iguales(X,Y,X+1,Y+1)& iguales(X,Y,X,Y+2)& iguales(X,Y,X+1,Y+2)){
								.print("Solicito exchange ficha en (",X,",",Y,") por ficha en (",X,",",Y+1,")");
								.send(judge,tell,exchange(X,Y,X,Y+1));.wait(7000);
								}
								if(not(invalido(X,Y,X,Y+1)) & not(iguales(X,Y,X,Y+1)) & iguales(X,Y,X-1,Y+1)& iguales(X,Y,X-1,Y+2)& iguales(X,Y,X,Y+2)){
								.print("Solicito exchange ficha en (",X,",",Y,") por ficha en (",X,",",Y+1,")");
								.send(judge,tell,exchange(X,Y,X,Y+1));.wait(7000);
								}
								if(not(invalido(X,Y,X-1,Y)) & not(iguales(X,Y,X-1,Y)) & iguales(X,Y,X-2,Y)& iguales(X,Y,X-1,Y+1)& iguales(X,Y,X-2,Y+1)){
								.print("Solicito exchange ficha en (",X,",",Y,") por ficha en (",X-1,",",Y,")");
								.send(judge,tell,exchange(X,Y,X-1,Y));.wait(7000);
								}
								if(not(invalido(X,Y,X-1,Y)) & not(iguales(X,Y,X-1,Y)) & iguales(X,Y,X-1,Y-1)& iguales(X,Y,X-2,Y-1)& iguales(X,Y,X-2,Y)){
								.print("Solicito exchange ficha en (",X,",",Y,") por ficha en (",X-1,",",Y,")");
								.send(judge,tell,exchange(X,Y,X-1,Y));.wait(7000);
								}
								if(not(invalido(X,Y,X,Y-1)) & not(iguales(X,Y,X,Y-1)) & iguales(X,Y,X,Y-2)& iguales(X,Y,X-1,Y-1)& iguales(X,Y,X-1,Y-2)){
								.print("Solicito exchange ficha en (",X,",",Y,") por ficha en (",X,",",Y-1,")");
								.send(judge,tell,exchange(X,Y,X,Y-1));.wait(7000);
								}
								if(not(invalido(X,Y,X+1,Y)) & not(iguales(X,Y,X+1,Y)) & iguales(X,Y,X+1,Y-1)& iguales(X,Y,X+2,Y-1)& iguales(X,Y,X+2,Y)){
								.print("Solicito exchange ficha en (",X,",",Y,") por ficha en (",X+1,",",Y,")");
								.send(judge,tell,exchange(X,Y,X+1,Y));.wait(7000);
								}
								if(not(invalido(X,Y,X,Y+1)) & not(iguales(X,Y,X,Y+1)) & iguales(X,Y,X,Y+2)& iguales(X,Y,X+1,Y-1)& iguales(X,Y,X+1,Y-2)){
								.print("Solicito exchange ficha en (",X,",",Y,") por ficha en (",X,",",Y+1,")");
								.send(judge,tell,exchange(X,Y,X,Y+1));.wait(7000);
								}
								
							
								if(not(invalido(X,Y,X+1,Y)) & not(iguales(X,Y,X+1,Y)) & iguales(X,Y,X+2,Y)& iguales(X,Y,X+3,Y)){
								.print("Solicito exchange ficha en (",X,",",Y,") por ficha en (",X+1,",",Y,")");
								.send(judge,tell,exchange(X,Y,X+1,Y));.wait(7000); //Espera  entre movimientos para facilitar visualización
								}
								if(not(invalido(X,Y,X,Y+1)) & not(iguales(X,Y,X,Y+1)) & iguales(X,Y,X,Y+2)& iguales(X,Y,X,Y+3)){
								.print("Solicito exchange ficha en (",X,",",Y,") por ficha en (",X,",",Y+1,")");	
								.send(judge,tell,exchange(X,Y,X,Y+1));.wait(7000);
								}
								if(not(invalido(X,Y,X-1,Y)) & not(iguales(X,Y,X-1,Y)) & iguales(X,Y,X-2,Y)& iguales(X,Y,X-3,Y)){
								.print("Solicito exchange ficha en (",X,",",Y,") por ficha en (",X-1,",",Y,")");
								.send(judge,tell,exchange(X,Y,X-1,Y));.wait(7000);
								}
								if(not(invalido(X,Y,X,Y-1)) & not(iguales(X,Y,X,Y-1)) & iguales(X,Y,X,Y-2)& iguales(X,Y,X,Y-3)){
								.print("Solicito exchange ficha en (",X,",",Y,") por ficha en (",X,",",Y-1,")");	
								.send(judge,tell,exchange(X,Y,X,Y-1));.wait(7000);}
								
								if(not(invalido(X,Y,X+1,Y)) & not(iguales(X,Y,X+1,Y)) & iguales(X,Y,X+1,Y+1)& iguales(X,Y,X+1,Y+2)){
								.print("Solicito exchange ficha en (",X,",",Y,") por ficha en (",X+1,",",Y,")");
								.send(judge,tell,exchange(X,Y,X+1,Y));.wait(7000);
								}
									if(not(invalido(X,Y,X+1,Y)) & not(iguales(X,Y,X+1,Y)) & iguales(X,Y,X+1,Y-1)& iguales(X,Y,X+1,Y-2)){
								.print("Solicito exchange ficha en (",X,",",Y,") por ficha en (",X+1,",",Y,")");
								.send(judge,tell,exchange(X,Y,X+1,Y));.wait(7000);
								}
								
								if(not(invalido(X,Y,X-1,Y)) & not(iguales(X,Y,X-1,Y)) & iguales(X,Y,X-1,Y+1)& iguales(X,Y,X-1,Y+2)){
								.print("Solicito exchange ficha en (",X,",",Y,") por ficha en (",X-1,",",Y,")");
								.send(judge,tell,exchange(X,Y,X-1,Y));.wait(7000);
								}
									if(not(invalido(X,Y,X-1,Y)) & not(iguales(X,Y,X-1,Y)) & iguales(X,Y,X-1,Y-1)& iguales(X,Y,X-1,Y-2)){
								.print("Solicito exchange ficha en (",X,",",Y,") por ficha en (",X-1,",",Y,")");
								.send(judge,tell,exchange(X,Y,X-1,Y));.wait(7000);
								}
									if(not(invalido(X,Y,X,Y+1)) & not(iguales(X,Y,X,Y+1)) & iguales(X,Y,X+1,Y+1)& iguales(X,Y,X+2,Y+1)){
								.print("Solicito exchange ficha en (",X,",",Y,") por ficha en (",X,",",Y+1,")");
								.send(judge,tell,exchange(X,Y,X,Y+1));.wait(7000);
								}
									if(not(invalido(X,Y,X,Y+1)) & not(iguales(X,Y,X,Y+1)) & iguales(X,Y,X-1,Y+1)& iguales(X,Y,X-2,Y+1)){
								.print("Solicito exchange ficha en (",X,",",Y,") por ficha en (",X,",",Y+1,")");
								.send(judge,tell,exchange(X,Y,X,Y+1));.wait(7000);
								}
								
								if(not(invalido(X,Y,X,Y-1)) & not(iguales(X,Y,X,Y-1)) & iguales(X,Y,X+1,Y-1)& iguales(X,Y,X+2,Y-1)){
								.print("Solicito exchange ficha en (",X,",",Y,") por ficha en (",X,",",Y-1,")");
								.send(judge,tell,exchange(X,Y,X,Y-1));.wait(7000);
								}
									if(not(invalido(X,Y,X,Y-1)) & not(iguales(X,Y,X,Y-1)) & iguales(X,Y,X-1,Y-1)& iguales(X,Y,X-2,Y-1)){
								.print("Solicito exchange ficha en (",X,",",Y,") por ficha en (",X,",",Y-1,")");
								.send(judge,tell,exchange(X,Y,X,Y-1));.wait(7000);
								}
								if(not(invalido(X,Y,X,Y+1)) & not(iguales(X,Y,X,Y+1)) & iguales(X,Y,X-1,Y+1)& iguales(X,Y,X+1,Y+1)){
								.print("Solicito exchange ficha en (",X,",",Y,") por ficha en (",X,",",Y+1,")");
								.send(judge,tell,exchange(X,Y,X,Y+1));.wait(7000);
								}
								if(not(invalido(X,Y,X,Y-1)) & not(iguales(X,Y,X,Y-1)) & iguales(X,Y,X-1,Y-1)& iguales(X,Y,X+1,Y-1)){
								.print("Solicito exchange ficha en (",X,",",Y,") por ficha en (",X,",",Y-1,")");
								.send(judge,tell,exchange(X,Y,X,Y-1));.wait(7000);
								}
								if(not(invalido(X,Y,X-1,Y)) & not(iguales(X,Y,X-1,Y)) & iguales(X,Y,X-1,Y+1)& iguales(X,Y,X-1,Y-1)){
								.print("Solicito exchange ficha en (",X,",",Y,") por ficha en (",X-1,",",Y,")");
								.send(judge,tell,exchange(X,Y,X-1,Y));.wait(7000);
								}
								if(not(invalido(X,Y,X+1,Y)) & not(iguales(X,Y,X+1,Y)) & iguales(X,Y,X+1,Y+1)& iguales(X,Y,X+1,Y-1)){
								.print("Solicito exchange ficha en (",X,",",Y,") por ficha en (",X+1,",",Y,")");
								.send(judge,tell,exchange(X,Y,X+1,Y));.wait(7000);
								} 
								if(not(invalido(X,Y,X+1,Y)) & not(iguales(X,Y,X+1,Y)) & iguales(X,Y,X+1,Y+1)& iguales(X,Y,X+1,Y-1)){
								.print("Solicito exchange ficha en (",X,",",Y,") por ficha en (",X+1,",",Y,")");
								.send(judge,tell,exchange(X,Y,X+1,Y));.wait(7000);
								}
								
									}
									
								
								
							
					}}}; if(ganador){ if(nivel(1)) {.print("NIVEL SUPERADO: HE CONSEGUIDO 100 PUNTOS! :D"); -ganador; .wait(7000); -+nivel(N+1); .send(judge,tell,newLevel);} else {.print("NIVEL SUPERADO: HE CONSEGUIDO 100 PUNTOS! :D");}} else { .print("Se me han acabado los movimientos :(")}.


+tryAgain (X1,Y1,X2,Y2)<-+invalido(X1,Y1,X2,Y2). //almacena cuales son los movimientos invalidos para no repetirlos


