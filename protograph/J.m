function [j]=J(theta)
% JFunction is an approximated function for PEXIT curves of AWGN
% channel model, it takes alpha vector and returns a corresponding
% JFunction vector.
% Values are arbitary that fullfill required function
[m,n]=size(theta);
j=zeros(m,n);
theta_a=1.6363;
aj1=-0.0421061;
bj1=0.209252;
cj1=-0.00640081;
aj2=0.00181491;
bj2=-0.142675;
cj2=-0.0822054;
dj2=0.0549608;
for p=1:m
    for q=1:n
        if 0<=theta(p,q)&&theta(p,q)<theta_a
            j(p,q)=aj1*theta(p,q)^3+bj1*theta(p,q)^2+cj1*theta(p,q);
        else
            if theta_a<theta(p,q)&&theta(p,q)<10
                j(p,q)=1-exp(aj2*theta(p,q)^3+bj2*theta(p,q)^2+cj2*theta(p,q)+dj2);
            else
                j(p,q)=1;
            end
        end
    end
end
end