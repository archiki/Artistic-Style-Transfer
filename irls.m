function [Xtilde]=irls(R,X,z, W, S, eps)
    %edit eps for image
    I= 5; 
    Xhat=double(X(:)); 
    r=0.8;
    %eps= 300;
    eps=double(eps);
    for k=1:I
        
        normVec=ones(size(Xhat));
        updateVec=Xhat;
        for i=1:size(R,2)
            wTemp=sum(Xhat(logical(R(:,i)))-z(:,i));
            w=(wTemp.^2).^((r-2)/2);
%             if(wTemp <= 10^(-6))
%                 disp('reached')
%                 w = 0.1/eps;
%             end
            
            normVec=((1)*normVec)+eps*w*double(R(:,i));
            %normVec=((1-eps*w)*normVec)+eps*w*double(R(:,i));
            zTemp=double(R(:,i));
            zTemp(logical(zTemp))=z(:,i);
            %updateVec=((1-eps*w)*updateVec)+eps*w*zTemp;
            updateVec=((1)*updateVec)+eps*w*zTemp;
        end
        Xhat=(1./(normVec)).*updateVec;
    end
    Xtilde=Xhat;

Xtilde = reshape(Xtilde, size(X));
figure(3),imshow(mat2gray(Xtilde));
Xtilde=(1./(W+ones(size(W)))).*(Xtilde+W.*X);
figure(4),imshow(mat2gray(Xtilde));
Xtrial=uint8(Xtilde);
Xtilde=double(imhistmatch(Xtrial,S));
%imshow(mat2gray(Xtilde));

end