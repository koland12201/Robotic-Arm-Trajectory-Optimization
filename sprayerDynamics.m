function [newGrid,Pos] = sprayerDynamics(currentGrid,sprayerGrid,Pos,u,dt)
%SPRAYERDYNAMICS Summary of this function goes here
%   Detailed explanation goes here

    ddt=0.05;
    n=round(dt/ddt);
    
	% recal grid size
	sprayerSize=size(sprayerGrid);
    Gridsize=size(currentGrid);   
    
    for i=1:1:n
        % move pointer (with movement limit)
        Pos=Pos+u*ddt;

        % hard spray head constrains
        Pos(1) = max(min(Pos(1),Gridsize(1)-(sprayerSize(1)/2)-1),(sprayerSize(1)/2)+1);
        Pos(2) = max(min(Pos(2),Gridsize(2)-(sprayerSize(2)/2)-1),(sprayerSize(2)/2)+1);
        
        % spray once
        Xind=(1:sprayerSize(1))+round(Pos(1))-sprayerSize(1)/2-1;
        Yind=(1:sprayerSize(2))+round(Pos(2))-sprayerSize(2)/2-1;

        currentGrid(Xind,Yind) = currentGrid(Xind,Yind)+sprayerGrid.*ddt;
    end
    
    newGrid=currentGrid;

