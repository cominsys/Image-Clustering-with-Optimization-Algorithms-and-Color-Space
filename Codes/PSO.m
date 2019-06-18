function [ Tresh] = PSO(I,dim,Func,U,V,Z,sh)
%  by Taymaz Rahkar-Farshi

Temp = I;
Tresh =[];

for jj = 1: Z
    if (sh)
        figure;
    end
%    tic 
    N = 240;              % Size of the swarm " Number of particle "
    i_max = 100;         % Iteration Value "particle steps"
    theta = 0.98;        % pso momentum or inertia
    R1 = rand(dim,N);     % PSO parameter R1
    R2 = rand(dim,N);     % PSO parameter R2
    c1 = 1.87;          % PSO parameter C1
    c2 = 1.87;          % PSO parameter C2
    %%
    global H;    
    I = Temp;
    I = I(:,:,jj);
    H = Thist(I);    
    i=1;
    while H(i) == 0
        i=i+1;
    end
    Min_H = i;
    i=255;
    while H(i) == 0
        i=i-1;
    end
    Max_H = i;
    
    switch Func
        case 1 % Kapur
            Eval = @EvaluationKapur;
            XMinMax = [1 256];
        case 2 % 6 Otsu
            Eval = @EvaluationOtsu;
            XMinMax = [1 256];
            H = H ./ (U*V);
    end
    %% Initializing
    
    EvalValue = ones(1,N); % Fittnes value for all particle is one
    X=rand(dim, N);        % Random Particle Position
    EqualList = ceil(linspace(Min_H +45,Max_H-45 ,dim))';
    RandList = round(7*randn(dim,N));
    for i = 1:N
        X(:,i) = EqualList + RandList(:,i);
    end
    
    P_best_pos = X;   %Best Particle Posation
    EvalValue = Eval(X);  %Calculate fitness function(i)
    V_old = 0.3*randn(dim,N); %initialing Velocity
    P_best = EvalValue;                        % initial (local best fitness)
    [G_best,indx] = max(P_best);                 % find position of best fitness in all particle
    G_best_pos = P_best_pos(:,indx);           % all of G_best_pos column =position of best fitness
    for i=1:N
        V_new(:,i) = theta * V_old(:,i) + c1*R1(:,i) .* (P_best_pos(:,i) - X(:,i))+c2*R2(:,i) .* (G_best_pos - X(:,i)); %Calculate Velocity;
        X(:,i) = round(X(:,i)+V_new(:,i)); %Move Particle to new Posation;
        V_old(:,i) = V_new(:,i);
        X(X>250) = 250;
        X(X<1) = 1;
        for j = 1 : dim-1
            if X(j,i) > X(j+1,i)
                X(j,i) = X(j+1,i) - 2;
            end
        end
    end
    %%
    
    for t = 1 : i_max
        EvalValue(1,:) = Eval(X) ;
        for ii = 1 : N
            if EvalValue(1,ii) > P_best(ii)
                P_best(ii) = EvalValue(1,ii);
                P_best_pos(:,ii) = X(:,ii);
            end
        end
        % ************
        [G_best_current,indx] = max(P_best);
        if G_best_current > G_best
            G_best = G_best_current;
            G_best_pos = P_best_pos(:,indx);
        end
        % ************
        for i=1:N
            V_new(:,i) = theta * V_old(:,i)+c1*R1(:,i) .* (P_best_pos(:,i) - X(:,i))+c2*R2(:,i) .* (G_best_pos - X(:,i));
            X(:,i) = round(X(:,i) + V_new(:,i));
            V_old(:,i) = V_new(:,i);
            
            X(X>250) = 250;
            X(X<1) = 1;
            for j = 1 : dim-1
                if X(j,i) > X(j+1,i)
                    X(j,i) = X(j+1,i) - 2;
                end
            end
        end
        if (sh)
            plot(1:256,Eval(1:256));
            xlabel(strcat('iteration  ',num2str(t)),'FontSize',16)
            axis([1 256 0 max(Eval(1:256))+10])
            hold on
            for iii = 1:numel(G_best_pos)
                indx = G_best_pos(iii);                
                line([indx indx], [1 3000],'LineStyle','--','LineWidth',2,'Color','black')
                drawnow
            end
            hold off
    end
    end  
    Tresh =[Tresh;G_best_pos'];
% Tresh =G_best_pos';
% toc
    clear G_best;clear P_best_pos;clear indx;clear P_best;clear V_new;clear V_old;
end

end