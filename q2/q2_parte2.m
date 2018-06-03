clc;
clear all;
close all;

I = imread('zone.png');
% I = rgb2gray(I);
I = double(I);

figure; imshow(I, []);

p = 1/7;
d = [1 1 1 1 1 1 1];
L = 5;

R = impyramid(I, p, d, L);

%%
% impyramid
% Input :
% I - input image
% p - filter
% d - filter
% L - number of levels
% Output :
% P - Pyramid
%%
function [P] = impyramid(I, p, d, L)
   
    % calcular os níveis da piramide dado o valor em L
    for z = 1:L
        
        dim = size(I);
        nextLevel = ceil(dim*0.5);
        P = zeros(nextLevel,class(I)); 
        m = (-2:2);
        n = m;
                
        w = p*d;
        
        Wt2 = w*w';

        I = [I(1,:); I(1,:); I; I(dim(1),:); I(dim(1),:)];  
        I = [I(:,1)  I(:,1) I I(:,dim(2)) I(:,dim(2))]; 

        for i = 0 : nextLevel(1) -1
            for j = 0 : nextLevel(2) -1
                A = I(2*i+m+3,2*j+n+3).*Wt2;
                P(i + 1, j + 1) = sum(A(:));
            end
        end

        I = P;
        figure; imshow(I,[]);               
        
        imwrite(mat2gray(I),sprintf('zone%d.jpg',z))
    
    end

end
