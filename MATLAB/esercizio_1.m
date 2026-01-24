% Esercitazione MATLAB 09-12-2025
% Inizializzazione di uno script MATLAB nuovo
close("all");
clear;
clc;

% Garantiamo la replicabilità dei risultati
% In alternativa, potremmo eseguire lo script varie volte e considerare una
% media dei risultati ottenuti, visto che i metodi utilizzati sono
% stocastici
rng(2); 
N = 100; % Numero di nodi
D = 6;   

% Generazione matrice di adiacenza A (sparsa anche se non esplicitamente)
% A = generateER(N,D);
A = generateBA(N,D);

% Visualizzazione pattern di sparsità di A
figure;
spy(A);

% Visualizzazione del grafo della rete interattivo
% Ogni nodo è identificato da un id intero
G = graph(A);
% Possiamo modificare il layout (disposizione dei nodi) del grafo per 
% migliorarne la leggibilità
plot(G,"NodeColor","red", "EdgeColor","white", "Layout","circle", ...
     "MarkerSize","red");

% Estrazione del grado 
% Per la rete BA, i primi nodi hanno grado elevato, ma tutti i nodi sono 
% connessi
deg = degree(G);
% Istogramma dei gradi 
% Andamento decrescente per BA
% Andamento a campana per ER
figure;
hist(deg);
xlabel("Grado");
ylabel("Num. nodi");
title("Sequenza di grado");

% Costruzione matrice delle distanze
D = distances(G);
max(max(D));
distall = D(D > -1);
figure;
hist(distall);

% Calcolo delle componenti connesse del grafo (se ogni nodo appartiene alla
% componente con id 1, significa che esiste una sola componente nel grafo)
% Il comando restituisce il vettore delle componenti connesse presenti
% Chiamando solo concomp(G), viene restituito un vettore 
% Sia per BA che per ER esiste una sola componente connessa
idConnectedComps = unique(conncomp(G))

[avgc, cl] = avgClusteringCoefficient(A);
figure;
hist(cl);
% Alcune variabili hanno coefficiente di clustering molto alto, altre molto
% basso (per BA)

