%% Bilateral Filter
%This function perform bilateral filter on an input image 
%imput parametes : _img_ - input(noisy) image, _sig_d_ : spatial variance,
%sig_i - intensity variance

function Output_img = myBilateralFiltering(img, sig_d, sig_i)

Output_img = img;
[h, w, d] = size(img);
p = 13;

% tic;

%%
for layer = 1:d
    X = img(:,:,layer);
    for i = 1:h
        for j = 1:w
            x1 = max(1,i-floor(p/2));
            y1 = max(1,j-floor(p/2));
            x2 = min(h,i+ceil(p/2));
            y2 = min(w,j+ceil(p/2));
            Xij = X(x1:x2,y1:y2);
            
            int_filter = exp(-(Xij - X(i,j)).^2/(2*sig_i^2));
            dist_filter = exp(-(((x1:x2)-i).^2/(2*sig_d^2))')*exp(-((y1:y2)-j).^2/(2*sig_d.^2));
            
            weights = int_filter.*dist_filter;
            Output_img(i,j) = sum(weights.*Xij)/sum(weights);
        end
    end
end

end