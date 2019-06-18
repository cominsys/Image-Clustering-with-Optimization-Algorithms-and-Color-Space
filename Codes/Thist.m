function [H] = Thist(img)
H=zeros(1,256);
[w,h] = size(img);
for i = 1:w
    for j = 1:h
        p = img(i,j);
        H(p+1) = H(p+1)+1;
    end
end
% figure;
% bar(0:255,H-1);
% axis([0,255,0,max(H)+100])
end

