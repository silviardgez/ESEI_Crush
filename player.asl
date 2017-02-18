// Agent player in project conecta4.mas2j

/* Initial beliefs and rules */

/* Initial goals */


/* Plans */

 //.print("hello world."). 
 
+empezar <- !start.

+!start : true <- .send(judge,tell,intercambiar(2,9,3,9));
					.print("cambiamos 0,9 por 1,9s").

