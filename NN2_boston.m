clear; clc;
% url='http://archive.ics.uci.edu/ml/machine-learning-databases/housing/housing.data';
% urlwrite(url,'housing.txt');
inputNames = {'CRIM','ZN','INDUS','CHAS','NOX','RM','AGE','DIS','RAD','TAX','PTRATIO','B','LSTAT'};
outputNames = {'MEDV'};
hs_dat=double(load('housing.data'));

housingAttributes = [inputNames,outputNames];
aa=hs_dat(1:400,1:13);
bb=hs_dat(1:400,14);

ww=(aa'*aa)\(aa'*bb);
[ncase,nd]=size(xx);
alp=0.1;
ep_num=400;
bts=10;
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