function [ y ] = template( x )
y=x;
aa(1:42,1:24)=1;
aa(1:42,1)=0;
aa(1:42,24)=0;
aa(1,1:24)=0;
aa(42,1:24)=0;
imwrite(aa,'images/pen.bmp','bmp');
A=imread('images/A.bmp');
B=imread('images/B.bmp');
C=imread('images/C.bmp');
D=imread('images/D.bmp');
E=imread('images/E.bmp');
F=imread('images/F.bmp');
G=imread('images/G.bmp');
H=imread('images/H.bmp');
I=imread('images/I.bmp');
J=imread('images/J.bmp');
K=imread('images/K.bmp');
L=imread('images/L.bmp');
M=imread('images/M.bmp');
N=imread('images/N.bmp');
O=imread('images/O.bmp');
P=imread('images/P.bmp');
Q=imread('images/Q.bmp');
R=imread('images/R.bmp');
S=imread('images/S.bmp');
T=imread('images/T.bmp');
U=imread('images/U.bmp');
V=imread('images/V.bmp');
W=imread('images/W.bmp');
X=imread('images/X.bmp');
Y=imread('images/Y.bmp');
Z=imread('images/Z.bmp');
Afill=imread('images/fillA.bmp');
Bfill=imread('images/fillB.bmp');
Dfill=imread('images/fillD.bmp');
Ofill=imread('images/fillO.bmp');
Pfill=imread('images/fillP.bmp');
Qfill=imread('images/fillQ.bmp');
Rfill=imread('images/fillR.bmp');




%Numeros

one=imread('1.bmp');  
two=imread('2.bmp');
three=imread('3.bmp');
four=imread('4.bmp');
five=imread('5.bmp');
six=imread('6.bmp');
seven=imread('7.bmp');
eight=imread('8.bmp');
nine=imread('9.bmp');
zero=imread('0.bmp');
zerofill=imread('fill0.bmp');
fourfill=imread('fill4.bmp');
sixfill=imread('fill6.bmp');
sixfill2=imread('fill6_2.bmp');
eightfill=imread('fill8.bmp');
ninefill=imread('fill9.bmp');
ninefill2=imread('fill9_2.bmp');
a1=imread('pen.bmp');




%*-*-*-*-*-*-*-*-*-*-*-
letter=[A Afill B Bfill C D Dfill E F G H I J K L M ...
    N O Ofill P Pfill Q Qfill R Rfill S T U V W X Y Z ];
number=[];
character=[];

number=[one two three four fourfill five six sixfill sixfill2 seven ...
    eight eightfill nine ninefill ninefill2 zero zerofill a1];

character=[letter number];

NewTemplates=mat2cell(character,42,[24 24 24 24 24 24 24 24 ...
    24 24 24 24 24 24 24 ...
    24 24 24 24 24 24 24 ...
    24 24 24 24 24 24 24 ...
    24 24 24 24 24 24 24 ...
    24 24 24 24 24 24 24 ...
    24 24 24 24 24 24 24 24]);






save ('NewTemplates','NewTemplates')


end

