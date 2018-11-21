function [Rmat, Zmat] = patchmatch(n, d, X, S)

ss = size(S);
skip = 1;
trueP = [];
for i = 1:skip:(ss(1)+1-n)
    for j = 1:skip:(ss(2)+1-n)
        Spatch = S(i:i+n-1, j:j+n-1, :);
        trueP = [trueP, Spatch(:)];
    end
end

mp = mean(trueP, 2);
meanmat = mp*ones(1, size(trueP,2));
P = double(trueP) - meanmat;
[V, D] = eig(P*P');

Etotal = sum(diag(D));
E = D(3*n*n,3*n*n);
i = 3*n*n;
Vred = V(:,i);
while(E < 0.95*Etotal)
    i = i - 1;
    Vred = [Vred, V(:,i)];
    E = E + D(i,i);
end

P = Vred' * P;

trueX = [];
sx = size(X);
Rmat = [];
for i = 1:d:(sx(1)+1-n)
    for j = 1:d:(sx(2)+1-n)
        allzero = false(sx);
        allzero(i:i+n-1, j:j+n-1, :) = true;
        Rmat = logical([Rmat, allzero(:)]);
        Xpatch = X(i:i+n-1, j:j+n-1, :);
        trueX = [trueX, Xpatch(:)];
    end
end

meanmat = mp*ones(1, size(trueX,2));
RXmat = Vred' * (double(trueX) - meanmat);

[idx, ~] = knnsearch(P', RXmat');

Zmat = double(trueP(:,idx));
end
