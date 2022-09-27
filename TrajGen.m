function u = TrajGen(currentGrid,lineDist,ct,t)
%TRAJGEN Summary of this function goes here
%   Detailed explanation goes here

%   prep vars
    gridDia=size(currentGrid);
    
%   generate waypoints according to grid size, start from the top
    %inital point
    totalLines=gridDia./lineDist;
