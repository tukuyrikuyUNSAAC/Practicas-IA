/* Hechos */
tiene(nono,m1).
misil(m1).
americano(west).
enemigo(nono,america).

/* Reglas */
criminal(X) :- americano(X), arma(Y), vende(X,Y,Z), hostil(Z).
vende(west,X,nono) :- misil(X), tiene(nono,X).
arma(X) :- misil(X).
hostil(X) :- enemigo(X,america).

