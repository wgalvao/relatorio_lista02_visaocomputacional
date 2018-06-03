%%
% imreduce
% Input :
% G0 - input image
% p - filter
% d - filter
% Output :
% G1 - upper level pyramid image
%%

function [G1] = imreduce(I, p, d)
    % filtro de kernel
    p = d;
    w = p;    

    dim = size(I);
    % calculando o pŕoximo nível da piramide
    nextLevel = ceil(dim*0.5);
    G1 = zeros(nextLevel,class(I));
    
    m = (-2:2);
    n = m;
    
    [row, col] = size(G1);

    I = [I(1,:); I(1,:); I; I(dim(1),:); I(dim(1),:)]; 
    I = [I(:,1)  I(:,1) I I(:,dim(2)) I(:,dim(2))]; 
    
    % kernel 5*5
    Wt2 = w'*w;
    % convolvendo o filtro com a imagem
    % de acordo com a fórmula dada no artigo
    for i = 0 : row-1
        for j = 0 : col-1
            A = I(2*i+m+3,2*j+n+3).*Wt2;
            G1(i + 1, j + 1) = sum(A(:));
        end
    end            
end