content=imread('images/selfie.jpg');
% 
content=rgb2gray(content);
sigma_filt=1;
hsize_smooth=5;
sigma_smooth=4;
gaussian_1= fspecial('gaussian',hsize_smooth,sigma_smooth);
smooth_img=imfilter(content,gaussian_1);
figure(1),imshow(smooth_img);
E = edge(smooth_img, 'roberts', 0.036);
%E = edge(smooth_img,'canny',0.04,sigma_filt);
temp=activecontour(smooth_img,E);
E(:,1:3)=0; E(:,399:400)=0; E(1:3,:)=0; E(399:400,:)=0;
figure(5), imshow(E);
weights = imgaussfilt(double(temp+12*E),sigma_smooth);
figure(3),imshow(mat2gray(double(content).* weights));
figure(4), imshow(weights);
%save(str("/home/archiki/Desktop/SEM-V/DIP/project/images/content_masks/house.mat"),weights);
%imwrite(weights,'images/content_masks/selfie.jpg');