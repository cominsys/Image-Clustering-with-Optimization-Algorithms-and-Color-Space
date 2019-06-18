function Show(X,Eval,t)
global I;
H = Thist(I);
plot(0:255,H-1);
title(t);
xlabel('x1');
ylabel('fx');
hold on;
plot(X(:),H(X),'r+','MarkerSize', 8, 'LineWidth', 3);
axis([0,255,0,max(H)+100])
hold off
end

