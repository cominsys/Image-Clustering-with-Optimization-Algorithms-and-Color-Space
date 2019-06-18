function [F,Q,F2,RGB] = PerformanceEval(Number_Of_Seg,Lable,List_Lable)
%PERFORMANCEEVAL Summary of this function goes here
%  by Taymaz Rahkar-Farshi
global I;
[U,V,Z] = size(I);
StdSeg = [];
AreaSeg = [];
R = int32(I(:,:,1));G = int32(I(:,:,2)); B = int32(I(:,:,3));
MeanR = []; MeanG = []; MeanB = [];
EuclidnDistR = []; EuclidnDistG = []; EuclidnDistB = [];
RA = [];
for i=1:Number_Of_Seg
    MeanR = [MeanR,  mean(R(Lable==List_Lable(i)))];
    MeanG = [MeanG,  mean(G(Lable==List_Lable(i)))];
    MeanB = [MeanB,  mean(B(Lable==List_Lable(i)))];
end
for i=1:Number_Of_Seg
    AreaSeg = [AreaSeg, numel(Lable(Lable==List_Lable(i)))];
    EuclidnDistR =  (R(Lable==List_Lable(i)) - (MeanR(i))).^2;
    EuclidnDistG =  (G(Lable==List_Lable(i)) - (MeanG(i))).^2;
    EuclidnDistB =  (B(Lable==List_Lable(i)) - (MeanB(i))).^2;
    EuclidnDist(i) = sum(sqrt(double(EuclidnDistR + EuclidnDistG + EuclidnDistB)))/ AreaSeg(i);
    R(Lable == List_Lable(i)) = MeanR(i);
    G(Lable == List_Lable(i)) = MeanG(i);
    B(Lable == List_Lable(i)) = MeanB(i);
    RA(i) = size(AreaSeg(AreaSeg==AreaSeg(i)),2);
end

F = (1/(U*V*1000)) * sqrt(Number_Of_Seg) * sum((EuclidnDist.^2)./sqrt(double(AreaSeg)));
Q = (1/(U*V*10000)) * sqrt(Number_Of_Seg) * sum((EuclidnDist.^2)./((1+log10(AreaSeg)))+ ((RA)./(AreaSeg)).^2);
temp = [];
for i = 1:Number_Of_Seg
    temp(i) = RA(i)^(1+(1/AreaSeg(i)));
end
F2 = (1/(U*V*10000)) * sqrt(sum(temp))*sum((EuclidnDist.^2)./sqrt(double(AreaSeg)));
RGB = I;
RGB(:,:,1) = R;
RGB(:,:,2) = G;
RGB(:,:,3) = B;
end

