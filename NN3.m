%두개의 레이어
clear; clc;
xx=[0 0 1; 0 1 1; 1 0 1; 1 1 1]; %인풋
bb=[0; 0; 1; 1]; %측정치
wk=2*rand(1,3)-1;
niter=500;
ww=(xx'*xx)\(xx'*bb);
[ncase,nd]=size(xx);
ak=0.1;

nod1=5; nod2=1;
wtt1=2*rand(nod1,nd)-1;   %가중치 행렬 1
wtt2=2*rand(nod2,nod1)-1; %가중치 행렬 2

inode=1;
x1=xx(inode,:)';
v1=wtt1*x1;

y1=Sigmoid(v1);
v2=wtt2*y1;
y2=Sigmoid(v2);

    
