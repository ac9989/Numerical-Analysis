clear; clc;
xx=[0 0 1; 0 1 1; 1 0 1; 1 1 1]; %인풋
bb=[0; 0; 1; 1]; %측정치
wk=2*rand(1,3)-1;

ww=(xx'*xx)\(xx'*bb);
[ncase,nd]=size(xx);
alp=0.1;
ep_num=5000;
bts=2;
nbt=ncase/bts;

for ep=1:ep_num
    for it=1:nbt
        del_w=zeros(1,3);
        for nc=1:bts
            x1=xx((it-1)*bts+nc,:)';
            vv=wk*x1;
            yy=Sigmoid(vv);
            ee=bb((it-1)*bts+nc)-yy;
            del=yy.*(1-yy).*ee;
            del_w=del_w.*alp.*del.*x1';
        end
        wk=wk+del_w;
    end
end

for nc=1:ncase
    x1=xx(nc,:)';
    vv=wk*x1;
    yy=Sigmoid(vv);
    ee=bb(nc)-yy;
    sprintf('nc=%d, ee=%5.2f', nc, ee)
end
