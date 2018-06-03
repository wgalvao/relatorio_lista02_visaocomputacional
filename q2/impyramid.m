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

    p = d;
    w = p;
    % calcular os níveis da pirâmide dado o valor em L
    for z = 1:L
        
        dim = size(I);
        nextLevel = ceil(dim*0.5);
        P = zeros(nextLevel,class(I)); 
        m = (-2:2);
        n = m;

        I = [I(1,:); I(1,:); I; I(dim(1),:); I(dim(1),:)];  
        I = [I(:,1)  I(:,1) I I(:,dim(2)) I(:,dim(2))]; 

        Wt2 = w'*w;

        for i = 0 : nextLevel(1) -1
            for j = 0 : nextLevel(2) -1
                A = I(2*i+m+3,2*j+n+3).*Wt2;
                P(i + 1, j + 1) = sum(A(:));
            end
        end

        I = P;
        figure; imshow(I);
    
    end

end
