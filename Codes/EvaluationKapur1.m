function [hh] = EvaluationKapur(X)
global H;
[x,y] = size(X);
W = zeros (x+1,1);
P =  [];
h = zeros (1,x+1);
hh = [];
e=0;
%%
for k = 1: y
    W = sum(H(1:X(1,k)));
    p = H(1:X(1,k))/W;
    h(1) =  - sum( p .* log(p));
    for i = 1 : x -1
        if (X(i,k) >= X(i+1,k) || X(i,k) < 1 || X(i+1,k) < 1 || X(i,k) > 256 || X(i+1,k) > 256)
            e = 1;
            break
        end
        W = sum(H(X(i,k):X(i+1,k)));
        p = H(X(i,k):X(i+1,k))/W;
        h(i+1) = - sum( p .* log2(p));
    end
    if e == 0
        W = sum(H(X(i+1,k):256));
        p = H(X(i+1,k):256)/W;
        p(p==0)=1;
        h(end) =  - sum( p .* log2(p));
        hh(k) = sum(h);
    else
        hh(k) = 0;
        e = 0;
    end
end
end