clc;
clear all;
close all;

G1 = imread('zebra-e1.jpg');
DO = imread('zebraDog1.jpg');

figure;imshow(G1);
figure;imshow(DO);
% chamando a funcao
G0 = mat2gray(imexpand(double(G1),double(DO)));
% apresentando a imagem recuperada
figure;imshow(G0);


%%
% imexpand
% Input :
% G1 - upper level gaussian pyramid image
% D0 - Difference DoG pyramid image
% Output :
% G0 - down level gaussian image
%%
 
function [G0] = imexpand(G1, DO)

a = 0.375;
d = [((1/4) - (a/2))    (1/4)    a    (1/4)    ((1/4) - (a/2))];
p = d;

w = p;

dim = size(G1);
% expandindo para o próximo nível
newdim = dim*2;
G0 = zeros(newdim,class(G1)); 
m = [-2:2];

G1 = [ G1(1,:) ;  G1 ;  G1(dim(1),:) ];  
G1 = [ G1(:,1)    G1    G1(:,dim(2)) ]; 
% montando o kernel      
kernel = w'*w;
[row, col] = size(G0);
	for i = 0 : row - 1
		for j = 0 : col - 1
			pixeli = (i - m)/2 + 2;  idxi = find(floor(pixeli)==pixeli);
			pixelj = (j - m)/2 + 2;  idxj = find(floor(pixelj)==pixelj);
			A = G1(pixeli(idxi),pixelj(idxj)).* kernel(m(idxi)+3,m(idxj)+3);
			G0(i + 1, j + 1)= 4 * sum(A(:));
		end
    end
%   merge da imagem expandida com o resíduo
    G0 = G0 + DO;
end
