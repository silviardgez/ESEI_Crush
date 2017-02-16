// Agent judge in project conecta4.mas2j



/* Initial beliefs and rules */
size(10).


/* Initial goals */

!start.

/* Plans */


+!start : true <- !iniciarTablero.

+!iniciarTablero : size(N) <- 
	for (.range(X,1,N)) {
		for (.range(Y,1,N)) {
			put(Y);
		}
	}. 
//+!start : true <- .print("hello world.").


