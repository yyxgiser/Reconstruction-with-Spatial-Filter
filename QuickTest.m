%This code is related to article "Reconstruction of Geological Images Based on an Adaptive Spatial
%Domain Filter: An Example to Introduce Quantum Computation to Geosciences"
%written by Sadegh Klanatri,Ali Madadi and Mehdi Ramezani.The use of this code is unimpeded by mentioning the source.Please read Readme file  before running.
clc
clear all
close all
tic
I=imread('TI.jpg');%TI Image
% I=imread('C:\Users\sadegh.k\Desktop\art\original image3.jpg');
I=im2double(I);
load stone16p%This is sampled Image 
Im=Is;
ind=find(~isnan(Im));
Im=rand(size(Is));
Im=imnoise(Im,'salt & pepper',1);
Im(ind)=Is(ind);
maxim=max(Im(:));
minim=min(Im(:));
nn=size(I);
tt=0;
for i=1:1:nn(1)
for j=1:1:nn(2)
if Im(i,j)==0 || Im(i,j)==1
tt=tt+1;
end
end
end
sigma=tt/numel(Im);
if sigma>.3010
[x,y]=size(I);
H=Im;
G=padarray(H,[20 20],'symmetric');
mina=zeros(1,20);
maxa=zeros(1,20);
meana=zeros(1,20);
meda=zeros(1,20);
for i=1:1:x
for j=1:1:y
if Im(i,j)==maxim || Im(i,j)==minim
k=2;
for kk=1:1:20
tem=G(i+20-kk:i+20-kk+k,j+20-kk:j+20-kk+k);
mina(kk)=min(tem(:));
maxa(kk)=max(tem(:));
vv=zeros(1+k);
for ii=1:1+k
for jj=1:1+k
if mina(kk)<tem(ii,jj)&tem(ii,jj)<maxa(kk)
vv(ii,jj)=1;
end
end
end
dd=tem.*vv;
if (sum(vv(:))~=0)
meana(kk)=(sum(dd(:)))/(sum(vv(:)));
az=zeros(1,sum(vv(:)));
ccc=1;
for iii=1:k+1
for jjj=1:k+1
if dd(iii,jjj)>0
az(1,ccc)=dd(iii,jjj);
ccc=ccc+1;
end
end
end
meda(kk)=median(az);   
else
meana(kk)=-1;
end
if kk>1
if (mina(kk)==mina(kk-1))&(maxa(kk)==maxa(kk-1))&meana(kk-1)~=-1
if ((mina(kk-1)<Im(i,j))&(Im(i,j)<maxa(kk-1)))
H(i,j)=Im(i,j);
else
H(i,j)=(meana(kk-1)+meda(kk-1))/2;
break;
end
end
end
k=k+2;
end
else
 H(i,j)=Im(i,j);
end                                  
end
end
end
subplot(1,4,1)       
imshow(I);title('original image')
subplot(1,4,2)
imshow(H);title('Reconstruction by our method')
subplot(1,4,3)
mdf=medfilt2(Im);
imshow(mdf);title('Reconstruction by median filter')
subplot(1,4,4)
imshow(Is);title('sampled Image')
cc=abs(im2double(H)-im2double(I));
dd=sum(sum(cc));
performance=100-100*(dd/(size(I,1)*size(I,2)))
imwrite(H,'D:/out.png')

        