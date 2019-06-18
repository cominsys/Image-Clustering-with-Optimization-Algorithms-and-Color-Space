%  by Taymaz Rahkar-Farshi
%  Paper link: https://www.mdpi.com/1099-4300/20/4/296

clear,close all;clc
addpath('FOA');
global I; 

[FileName,PathName] = uigetfile('*.tif;*.bmp;*.png;*.jpg','Select file','D:\Academic\Projects\Image Processing\BSDS300\images\Select');
I = imread(strcat(PathName,FileName));
imshow(I);
I(:,:,1) = medfilt2(I(:,:,1));
I(:,:,2) = medfilt2(I(:,:,2));
I(:,:,3) = medfilt2(I(:,:,3));
I1=I;
Temp = I;
imshow(I);
[U,V,Z] = size(I);
Func = 2; % 1: Entropy  2: Otsu
Alg = 1;  % 1: PSO      2: FOA
dim = 3;
showIteration = 0;
NumofRun = 1;
if (dim == 1)
    total =  U*V;
    for i = 1: 3
        I1 =I(:,:,i);
        H = Thist(I1);
        switch Func
            case 1 % Kapur
                Tresh(i) = TEntropy(H,total);
                treshmethod = 'Kapur';
            case 2 % 6 Otsu
                Tresh(i) = TOtsu(H,total);
                treshmethod = 'Otsu';
        end
    end
    Tresh = Tresh';
    Acc(1).tresh = Tresh;
elseif (dim>1)
    if Func == 1
        treshmethod = 'Kapur';
    else
        treshmethod = 'Otsu';     
    end
    for jj=1:NumofRun 
        switch Alg
            case 1 % pso
                Tresh = PSO(I,dim,Func,U,V,Z,showIteration);
            case 2 % FOA
                Tresh = main_FOA(I1(:,:,1),dim,Func,U,V);
                Tresh = [Tresh;main_FOA(I1(:,:,2),dim,Func,U,V)];
                Tresh = [Tresh;main_FOA(I1(:,:,3),dim,Func,U,V)];
        end
        Acc(jj).tresh = Tresh;
    end 
end

[Non_Join,List_Lable,Number_Of_Seg,Lable,Segmented_Image] = Cube(U,V,Tresh);
%%
[F,Q,F2,RGB] = PerformanceEval(Number_Of_Seg,Lable,List_Lable);
disp(['F = ',sprintf('%.8f ', F)])
disp(['F" = ',sprintf('%.8f ', F2)])
disp(['Q = ',sprintf('%.8f ', Q)])
figure;
imshow(RGB);

% saveas(gcf,strcat(treshmethod,'-',num2str(dim),'.bmp'));

tresholds = zeros(3,dim);
for i=1:NumofRun
    tresholds = tresholds+ Acc(i).tresh;
end
tresholds = (tresholds/NumofRun)-1;
disp(strcat('Threshold Values R: ',num2str(tresholds(1,:))));
disp(strcat('Threshold Values G: ',num2str(tresholds(2,:))));
disp(strcat('Threshold Values B: ',num2str(tresholds(3,:))));
disp(strcat('Number of Cluster = ',num2str(Number_Of_Seg)));

% saveas(gcf,strcat(treshmethod,'-',num2str(dim),'.bmp'));


