clc;
clear;
close("all");

%% Inizializzazione del grafo
% Caricamento (esplicito) della matrice di adiacenza in formato .mat
z = load("zachary.mat");
A = z.A;
% A = load("zachary.mat");

rng(4);

G = graph(A);
% Grado
deg = sum(A);

%% Indicatori di centralità dei nodi
between = centrality(G,"betweenness");
pagerank = centrality(G,"pagerank");
eigvc = centrality(G,"pagerank");
% between presenta dati molto variabili per cui di solito viene
% normalizzata per la rappresentazione grafica
% Con NodeCData, possiamo assegnare colori diversi (presi da una colormap) ai
% nodi del grafo
figure;
plot(G, "MarkerSize",deg, "NodeCData",between);
colormap("parula"); % Color map di default (prima opzione che compare)
colorbar;
title("Betweeness");

figure;
plot(G, "MarkerSize",deg, "NodeCData",pagerank);
title("PageRank");
colormap("autumn");
colorbar;

figure;
plot(G, "MarkerSize",deg, "NodeCData",eigvc);
title("Eigevenctor Centrality");
colormap("winter");
colorbar;

%% Analisi di comunità 
% Algoritmo di Louvain
[M, Q] = community_louvain(A, 1);

figure;
plot(G, "MarkerSize",deg, "NodeCData",M);
title("Algoritmo di Louvain");
colormap("hsv"); % Evidenziamo le community esistenti
colorbar;
% Sono presenti tre community: chi partecipa al club di Zachary, chi
% partecipa al club del nuovo maestro e chi partecipa ad entrambi i club.

% K-core decomposition
[coreness, kc] = kcoreness_centrality_bu(A);
figure;
plot(G, "MarkerSize",deg, "NodeCData",coreness);
title("K-core decomposition");
colormap("hsv");
colorbar;
