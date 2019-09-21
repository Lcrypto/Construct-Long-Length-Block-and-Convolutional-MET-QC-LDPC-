
function [a]=pexit(B,ENdb,R,pun,iter,level)
% function [a]=pexit(B,EN,R)
[m,n]=size(B);
L=iter;
EN=10^(ENdb/10);
cch2=8*R*EN*ones(1,n);
cch2(pun)=0;
IEv=zeros(m,n);
IEc=zeros(m,n);
IEc(:,pun)=1;
%L=1000;%number of iterations
Iapp=zeros(1,n);
Iapp(pun)=1;
store_Iapp=zeros(1,n);
a=false;
for k=1:L
    for j=1:n;
        temp=J_1(IEc(:,j)).^2;
        for i=1:m
            if B(i,j)==0
                IEv(i,j)=0;
                continue;
            else
                IEv(i,j)=J(sqrt(B(:,j)'*temp-temp(i)+cch2(j)));
            end
        end
    end
    for i=1:m
        temp=J_1(1-IEv(i,:))'.^2;
        for j=1:n
            if B(i,j)==0
                IEc(i,j)=0;
                continue;
            else
                IEc(i,j)=1-J(sqrt(B(i,:)*temp-temp(j)));
            end
        end
    end
    Iapp=J(sqrt(sum(B.*(J_1(IEc).^2))+cch2));
     Iapp(pun)=1;
    if all(Iapp>=1-(level))%&&all(Iapp<=1+level)
        a=true;
        return;
    else
        eIapp=store_Iapp-Iapp;
        if all((eIapp)<level)&&all((eIapp)>-(level))
            a=false;
            return
        else
            store_Iapp=Iapp;
        end
    end
     
end