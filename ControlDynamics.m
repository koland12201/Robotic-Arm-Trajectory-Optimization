function [newGrid,Pos] = ControlDynamics(currentGrid,sprayerGrid,Pos,u,dt)
%SPRAYERDYNAMICS Summary of this function goes here
%   Detailed explanation goes here

    ddt=0.01;
    n=round(dt/ddt);
    
	% recal grid size
	sprayerSize=size(sprayerGrid);
    Gridsize=size(currentGrid);
        
    
    for i=1:1:n
        % move pointer (with movement limit)
        Pos=Pos+u*ddt;

        % spray once
        Xind=max(min((1:sprayerSize(1))+round(Pos(1)/2)-1,Gridsize(1)),1);
        Yind=max(min((1:sprayerSize(2))+round(Pos(2)/2)-1,Gridsize(2)),1);

        currentGrid(Xind,Yind) = currentGrid(Xind,Yind)+sprayerGrid.*ddt;
    end
    
    newGrid=currentGrid;

