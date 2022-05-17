clear; clc;
xx=[0 0 1; 0 1 1; 1 0 1; 1 1 1]; %인풋
bb=[0; 0; 1; 1]; %측정치
wk=2*rand(1,3)-1;

ww=(xx'*xx)\(xx'*bb);
[ncase,nd]=size(xx);
alp=0.1;
ep_num=10000;

for ep=1:ep_num
    for nc=1:ncase
        x1=xx(nc,:)';
        vv=wk*x1;
        yy=Sigmoid(vv);
        ee=bb(nc)-yy;
        del=yy*(1-yy)*ee;
        del_w=alp*del*x1';
        wk=wk+del_w;
    end
end