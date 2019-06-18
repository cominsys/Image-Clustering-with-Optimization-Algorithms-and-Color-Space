function [ Tresh] = main_FOA(I,dimension,Func,U,V)
% Setting the default values for the parameters
Iterations=200;    % Maximum number of iterations
ShowResults=0;      % when ShowResults=1, the trees are displayed; when ShowResults=0, the trees are not displayed;
area_limit=200;      % The limitation of the forest
Life_time=15;       % The maximum allowed Age of a tree
Transfer_rate=10;   % The percentage of candidate population for global seeding
%%
global H;
H = Thist(I);
switch Func
    case 1 % Kapur
        Eval = @EvaluationKapur;
        ranges = [1 255];
        %          H = H ./ (X*Y);
    case 2 % Otsu
        H = H ./ (U*V);
        Eval = @EvaluationOtsu;
        ranges = [1 255];
end

Forest=InitializeForest(Eval,ranges,dimension,Iterations, area_limit, Life_time, Transfer_rate);
Forest=FOA(Forest,Eval,ShowResults);
% Forest.T(1,1:dimension)

Tresh = Forest.T(1,1:dimension);
