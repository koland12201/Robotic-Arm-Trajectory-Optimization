function [U] = Controller(currentGrid,targetGrid,sprayerGrid,Pos,u,U,dt)
%CONTROLLER Summary of this function goes here
%   Detailed explanation goes here

    % Actuation limit
    uMax=0.3*(160/dt); %grids/s

    % Optimization horizon
    Horizon =0.5;%s
    nHorizon=round(Horizon/dt);

    % initalize U
    m = size(Pos,1);
    if isempty(U)
        U = [u;ones(m*(nHorizon-1),1)*uMax./2];
    else
        % warm start, shift array up by 1
        U = [U(m+1:end);ones(m,1)*uMax./2];
    end

    
    
    %% optimization routine
    intcon=1:length(U);
    lb=-uMax.* ones(length(U),1);
    ub=uMax.* ones(length(U),1);
    gridDia=size(currentGrid);
    nonlcon=@(U) nonlconSprayer(U,Pos,gridDia,dt);
    err = @(U) evalCostSingle(currentGrid,Pos,targetGrid,sprayerGrid,U,dt,nHorizon);
        Aineq   = [];
        bineq   = [];
        Aeq     = [];
        beq     = [];
        A=        [];
        b=        [];

%     options = optimoptions('lsqnonlin','Display','iter');
%     U = lsqnonlin(err,U,[],[],options);

            % use sqp or interior-point
            options = optimoptions('fmincon','Display','iter','Algorithm','interior-point' ,...
            'SpecifyObjectiveGradient',false,...
            'SpecifyConstraintGradient',false,...
            'CheckGradients',false,...
            'MaxFunctionEvaluations',1e5,...
            'MaxIterations',50,...
            'DiffMinChange',2);

        U = fmincon(err,U,A,b,Aeq,beq,lb,ub, nonlcon, options);

end

