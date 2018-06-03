clear;
clear all;
close all;

% Carregando a imagem
I = imread('cameraman.png');

% Suavizando a imagem com um filtro gaussiano 3 x 3
gaussian = [2,4,2; 4,8,4; 2,4,2];
gaussian = 1/16.* gaussian;

% Chamando a funcao imgradient para obter M e O
[Gx, Gy, M, O] = imgradient(I);

% Chamando a funcao imedge
[E] = imedge(M, O);

% Apresentando os resultados
figure; imshow(E);

imwrite(E, 'E.jpg');

%%
% imedge
% Input :
% M - Magnitude image
% O - Gradient orientation image
% Output :
% E - Edge image
%%
function [E] = imedge(M , O)

% Eliminando possíveis valores de angulos negativos
[row, col] = size(M);
for i=1:row
    for j=1:col
        if (O(i,j)<0) 
            O(i,j)=360+O(i,j);
        end;
    end;
end;

angleD = zeros(size(M,1));

% Discretizando os angulos em 0, 45, 90, 135 e 180
for i = 1  : row
    for j = 1 : col
        if ((O(i, j) >= 0 ) && (O(i, j) < 22.5) || (O(i, j) >= 157.5) && (O(i, j) < 202.5) || (O(i, j) >= 337.5) && (O(i, j) <= 360))
            angleD(i, j) = 0;
        elseif ((O(i, j) >= 22.5) && (O(i, j) < 67.5) || (O(i, j) >= 202.5) && (O(i, j) < 247.5))
            angleD(i, j) = 45;
        elseif ((O(i, j) >= 67.5 && O(i, j) < 112.5) || (O(i, j) >= 247.5 && O(i, j) < 292.5))
            angleD(i, j) = 90;
        elseif ((O(i, j) >= 112.5 && O(i, j) < 157.5) || (O(i, j) >= 292.5 && O(i, j) < 337.5))
            angleD(i, j) = 135;
        elseif (O(i, j) > 337.5)
            angleD(i, j) = 180;
        end;
    end;
end;

mask = zeros(size(M,1));

%Non-Maximum Supression
for i=2:row-1
    for j=2:col-1
        if (angleD(i,j)==0)
            mask(i,j) = (M(i,j) == max([M(i,j), M(i,j+1), M(i,j-1)]));
        elseif (angleD(i,j)==45)
            mask(i,j) = (M(i,j) == max([M(i,j), M(i+1,j-1), M(i-1,j+1)]));
        elseif (angleD(i,j)==90)
            mask(i,j) = (M(i,j) == max([M(i,j), M(i+1,j), M(i-1,j)]));
        elseif (angleD(i,j)==135)
            mask(i,j) = (M(i,j) == max([M(i,j), M(i+1,j+1), M(i-1,j-1)]));
        elseif (angleD(i,j)==180)
            mask(i,j) = (M(i,j) == max([M(i,j), M(i-1,j), M(i+1,j)]));
        end;
    end;
end;

mask = mask.*M;

E = zeros(size(M,1));
% definindo trhesholds para tracos fracos e fortes
T_Low = 0.075;
T_High = 0.175;

T_Low = T_Low * max(max(mask));
T_High = T_High * max(max(mask));

for i = 1  : row
    for j = 1 : col
        if (mask(i, j) < T_Low)
            E(i, j) = 0;
        elseif (mask(i, j) > T_High)
            E(i, j) = 1;
        %Using 8-connected components
        elseif ( mask(i+1,j)>T_High || mask(i-1,j)>T_High || mask(i,j+1)>T_High || mask(i,j-1)>T_High || mask(i-1, j-1)>T_High || mask(i-1, j+1)>T_High || mask(i+1, j+1)>T_High || mask(i+1, j-1)>T_High)
            E(i,j) = 1;
        end;
    end;
end;

end
