%%This code is used to sample training images
clc
clear
close all
% Iorg=LoadGrid('ti_stonewall.sgems');
sampling_number=2000; %sampling ratio%first see percent of sampling first,      
I=imread('TI.jpg');
Iorg=im2double(I);                                          
sz=size(Iorg);
sz1=sz(1);
sz2=sz(2);
floor_sqrt_ns=floor(sqrt(sampling_number));
ceil_sqrt_ns=ceil(sqrt(sampling_number));
d1=floor(sz1/floor_sqrt_ns);
d2=floor(sz2/ceil_sqrt_ns);
Xg=[1:d1:sz1];
Yg=[1:d2:sz2];
[Xg,Yg]=meshgrid(Xg,Yg);
Xg=Xg(:);
Yg=Yg(:);
Xg=round(Xg+randn(size(Xg)));
Yg=round(Yg+randn(size(Yg)));%Yg=round(Yg+randn(size(Yg))*1.5);
Xg(Xg>sz1)=sz1;
Xg(Xg<1)=1;
Yg(Yg>sz2)=sz2;
Yg(Yg<1)=1;
ind=sub2ind(size(Iorg),Xg,Yg);%finde indices from cordinate x and y
Is=nan(size(Iorg));
Is(ind)=Iorg(ind);
ind2=find(~isnan(Is));
num_inputed_sample_first=size(ind2,1);
percent_of_sampling_first=(num_inputed_sample_first/(size(Iorg,1)*size(Iorg,2)))*100;
ind3=randperm(sz1*sz2);
ind4=setdiff(ind3,ind2);
ind5=randperm(size(ind4,2));
ind6(1:size(ind4,2))=ind4(ind5);
%#############################

% 2 percent sampling channel 630 sample
num_sample_must_be_add=630-num_inputed_sample_first;
ind7(1:num_sample_must_be_add)=ind6(1:num_sample_must_be_add);
Is(ind7)=Iorg(ind7);
num_inputed_sample_final=find(~isnan(Is));
percent_of_sampling_final=(size(num_inputed_sample_final,1)/(sz1*sz2))*100;
figure
imshow(Iorg)
title('original image')
figure
imshow(Is);
title('samled image')

