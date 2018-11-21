%function [Xtilde]=irls(R,X,z)
    % performs IRLS to estimate Xtilde
    % R is matrix of image patches with dimensions 3N_c by N_ij
    % X is initial estimate, dimensions 3N_c by 1
    % z is matrix of style patches with dimensions n by N_ij
    [tNc,Nij]=size(R);
    I= 5; %max number of IRLS iterations
    Xk=double(X(:)); %current estimate
    r=0.8;
    eps= 300;
    unsampled_pixs=double(~(sum(R,2)>0)); %prevent black bar artifacts from gap
    for k=1:I
        %Xrep=repmat(Xk,1,Nij);
        %w= sum((reshape(Xrep(logical(R)),size(z)) - z).^2,1).^((r-2)/2);
        A=ones(size(Xk));%zeros(tNc,1); %prevent black bar artifacts from gap
        B=Xk;%zeros(tNc,1);
        for i=1:Nij
            w=sum((Xk(logical(R(:,i)))-z(:,i)).^2).^((r-2)/2);
            A=((1-eps*w)*A)+eps*w*R(:,i); % diag(R)=Rvec2mat(R)'*Rvec2mat(R)
            temp=R(:,i);
            temp(logical(temp))=z(:,i);
            B=((1-eps*w)*B)+eps*w*temp;
            %A=A+w(i)*diag(R(:,i));
            %B=B+w(i)*Rvec2mat(R(:,i))'*z(:,i);
        end
        Xk=(1./(A)).*B;
    end
    Xtilde=Xk;
img = reshape(Xtilde, [400 400 3]);
imshow(mat2gray(img));