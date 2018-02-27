clc;
clear all;
close all;

img = imread('examples/M1.jpg');
figure(1);
imshow(img)
%img=imresize(img,[400 NaN]);

im_gray = rgb2gray(img); 
img_gray_int = im_gray;
figure(2); 
imshow(im_gray)
im_gray = double(im_gray);

%Sobel Filter
BW = edge(im_gray,'Sobel');
figure(3);
imshow(BW);


se = strel('rectangle',[2,8]);

closeBW = imclose(BW,se);
figure(4);
imshow(closeBW);
 
fI = imfill(closeBW,'holes');
%figure(4);
%imshow(fI);
 
%open image
fO = imopen(fI,se);
fO = imclearborder(fO,8);

ft=imclose(fO,se);

i2 = imdilate(fO,se);
%figure(5);
%imshow(i2);

msk=[0 0 0 0 0;
    0 1 1 1 0;
    0 1 1 1 0;
    0 1 1 1 0;
    0 0 0 0 0;];

B=conv2(double(i2),double(msk));
 
%% Calculo das regioes %%
L =bwlabel(B,8); %conecta os pontos 
figure(400000);
imshow(L);
d2 = imfill(L, 'holes');
figure(6); imshow(d2);

[Etiquetas, N]=bwlabel(d2);



%% Identificacao da zona da matricula 

stats=regionprops(Etiquetas,'all');

for i=1:size(stats,1)
    Razao1(i)= (stats(i).MajorAxisLength/stats(i).MinorAxisLength);
end

indiceLogoHigh1=find((Razao1>=4.1) & (Razao1<=4.9));

areaMaxima=0;
for i=1:size(indiceLogoHigh1,2)
   if( areaMaxima<=(stats(indiceLogoHigh1(i)).Area))
       areaMaxima =(stats(indiceLogoHigh1(i)).Area);
   end

end

indiceLogoHigh=find([stats.Area]==areaMaxima);

for i=1:size(indiceLogoHigh,1)
    rectangle('Position',stats(indiceLogoHigh(i)).BoundingBox ,'EdgeColor','r','LineWidth',3);
    E = stats(indiceLogoHigh(i)).BoundingBox;
end
%% Mostrar resultado 

X=E.*[1 0 0 0]; X=max(X); %Determina o X canto superior Esquerdo da Placa
Y=E.*[0 1 0 0]; Y=max(Y); %Determina o Y canto superior Direito da Placa
W=E.*[0 0 1 0]; W=max(W); %Determina a Largura da Placa
H=E.*[0 0 0 1]; H=max(H); %Determina a Altura da Placa
Corte=[X Y (W-2) (H-7)]; %Determina coordenadas de corte
IMF=imcrop(img_gray_int,Corte);
I1 = img_gray_int(:,:,1);
[M,N] = size(IMF);
figure(7);
imshow(IMF)

Matricula = im2bw(IMF);
figure; imagesc(Matricula);colormap gray; axis equal;

%% Recorte de matricula

s1=strel('rectangle',[3,8]);
closeBW1=imclose(Matricula, s1);
%figure(8);
%imshow(closeBW1);

fI1=imfill(closeBW1, 'holes');
%figure(9);
%imshow(fI1);

fO1=imopen(fI1,s1);
%figure(10);
%imshow(fO1);

i21 = imdilate(fO1,s1);
%figure(11);
%imshow(i21);

msk=[0 0 0 0 0;
     0 1 1 1 0;
     0 1 1 1 0;
     0 1 1 1 0;
     0 0 0 0 0;];

B1=conv2(double(i21),double(msk));

%% Calculo das regioes 
L1 =bwlabel(B1,8);
%figure; imshow(L);

d21 = imfill(L1, 'holes');

[Etiquetas1, N1]=bwlabel(d21);

MAP1 = [0 0 0; jet(N1)];
I1 = ind2rgb(Etiquetas1+1,MAP1);

stats1=regionprops(Etiquetas1,'all');
areaMaxima1=sort([stats1.Area],'descend');
indiceLogoLow=find([stats1.Area]==areaMaxima1(1) ); 

for i=1:size(indiceLogoLow,2)
rectangle('Position',stats1(indiceLogoLow(i)).BoundingBox,'EdgeColor','r','LineWidth',3);
E1 = stats1(indiceLogoLow(i)).BoundingBox;
end 

%% Mostrar resultado 

X=E1.*[1 0 0 0]; X=max(X); %Determina o X canto superior Esquerdo da Placa
Y=E1.*[0 1 0 0]; Y=max(Y); %Determina o Y canto superior Direito da Placa
W=E1.*[0 0 1 0]; W=max(W); %Determina a Largura da Placa
H=E1.*[0 0 0 1]; H=max(H); %Determina a Altura da Placa
Corte=[X Y (W-9) (H-3)]; %Determina coordenadas de corte

IMF1=imcrop(Matricula,Corte);
I1 = Matricula(:,:,1);
[M1,N1] = size(IMF1);

IMF2= double(IMF1);
matriculaf = im2bw(IMF2);

imagesc(matriculaf);colormap gray; axis equal;

[R C]=size(matriculaf);
cropsize1=[(R*0.55) (C*0.025) (C*0.8) (R*0.79)];
Ic1=imcrop(matriculaf, cropsize1);
figure(12);
imshow(Ic1);

Ic2=~Ic1;
figure(13);
imshow(Ic2);

figure(14);
imshow(Ic2);

Ic9= bwareaopen(Ic2,50);

Ic9=imresize(Ic9,[400 NaN]);


figure(15);
imshow(Ic9);

vp4=sum(Ic9,1);
figure (16)
plot(vp4);

%% reconhecimeto dos carateres
figure(17);
imshow(Ic9);
Iprops=regionprops(Ic9,'BoundingBox','Image');

hold on
for n=1:size(Iprops,1) 
    rectangle('Position',Iprops(n).BoundingBox,'EdgeColor','b','LineWidth',3); 
end
hold off
%%

[l] = size(Iprops,1)

if ~isempty(l)
I={Iprops.Image};
numcar=[]; 
for v=1:size(Iprops,1)
   N=I{v}; 
   figure; imshow(N);
   letter=readLetter(N);
   
    while letter=='O' || letter=='0' 
           if v<=3                     
               letter='O';             
            else                         
                letter='0';             
            end                          
            break;                      
       end
   numcar=[numcar letter] 
end

else
  fprintf('Erro: Reconhecimento de Matricula falhado\n');
  fprintf('Caracter nao encontrado\n');
end
%%