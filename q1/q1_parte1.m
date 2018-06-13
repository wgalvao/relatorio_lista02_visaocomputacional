clear;
clear all;
close all;

% Carregando a imagem
I = imread('cameraman.png');

% Suavizando a imagem com um filtro gaussiano 3 x 3
gaussian = [2,4,2; 4,8,4; 2,4,2];
gaussian = 1/16.* gaussian;

% Chamando a funcao
[Gx, Gy, M, O] = imgradient(I);

imwrite(mat2gray(Gx),'Gx.jpg');
imwrite(mat2gray(Gy),'Gy.jpg');

imwrite(mat2gray(M),'M.jpg');
imwrite(O,'O.jpg');

% Apresentando os resultados
figure; 
subplot(2,2,1);
imshow(Gx, []);
title('Gx');
subplot(2,2,2);
imshow(Gy, []);
title('Gy');
subplot(2,2,3);
imshow(M, []);
title('M');
subplot(2,2,4);
imshow(O, []);
title('O');

%%
 % imgradient
 % Input :
 % I - input image
 % Output :
 % Gx - Output image of x gradient
 % Gy - Output image of y gradient
 % M - Output image of magnitude
 % O - Output image of gradient orientation %%

 function [Gx, Gy, M, O] = imgradient(I) 
    % Para escala de cinza
    I = rgb2gray(I);
    
    % Definindo os filtros derivativos p e d
    p = [0.037659 0.249153 0.426375 0.249153 0.037659];
    d = [0.109604 -0.276691 0.00000 -0.276691 0.109604];
    
    gfilter = p*d';

    % Aplicando o filtro na imagem
    I = conv2(I, gfilter);
    
    % filtro hx - SOBEL
    hx = [1,0,-1;2,0,-2;1,0,-1];
    % filtro hy -- transposta de hx
    hy = hx.';
    % Convoluindo a imagem com o filtro hx
    Gx = conv2(I,hx);
    % Convoluindo a imagem com o filtro hy
    Gy = conv2(I,hy);
    
    % Calculando a magnitude
    M = sqrt(Gx.^2 + Gy.^2);

    % funcao inversa da tangente
    O = atan2(Gx,Gy); 
 end
