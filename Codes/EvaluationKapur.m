function [tt] = EvaluationKapur(X)
global H;


[dim,y] = size(X);

tt = zeros (1,y);

for j = 1:y
    flag = 0;
    
    HH= zeros(1,dim+1);
    T = zeros(1,dim+2);
    T(1) = 1;
    T(dim+2) = 256;
    
    for  i = 1: dim
        T(i + 1) = X(i,j);
    end
    
    for  i = 1: dim + 1
        if ((T(i) > T(i + 1)) || (T(i)<0) ||( T(i+1)>256))
            flag = 1;
            break
        end
        HH(i) = Ex(T(i), T(i + 1) - 1, H);
    end
    if flag==0
        tt(j) = sum(HH);
    else
        tt(j) =  0;
        flag = 0;
    end
    
end
end


function [E] = Ex(L1,L2,H)
 
w= 0;
E = 0;

for i = L1:L2    
    w = w + H(i);
end

for i = L1:L2    
   if (H(i) > 0 && w > 0)
       E = E - (H(i) / w) *log(H(i) / w);           
   end
end
ddd=E;
end


