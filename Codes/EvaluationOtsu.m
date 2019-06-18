function [tt] = EvaluationOtsu(X)
global H;

[dim,y] = size(X);
tt = zeros (1,y);

for j = 1:y
    flag = 0;
    T = zeros(1,dim+2);
    zigma = zeros(1,dim+1);
    T(1) = 1;
    T(dim + 2) = 250;
    
    for  i = 1: dim
        T(i + 1) = X(i,j);
    end
    
    
    for  i = 1: dim + 1
        if ((T(i) > T(i + 1)) || (T(i)<0) ||( T(i+1)>256))
            flag = 1;
            break
        end
        zigma(i) = Zigx(T(i), T(i + 1) - 1, H);
    end
    if flag==0
        tt(j) = sum(zigma);
    else
        tt(j) =  0;
        flag = 0;
    end
end
end

function [tt] = Zigx(L1,L2,H)

w= 0;
zig = 0;
m = 0;
mT = 0;

for i = 1: 256
    mT = mT + i * H(i);
end

for i = L1:L2    
    w = w + H(i);
    m = m + i * H(i);
end
if (w > 0) m = m / w;
    zig = w * (m - mT) * (m - mT);
end
tt = zig;
end
