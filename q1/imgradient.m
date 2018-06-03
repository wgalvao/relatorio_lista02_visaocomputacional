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

    % função inversa da tangente
    O = atan2(Gx,Gy); 
 end
