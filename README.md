# complexfunction-graph
draw 2-D graph of given complex function
command before call the func:

syms a b;
syms z;
z = a + b*i;
syms g;
g(a,b) = <here enter the expression of z,a,b>

then call the function:
 draw2dpicsimp(g, lower range of x, upper range of x,lower range of y , upper range of y);
 Notice: it may be quite long to run the program, change xai and yai lower can improve the running time (pixel size of the graph)

