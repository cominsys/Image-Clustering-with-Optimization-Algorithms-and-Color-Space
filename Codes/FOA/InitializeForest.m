function Forest=InitializeForest(Eval, Ranges, dim, Iterations, area_limit, Life_time, Transfer_rate)
 
Forest.P.area_limit=area_limit;         % The limitation of the forest
 Forest.P.Life_time=Life_time;           % The maximum allowed age of a tree 
 Forest.P.Transfer_rate=Transfer_rate;   % The percentage of candidate population 
 Forest.P.Dimension=dim;                 % The dimension of the problem domain
 Forest.P.Llimit=Ranges(1,1);            % The lower limit of the variables
 Forest.P.Ulimit=Ranges(1,2);            % The upper limit of the variables
 Forest.P.MaxIterations=Iterations;      % Maximum number of iterations
 Forest.P.dx=(abs(Forest.P.Ulimit)/5);   % dx is a small value used in local seeding. This value is not used in binary problems and in discrete problem, this value should be rounded.
 if dim<5
     Forest.P.LSC=1; % Local seeding changes (1/5 of the dimension)
     Forest.P.GSC=1; % Global seeding changes
 else
     Forest.P.LSC=floor((2*Forest.P.Dimension)/10); % 20 percent (not optimal) of the dimension used in local seeding
     Forest.P.GSC=floor((1*Forest.P.Dimension)/10); % 10 percent (not optimal) of the dimension used in global seeding   
 end
 % Forming the Forest with randomly generated trees
 Temp_Forest_T = rand(Forest.P.area_limit,dim); 
 Forest.T(:,:)=Temp_Forest_T;
        % Random Particle Position
 EqualList = ceil(linspace(25,235,dim));
 RandList = round(7*randn(size(Forest.T,1),dim));
 for i = 1:size(Forest.T,1)
     Forest.T(i,1:Forest.P.Dimension) = EqualList + RandList(i,:);
     Forest.T(i,Forest.P.Dimension+1) = (Eval(Forest.T(i,1:Forest.P.Dimension)'));
     Forest.T(i,Forest.P.Dimension+2) = 0;
 end
 
end
