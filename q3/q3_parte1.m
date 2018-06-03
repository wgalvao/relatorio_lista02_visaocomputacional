clc;
clear all;
close all;

I = imread('zebra.png');
I = rgb2gray(I);
I = double(I);

a = 0.375;
d = [((1/4) - (a/2))    (1/4)    a    (1/4)    ((1/4) - (a/2))];
p = d;

L = 5;

Dog = imDog(I,p,d,L);

%%
% imDoG
% Input :
% I - input image
% p - filter
% d - filter
% L - number of levels
% Output :
% DoG - DoG Pyramid
%%

function [Dog] = imDog(I, p, d, L)

p = d;
w = p;

    % calcular os níveis da piramide dado o valor em L
    for z = 1:L
        Gl = imreduce(I,p,d);        
        dim = size(Gl);
    %   nova dimensao da imagem
        downLevel = dim*2;
        EXPAND = zeros(downLevel,class(Gl));
        m = [-2:2];
        n=m;
    
        Gl = [ Gl(1,:) ;  Gl ;  Gl(dim(1),:) ];  
        Gl = [ Gl(:,1)    Gl    Gl(:,dim(2)) ]; 
        kernel = w'*w;

        for i = 0 : downLevel(1) - 1
            for j = 0 : downLevel(2) - 1
                pixeli = (i - m)/2 + 2;  idxi = find(floor(pixeli)==pixeli);
                pixelj = (j - m)/2 + 2;  idxj = find(floor(pixelj)==pixelj);
                A = Gl(pixeli(idxi),pixelj(idxj)).* kernel(m(idxi)+3,m(idxj)+3);
                EXPAND(i + 1, j + 1)= 4 * sum(A(:));
            end
        end
        % Calculando o residuo
        Dog = I - EXPAND;
        % Imprimindo a piramide
        figure; imshow(Dog,[]);               
        % imwrite(mat2gray(Dog),sprintf('zebraDog%d.jpg',z));  
        % retornando o proximo nivel
        I = imreduce(I,p,d);    
    end
end
