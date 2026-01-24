function A=generateER(N,k)
% [A,deg] = generateER(N, k)
% Generating a random (Erdos-Renyi), undirected network
% N: numer of nodes
% k: (expected) average node degree

p=k/(N-1);   %probability of connection;

A=triu(rand(N)<p); A=A-diag(diag(A));
A=A+A';



