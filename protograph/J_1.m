function [theta]=J_1(I)
% JInverseFunction is an approximated function for EXIT curves of
% BEC channel model, it takes mutual information vector and returns
% a corresponding JInverseFunction vector.
% Values are arbitary that fullfill inverse of Jfunction above
[m,n]=size(I);
theta=zeros(m,n);
I_a=0.3646;
at1=1.09542;
bt1=0.214217;
ct1=2.33727;
at2=0.706692;
bt2=0.386013;
ct2=-1.75017;
for i=1:m
    for j=1:n
        if 0<=I(i,j)&&I(i,j)<=I_a
            theta(i,j)=at1*I(i,j).^2+bt1*I(i,j)+ct1*sqrt(I(i,j));
        else
            if I(i,j)~=1
                theta(i,j)=-at2*log(bt2*(1-I(i,j)))-ct2*I(i,j);
            else
                theta(i,j)=1000;
            end
        end
    end
end