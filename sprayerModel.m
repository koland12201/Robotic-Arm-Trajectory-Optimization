function [SprayGrid] = sprayerModel()
%SPRAYERMODEL Summary of this function goes here
%   Detailed explanation goes here

    % sprayer model params
    N = 20;
    S = 0.5;
    scale=3;
    FlowConst=0.05;
    
    
    x=linspace(-S, S,N);
    y=x;
    [X,Y]=meshgrid(x,y);

    SprayGrid=(3/sqrt(2*pi).*exp(-((X*scale).^2)-((Y*scale).^2)))*FlowConst;


end

