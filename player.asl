// Agent player in project conecta4.mas2j

/* Initial beliefs and rules */

/* Initial goals */


/* Plans */


+empezar <- !start.

+!start : true <- .send(judge,tell,intercambiar(2,9,3,9));
					.wait(3000);
					.send(judge,tell,intercambiar(1,6,1,6));
					.wait(3000);
					.send(judge,tell,intercambiar(5,3,4,3));
					.wait(3000);
					.send(judge,tell,intercambiar(6,4,6,3));
					.wait(3000);
					.send(judge,tell,intercambiar(6,1,5,1));
					.wait(3000);
					.send(judge,tell,intercambiar(0,2,1,2));
					.wait(3000);
					.send(judge,tell,intercambiar(4,8,2,8)).

