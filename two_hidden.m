clear; clc;

% xx=[0 0 1; 0 1 1; 1 0 1; 1 1 1 ];
% [ncase,n_node]=size(xx);
% bb=[0; 1; 1; 0];

inputNames = {'CRIM','ZN','INDUS','CHAS','NOX','RM','AGE','DIS','RAD','TAX','PTRATIO','B','LSTAT'};
outputNames = {'MEDV'};
hs_dat=double(load('housing.txt'));


housingAttributes = [inputNames,outputNames];
xxx=hs_dat(1:400,1:13);
bbb=hs_dat(1:400,14);



cor_map=zeros(13,1);
for ic=1:13
    tmp=corr(squeeze(xxx(:,ic)),bbb(:));
    cor_map(ic)=tmp;
end

[ismv]=find(abs(cor_map)>0.2);


xx=xxx(:,ismv);
bb=bbb;
[ncase,n_node]=size(xx);
for ic=1:ncase
    tmp=xxx(ic,ismv);
    xx(ic,:)=(tmp-mean(tmp))./std(tmp);
    bb(ic)=bbb(ic);
end

    
%% least square sol
ww=xxx'*xxx\xxx'*bbb;

%%
niter=20000;
nn=4;
wk1=2*(rand(n_node*nn,n_node)-1/2);
wk2=2*(rand(1,n_node*nn)-1/2);
ak=0.2;
err2=zeros(niter,1);
bt_sz=20;
for epch=1:niter
    ep=0;
    for iz=1:ncase/bt_sz
        sam=randperm(ncase,bt_sz);
        sx=xx(sam,:);
        sb=bb(sam);
        dw1=zeros(n_node*nn,n_node);
        dw2=zeros(1,n_node*nn);
        for in=1:bt_sz
            x1=sx(in,:)';
            v1=wk1*x1;
            y1=Sigmoid(v1);
            v2=wk2*y1;
                    %y2=Sigmoid(v2);
            y2=v2;
            e2=sb(in)-y2; % forward
            del2=e2;%y2.*(1-y2).*e2;
            e1=wk2'*del2;
            del1=y1.*(1-y1).*e1;    
            dw2=dw2+ak*del2*y1';
            dw1=dw1+ak*del1*x1';        
            ep=ep+e2^2;
        end
        dw1=(dw1-mean(mean(dw1)))./std(dw1);
        wk1=wk1+dw1/bt_sz;
        wk2=wk2+dw2/bt_sz';
    end    
    err2(epch)=sqrt(ep);
    ak=0.1+(1-0.1)/(1+exp((2*epch-1)/5));
    if sqrt(ep)<55
        sprintf('epoch num=%d, ep=%5.2f',epch,sqrt(ep))
        break
    end
end
figure; plot(err2(1:epch))

% for in=1:ncase
%     x1=xx(in,:)';
%     v1=wk1*x1;
%     y1=Sigmoid(v1);
%     v2=wk2*y1;
%     y2=v2;%Sigmoid(v2);
%     e2=bb(in)-y2; % forward
%     sprintf('in=%d,  err=%5.2f, bb=%5.2f, y2=%5.2f', in, e2,bb(in), y2)
% end

%% predict using Aw=b
paa=hs_dat(401:500,1:13);
pbb=hs_dat(401:500,14);

est_pr=paa*ww;


%% predict using two layer
pa=paa(:,ismv);
est_pr2=zeros(100,1);
for ic=1:100
    tmp=paa(ic,ismv);%./pbb(ic);
    pa(ic,:)=(tmp-mean(tmp))./std(tmp);
end
for in=1:100
    x1=pa(in,:)';
    v1=wk1*x1;
    y1=Sigmoid(v1);
    v2=wk2*y1;
    est_pr2(in)=v2;%Sigmoid(v2);
end


figure; 
subplot(121);plot(pbb); hold on; plot(est_pr,'r');ylim([-10,35]);title('least square sol')
subplot(122); plot(pbb); hold on;  plot(est_pr2,'r');ylim([-10,35]);title('two hidden sol')







