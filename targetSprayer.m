function [newGrid] = targetSprayer(currentGrid,TargetHeight,Pos)
%TARGETSPRAYER Summary of this function goes here
%   Detailed explanation goes here
    target=ones(150,150).*TargetHeight;


    sprayerGrid=target;
    sprayerSize=size(sprayerGrid);

    Gridsize=size(currentGrid);

    Xind=max(min((1:sprayerSize(1))+round(Pos(1)/2)-1,Gridsize(1)),1);
    Yind=max(min((1:sprayerSize(2))+round(Pos(2)/2)-1,Gridsize(2)),1);

    currentGrid(Xind,Yind) = sprayerGrid;
    newGrid=currentGrid;

end

