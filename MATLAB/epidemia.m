clear;
clc;
close("all");
rng(4);

%% Inizializzazione del grafo
N = 100;
D = 6;

A = generateER(N,D);
% A = generateBA(N,D);

G = graph(A);


% Stato iniziale
pI = 0.3; % probabilità di infezione
state = round(rand(N,1) < pI);
deg = sum(A);
figure;
p = plot(G, "MarkerSize",deg, "NodeCData",state);


% Mette in pausa l'esecuzione delle script, aspettando [Invio] da 
% parte dell'utente
% pause

%% Simulazione epidemia

% Parametri della simulazione
T = 100   % tempo max. di simulazione
beta = 0.05;
gamma = 0.1;
delta = 1; % Settando delta > 1, rallentiamo la velocità della simulazione

nextState = zeros(N, 1);
nI = sum(state); % Numero di infetti

for t = 1:T
    for i=1:N
        if state(i) == 1 % Nodo attualmente infetto
            % gamma * delta corrisponde alla probabilità di guarigione
            nextState(i) = 1 - (rand() < gamma * delta);
        else  % Nodo attualmente sano
            % sum(A(i,:) * state corrisponde alla matrice di adiacenza dei
            % vicini
            nextState(i) = rand < (beta * sum(A(i,:) * state) * delta);
        end
    end

    state = nextState;
    nI = [nI, sum(state)];
    % Aggiornamento del grafo
    p.NodeCData = state;
    drawnow;
    % pause

    if sum(state) == 0
        % La simulazione si interrompe anticipatamente se tutti i nodi sono
        % guariti; normalmente, la simulazione termina dopo il tempo T
        break;
    end
end

figure;
plot(nI / N);
xlabel("Time");
ylabel("% Infected");