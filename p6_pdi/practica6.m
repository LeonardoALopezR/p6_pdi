clear; clc;
%% Parte 4
figure
set(gcf, 'Name', 'Aplicacion de Correlacion', 'NumberTitle', 'Off');
%Lectura de imagenes
im1=imread('texto1.tif');
ima=imread('a.tif');
im2=imread('texto2.tif');
imday=imread('day.tif');

% Correlaci?n de las imagenes
corrImg1=xcorr2(im1,ima);
subplot(2,2,1),imshow(corrImg1,[]),title('Imagen texto "1" y "a" correlacionadas');

%Obtenemos el valor maximo de la correlacion y lo buscamos dentro de la
%misma correlacion para encontrar la imagen que se esta buscando
max1=max(max(corrImg1));
unos1 = ismember(corrImg1,max1);
total1=sum(sum(unos1));
matriz1 = unos1 .* 255;
%al final se hace una convolucion para poner la imagen en los puntos de
%maxima correlacion
imC=conv2(ima,matriz1);
subplot(2,2,2),imshow(imC,[]),title('Localizacion de la letra');

% Correlaci?n de las imagenes
corrImg2=xcorr2(im2,imday);
subplot(2,2,3),imshow(corrImg2,[]),title('Imagen texto "2" y "day" correlacionadas');

%obtenemos los valores maximos de la correlacion y para una mejor ubicacion
%utilizamos los ultimos 3 valores
max2=max(corrImg2);
max2= sort(max2);
[maxX,maxY]=size(max2);
unos2 = ismember(corrImg2,max2(maxY));
unos3 = ismember(corrImg2,max2(maxY-1));
unos4 = ismember(corrImg2,max2(maxY-2));
 
matriz2 = unos2 .* 255;
matriz3 = unos3 .* 255;
matriz4 = unos4 .* 255;

%al final se suman los valores para obtener la matriz con la localizacion
matriztotal= matriz2+matriz3+matriz4;
imC2=conv2(imday,matriztotal);
subplot(2,2,4),imshow(imC2,[]),title('Localizacion de la palabra');

%Lo que hace es "colocar" un punto donde la correlaci?n tiene mayor valor. 
%Las dificultades del OCR m?s notorias son: la cantidad de procesamiento 
%que puede necesitar la m?quina para realizar el c?lculo, y que es muy 
%f?cil de que exista correlaci?n en patrones similares (una C con una A), 
%lo que provoca que se puedan llegar a confundir algunos patrones.
