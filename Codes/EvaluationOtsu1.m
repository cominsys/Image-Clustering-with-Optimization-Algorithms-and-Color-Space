function [tt] = EvaluationOtsu(X)
global H;
[x,y] = size(X);
tt = zeros (1,y);
Mu = zeros (1,x+1);
W = zeros (1,x+1);
MuAll = zeros (1,y);
e=0;
acc=0;
for i = 1:256
    acc = acc + (i * H(i));
end
for k = 1: y
    ii = ((1:X(1,k)));
    Pi = [];
    Pi = H(ii);
%     Pi(Pi==0)=1;
    W(1) = sum(Pi);
    Mu(1) = sum((ii .* Pi)/W(1));
    for i = 1 : x -1
        if (X(i,k) >= X(i+1,k) || X(i,k) < 1 || X(i+1,k) < 1 || X(i,k) > 256 || X(i+1,k) > 256)
            e = 1;
            break
        end
        ii = (X(i,k):X(i+1,k));
        Pi = [];
        Pi = H(ii);
%         Pi(Pi==0)=1;
        W(i+1) = sum(Pi);
        Mu(i+1) = sum((ii .* Pi)/W(i+1));
    end
    if e == 0
        ii = (X(i+1,k):256);
        Pi = [];
        Pi = H(ii);
%         Pi(Pi==0)=1;
        W(end) = sum(Pi);
        Mu(end) = sum((ii .* Pi)/W(end));
        MuAll(k) = sum(Mu);
        %         try
        %  tt(k) = sum(W .* ((Mu - MuAll(k)).^2));
        tt(k) = sum(W .* ((Mu - acc).^2));
        %         catch
%             a=1;
%         end
    else
%         Mu(k) = 0;
        tt(k);
        e = 0;
    end

end
end
