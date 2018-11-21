function [Xtilde]=irls(R,X,z, W, S, eps)
    %edit eps for image
    I= 5; 
    Xhat=double(X(:)); 
    r=0.8;
    %eps= 300;
   
    for k=1:I
        
        normVec=ones(size(Xhat));
        updateVec=Xhat;
        for i=1:size(R,2)
            w=sum((Xhat(logical(R(:,i)))-z(:,i)).^2).^((r-2)/2);
            normVec=((1-eps*w)*normVec)+eps*w*double(R(:,i));
            zTemp=double(R(:,i));
            zTemp(logical(zTemp))=z(:,i);
            updateVec=((1-eps*w)*updateVec)+eps*w*zTemp;
           
        end
        Xhat=(1./(normVec)).*updateVec;
    end
    Xtilde=Xhat;

Xtilde = reshape(Xtilde, size(X));
Xtilde=(1./(W+ones(size(W)))).*(Xtilde+W.*X);
%figure(3),imshow(mat2gray(Xtilde));
Xtrial=uint8(Xtilde);
Xtilde=double(imhistmatch(Xtrial,S));
%imshow(mat2gray(Xtilde));

end