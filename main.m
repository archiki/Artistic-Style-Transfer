tic;

C=imread('/home/archiki/Desktop/SEM-V/DIP/project/images/eagles.jpg');
S=imread('/home/archiki/Desktop/SEM-V/DIP/project/images/starry.jpg');
W=imread('/home/archiki/Desktop/SEM-V/DIP/project/images/content_masks/eagles.jpg');
W=mat2gray(W);
W=repmat(W, [1 1 3]);
sigma_s = 5;
sigma_r = 0.2;
n=[33,21,13,9];
Lmax=3;
d=[28, 18, 8,5];
Ialg=2;
Cc= (imhistmatch(C,S));
X=double(Cc)+50*randn(size(Cc));
Ctemp=X;
for l= Lmax:-1:1
    L=2^(l-1);
    Crescaled = imresize(Cc, 1/L);
    Srescaled = imresize(S, 1/L);
    Wrescaled= imresize(W, 1/L);
            %h = ceil(size(C,1)/L); w = ceil(size(C,2)/L);
    X=imresize(X,1/L);
    
    for m=1:size(n,2)
        for k= 1:Ialg
            %if L > 1
            X= 0.75*X + 0.25*double(Crescaled);
            %end
            figure(1),imshow(mat2gray(X));
            [Rmat, Zmat] = patchmatch(n(m), d(m), X, Srescaled);
            X= irls(Rmat, X, Zmat, Wrescaled, Srescaled,40*(6-ceil((m+k)/2)));
            X=RF(X,sigma_s,sigma_r);
            %figure(4),imshow(mat2gray(X));
            
        end
    end
    X=imresize(X,L);
end
figure(2),imshow(mat2gray((X)));
toc;