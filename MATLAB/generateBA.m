function A = generateBA(N, m)
% Generating a (pure) Barabasi-Albert scale-free undirected network
% N: number of nodes
% m: number of links of the new inserted node

A=zeros(N,N);      %connectivity matrix
deg=zeros(1,N);     %node degree vector
               
%initial connectivity matrix: full connection of (m+1) nodes
A(1:m+1,1:m+1)=ones(m+1)-eye(m+1);
deg(1:m+1)=m;
degtot=sum(deg(1:m+1));

%growing the network up to N nodes
for j=m+2:N
        
    %adding node j
    %selecting the m links to be added
    for i=1:m
        okay=0;
        while okay==0            
            rn=degtot*rand;
            r=1;
            partial=deg(1);
            while rn>partial
                r=r+1;
                partial=partial+deg(r);
            end;
            %r is the i-th candidate node to be connected with j
            if A(j,r)==0 
                okay=1;
                A(j,r)=1;
            end;
        end;
    end;
    %copying the new j-th line into the new j-th column
    A(1:j-1,j)=A(j,1:j-1)';
    ind(1:j-1)=(A(1:j-1,j)>0);
    deg(ind)=deg(ind)+1;
    deg(j)=m;
    degtot=degtot+2*m;
end;
        
end
