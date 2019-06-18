function Forest = FOA(Forest, Eval, ShowResults)

bestTree=Forest.T(randi([1 size(Forest.T,1)]),:);
tic;
% stop condition is the predefined number of iterations
for i=1:Forest.P.MaxIterations
    Forest=LocalSeeding(Forest,Eval);
    [Forest,candidate]=PopulationLimiting(Forest);
    Forest=GlobalSeeding(candidate,Forest,Eval);
    [Forest,bestTree]=UpdateBestTree(Forest,bestTree); 
end
Forest.Elapsed=toc;
disp('Forest Optimization Algorithm completed.');
disp(['Elapsed time: ' num2str(Forest.Elapsed) ' seconds.']);
if ShowResults  
    disp(['The trees of the Forest after the ' num2str(Forest.P.MaxIterations) ' number of iterations are:']);
    disp('(The first tree indicates the best tree.');
    disp([' The ' num2str(Forest.P.Dimension+1) 'th column is the fitness of the related tree']);
    disp([' The ' num2str(Forest.P.Dimension+2) 'th column is the "Age" of the related tree)']);    
    for i=1:size(Forest.T(:,:),1)
        formatSpec = '%2.2e\t';
        disp(['(' num2str(i) '): ' num2str(Forest.T(i,:),formatSpec)]);
    end
end
save('..\FOA', 'Forest')
end %function


