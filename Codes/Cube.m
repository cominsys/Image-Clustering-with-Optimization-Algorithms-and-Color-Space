function [ Non_Join,List_Lable,Number_Of_Seg,Lable,Y] = Cube(U,V,Tresh)

global I;
Y = I*0;

r = [0,Tresh(1,:),255];
g = [0,Tresh(2,:),255];
b = [0,Tresh(3,:),255];

R = max(size(r));
G = max(size(g));
B = max(size(b));

Lable = zeros(U,V);
List = zeros((R-1),(G-1),(B-1));

n=0;
for i = 1:R-1
    for j = 1:G-1
        for k = 1:B-1
            n=n+1;
            List(i,j,k) = n;
        end
    end
end

for u = 1:U
    for v= 1:V
        for i = 2:R
            for j = 2:G
                for k = 2:B
                    if((I(u,v,1) <= r(i)) && (I(u,v,1) >= r(i-1)) && ...
                            (I(u,v,2) <= g(j)) && (I(u,v,2) >= g(j-1)) && ...
                            (I(u,v,3) <= b(k)) && (I(u,v,3) >= b(k-1)))
                        %                         Y(u,v,1) = mean(r(i),r(i-1));
                        %                         Y(u,v,2) = mean(g(j),g(j-1));
                        %                         Y(u,v,3) = mean(b(k),b(k-1));
                        
                        Y(u,v,1) = r(i-1);
                        Y(u,v,2) = g(j-1);
                        Y(u,v,3) = b(k-1);
                        Lable(u,v) = List(i-1,j-1,k-1);
                    end
                end
            end
        end
    end
end
imwrite( Y, num2str(length(Tresh(1,:))), 'jpg' );

Non_Join = length((Lable(Lable==0))); % number of pixel that are not join to any segment
List_Lable = unique(Lable)' ;       %Lables
Number_Of_Seg = max(size(unique(Lable)));  % Number Of segments
% Coloring(List_Lable,Lable);

%%
% close all

% for p= 1:Number_Of_Seg
%     Lable1=Lable;
%     pp=List_Lable(p);
%     Lable1(Lable~=pp)=255;
%     figure;
%     imagesc(Lable1)
% end
%%
end

