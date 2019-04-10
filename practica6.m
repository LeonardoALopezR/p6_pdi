%% Práctica 6: Magnitud, Fase, Convolución y Correlación
% Elabora: Dante Bazaldua y Leonardo López

%% Parte 2: 
% --- Magnitud y fase
% Patron 9
clear; clc;
im1=imread('patron9.tif');
im1=rgb2gray(im1);

% FFT
im1T = fft2(im1);
im1T2= abs(im1T);
im1Tsh = fftshift(im1T2); % Colocar al centro el DC

figure;
set(gcf, 'Name', 'Patron 9', 'NumberTitle', 'Off');
subplot(2,2,1), imshow(im1, []), title('Imagen original');
subplot(2,2,2), imshow(log(im1Tsh +1),[]), title('Magnitud');
subplot(2,2,3), imshow(angle(im1T),[]), title('Fase');

% Patron 8
im1=imread('patron8.tif');

im1T = fft2(im1);
im1T2= abs(im1T);
im1Tsh = fftshift(im1T2);

figure;
set(gcf, 'Name', 'Patron 8', 'NumberTitle', 'Off');
subplot(2,2,1), imshow(im1), title('Imagen original');
subplot(2,2,2), imshow(log(im1Tsh +1),[]), title('Magnitud');
subplot(2,2,3), imshow(angle(im1T),[]), title('Fase');

% Patron 7
im1=imread('patron7.tif');

im1T = fft2(im1);
im1T2= abs(im1T);
im1Tsh = fftshift(im1T2);

figure;
set(gcf, 'Name', 'Patron 7', 'NumberTitle', 'Off');
subplot(2,2,1), imshow(im1), title('Imagen original');
subplot(2,2,2), imshow(log(im1Tsh +1),[]), title('Magnitud');
subplot(2,2,3), imshow(angle(im1T),[]), title('Fase');

pause;
% --- Importancia de la magnitud y la fase. 
disp('Importancia de la magnitud y la fase');

% Mujer
mujer = imread('mujer.tif');

% FFT
mujerfft = fft2(mujer);
mujer2 = abs(mujerfft);
mujer2sh = fftshift(mujer2);

figure;
set(gcf, 'Name', 'Mujer', 'NumberTitle', 'Off');
subplot(2,2,1), imshow(mujer), title('Imagen original');
subplot(2,2,2), imshow(log(mujer2sh +1),[]), title('Magnitud');
subplot(2,2,3), imshow(angle(mujerfft),[]), title('Fase');

% Rectangulo 
rectangulo=imread('rectangulo.tif');

rectangulo=imresize(rectangulo,0.5);
rectangulofft = fft2(rectangulo);
rectangulo2= abs(rectangulofft);
rectangulo2sh = fftshift(rectangulo2);

figure;
set(gcf, 'Name', 'Rectangulo', 'NumberTitle', 'Off');
subplot(2,2,1), imshow(rectangulo), title('Imagen original');
subplot(2,2,2), imshow(log(rectangulo2sh +1),[]), title('Magnitud');
subplot(2,2,3), imshow(angle(rectangulofft),[]), title('Fase');

% Fases
faserect=angle(rectangulofft);
fasemujer=angle(mujerfft);

figure; 
set(gcf, 'Name', 'Fases de Rectangulo y Mujer', 'NumberTitle', 'Off');
subplot(1,2,1), imshow(faserect,[]), title('Rectangulo');
subplot(1,2,2), imshow(fasemujer,[]), title('Mujer');

mr=(mujer2).*(exp(-1i*faserect));
rm=(rectangulo2).*(exp(-1i*fasemujer));

resultado = ifft2(mr);
resultado2 = ifft2(rm);

figure; 
set(gcf, 'Name', 'Transformadas inversas', 'NumberTitle', 'Off');
subplot(1,2,1), imshow(abs(resultado),[]), title('Mujer = |mujer|.*(exp(-1i*phrect))');
subplot(1,2,2), imshow(abs(resultado2),[]), title('Rectangulo = |rectangulo|.*(exp(-j*phmujer))');

%% Parte 3
clear; clc;

im1=double(imread('garabato.tif'));
im2=zeros(256,256);
im2(128,128)=255;  % Delta
imC=conv2(im1,im2);

% Generar la matriz para convolución a partir de una delta

im1E = zeros(256,256); 
im1E(1:64,1:64) = im1;
im1T = fft2(im1E);
im2T = fft2(im2); % Tener delta
im12T = im1T.*im2T; 
imAT=ifft2(im12T);

% Correlacion
im2c = zeros(256,256);
im2c(128,128) = 255; 
imCor1 = xcorr2(im1,im2c);

% Convolucion y correlacion
im22=zeros(256,256);
im22(128,128)=255;
im22(64,64)=255;
im22(64,192)=255;
im22(192,64)=255;
im22(192,192)=255;

imC2=conv2(im1,im22);
imCor=xcorr2(im1,im22);

figure;
set(gcf, 'Name', 'Garabatos', 'NumberTitle', 'Off');
subplot(5,2,1), imshow(im1), title('Imagen Original');
subplot(5,2,2), imshow(im2), title('Imagen con Delta Central');
subplot(5,2,3), imshow(imC), title('Convolucion');
subplot(5,2,4), imshow(abs(im1T),[]), title('Transformada original escalada')
subplot(5,2,5), imshow(log(abs(im2T) + 1),[]), title('Transformada Imagen Delta central')
subplot(5,2,6), imshow(log(abs(im12T) + 1),[]), title('Multiplicacion en frecuencia')
subplot(5,2,7), imshow(imAT), title('Antitransformada');
subplot(5,2,8), imshow(imCor1), title('Correlacion');
subplot(5,2,9), imshow(imC2), title('Convolucion');
subplot(5,2,10), imshow(imCor), title('Correlacion');

disp('Al utilizar la convolucion y correlacion nos damos cuenta de que los resultados son iguales. ')
disp('Al posicionar deltas en lugares específicos se logra replicar alguno de los dos componentes en el resultado final');
disp('Es decir 5 deltas, 5 garabatos');

%% Parte 4
clear; clc;
figure;
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

close all;
