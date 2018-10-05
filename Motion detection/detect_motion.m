clc; clear all; close all;
avi = VideoReader('test.mp4');
wid=avi.Width;
hei=avi.Height;
n=avi.NumberOfFrames;
for i = 1 : n
    img = read(avi, i);
    pixels(:, :, :, i) = img;
end
pic(:,:,:)=pixels(:,:,:,1);
Background(:,:,:)=pic(:,:,:);
imshow(Background);
T=20/255;
m=1;
a=0.05;

for i = 1 : n
    pixel(:, :, i) = (rgb2gray(pixels(:,:,:,i)));
end

for i = 2:n
    d(:,:)=(abs(pixel(:,:,i)-pixel(:,:,i-1)));
    level=graythresh(d);
    B(:,:)=im2bw(d,level);
    figure();subplot(2,1,1);imshow(B,[]);
    %figure,imshow(B);
    for x = 1:hei
        for y =1:wid
            if B(x,y)==0  
                 Background(x,y,:)=a*pixels(x,y,:,i)+(1-a)*Background(x,y,:);
            end
        end
    end
    
subplot(2,1,2);imshow( pixels(:, :, :, i-1),[]);
end

