tic;
C=imread('/home/archiki/Desktop/SEM-V/DIP/project/images/house.jpg');
S=imread('/home/archiki/Desktop/SEM-V/DIP/project/images/starry_night.jpg');
W=imread('/home/archiki/Desktop/SEM-V/DIP/project/images/content_masks/house.jpg');
W=mat2gray(W);
W=repmat(W, [1 1 3]);
sigma_s = 5;
sigma_r = 0.2;
n=[33,21,13,9];
Lmax=1;
d=[28, 18, 8, 5];
Ialg=2;
Cc= (imhistmatch(C,S));
X=double(Cc);
for l= Lmax:-1:1
    for m=1:size(n,2)
        for k= 1:Ialg
            C_scaled = imresize(reshape(C0, [h0 w0 c]), 1/L);
            S_scaled = imresize(reshape(S0, [h0 w0 c]), 1/L);
    mask = imresize(mask0, 1/L);
    C = C_scaled(:); S = S_scaled(:);
    h = ceil(h0/L); w = ceil(w0/L);
    X=imresize(reshape(X, [h0 w0 c]),1/L);
            X=0.25*X+ 0.75*double(C);
            figure(1),imshow(mat2gray(X));
            [Rmat, Zmat] = patchmatch(n(m), d(m), X, S);
            X= irls(Rmat, X, Zmat, W, S,67*(4-(k+m)/2));
            X=RF(X,sigma_s,sigma_r);
            %figure(k+m),imshow(mat2gray(X));
            
        end
    end
end
figure(2),imshow(mat2gray(uint8(X)));
toc;