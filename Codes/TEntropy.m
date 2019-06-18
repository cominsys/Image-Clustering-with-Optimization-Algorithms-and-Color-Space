function [T] = TEntropy( H,total )
W0 = 0;
W1 = 0;
H0 = 0;
H1 = 0;
Max = 0;
T = 0;
for i = 1:256
    W0 = sum(H(1:i));
    W1 = total - W0;
    pi = H(1:i)/W0;
    pj = H(i+1:256)/W1;
    pi(pi==0)=1;
    pj(pj==0)=1;
    H0 =  - sum( pi .* log(pi) );
    H1 =  - sum( pj .* log(pj) );
    J = H0 + H1;
    if ( J >= Max )
        T = i;
        Max = J;
    end
end
end