nx = 50;
ny = 50;
V  = zeros(nx,ny);
G  = sparse(nx*ny,nx*ny); 

% Set Boundary Conditions
for i = 1:nx
    for j = 1:ny
        n = j + (i - 1) * ny;
        nxm = j + (i - 2) * ny;
        nxp = j + (i) * ny;
        nym = (j - 1) + (i - 1) * ny;
        nyp = (j + 1) + (i - 1) * ny;
        if j == ny % Top boundary
            G(n,n) = 1;
        elseif i == nx % Right boundary
            G(n,n) = 1;
        elseif i == 1 % Left boundary
            G(n,n) = 1;
        elseif j == 1 % Bottom boundary
            G(n,n) = 1;
        elseif i == j % Diagonal
            G(n,n) = 1;
        else
            G(n, n) = -4;
            G(n, nxm) = 1;
            G(n, nxp) = 1;
            G(n, nym) = 1; 
            G(n, nyp) = 1;
        end
    end
end

figure('name', 'Matrix')
spy(G)

nodes = 20;
[E, D] = eigs(G, nodes, 'SM');

figure('name', 'EigenValues')
plot(diag(D), '*');

np = ceil(sqrt(nodes))
figure('name', 'Nodes')
for k = 1:nodes
    M = E(:,k);
    for i = 1:nx
        for j = 1:ny
            n = j + (i - 1) * ny;
            V(i,j) = M(n);
        end
        subplot(np,np,k)
        surf(V,'linestyle','none')
        title(['EV = ' num2str(D(k,k))])
    end
end
