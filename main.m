%% notes
% 1. Scalable pathsize
% 2. waypoint interpolation
% 3. trajectory generation 

clc
clear
close

%% init params
    % define grid size
    gridWidth=1.6; %m
    gridLength=1.6; %m
    gridSize=0.01; %m

    % sim params
    dt= 0.1; %s
    t=	10; %s
    
    % control params
    TargetOffset=[0.05;0.05]; %m
    TargetWidth=1.3;
    TargetLength=1.3;
    TargetHeight = 15e-3;%m
    
    % spray model
    sprayerGrid=sprayerModel();
    
    % wall initial state
    GridHist = zeros(gridWidth/gridSize,gridLength/gridSize,t/dt);
   
    GridHist(:,:,1) = -TargetHeight*ones(gridWidth/gridSize,gridLength/gridSize,1)+TargetHeight*normalize(perlinNoise(GridHist(:,:,1)),'range');

    % visuals
    createVideo = 'false';
    playbackMulti = 2;
    
    % initial condition
    Pos=[270;5]; %grid x,y (assume fixed distance and orientation)
    
    
%% init vars
targetGrid=ones(gridWidth/gridSize,gridLength/gridSize,1)-10;


U=[];
u=[0;0];
hessPattern=[];
% create target shape
targetGrid=targetSprayer(targetGrid,TargetHeight,[8+TargetOffset(1)/gridSize,5+TargetOffset(2)/gridSize]);

%% run sim
for i=1:t/dt
    % sim spray
    [GridHist(:,:,i+1),Pos]=sprayerDynamics(GridHist(:,:,i),sprayerGrid,Pos,u,dt);
    i
    % Testing outputs
%     u=[-20;20];

    % Controller output
    [U] = Controller(GridHist(:,:,i),targetGrid,sprayerGrid,Pos,u,U,dt);
    u=U(1:2);

end

%% Visualization
% target grid
figure
surf(targetGrid)
shading interp
axis tight
daspect([1 1 1])

% draw inital surface
frame=figure('Name','Animation','Position', [10 10 1400 900])
CoordX=[0:gridSize:gridWidth-gridSize];
CoordY=[0:gridSize:gridLength-gridSize];
fig = surf(GridHist(:,:,1))
shading interp
axis tight
daspect([1/gridSize 1/gridSize 1])

% draw bounding box
hold on

TargetXInd=round(TargetOffset(1)/gridSize);
TargetYInd=round(TargetOffset(2)/gridSize);

TargetLengthInd=TargetLength/gridSize+TargetXInd+20;
TargetWidthInd=TargetWidth/gridSize+TargetYInd+20;
coord=[TargetXInd    TargetYInd    0;
       TargetLengthInd  TargetYInd    0;
       TargetLengthInd  TargetWidthInd  0;
       TargetXInd    TargetWidthInd  0;
       TargetXInd    TargetYInd    TargetHeight;
       TargetLengthInd  TargetYInd    TargetHeight;
       TargetLengthInd  TargetWidthInd  TargetHeight;
       TargetXInd    TargetWidthInd  TargetHeight;];
idx = [4 8 5 1 4; 1 5 6 2 1; 2 6 7 3 2; 3 7 8 4 3; 5 8 7 6 5; 1 4 3 2 1]';
xc = coord(:,1);
yc = coord(:,2);
zc = coord(:,3);
patch(xc(idx), yc(idx), zc(idx), 'r', 'facealpha', 0.1);
view(3);


if strcmp(createVideo, 'true')
    vid = VideoWriter('Plaster_Test4.mp4','MPEG-4');
    vid.FrameRate = (1/dt)*2; % regulate framerate so simtime x2
    vid.Quality = 100;
    open(vid);
end

% replay sprayer
for i=1:1:t/dt
    tic
    fig.ZData = GridHist(:,:,i);
    
    elapsed=toc;
    pause((dt-elapsed)*(1/playbackMulti));
    
    pause(max(dt-toc,0.0001));
            
    if strcmp(createVideo, 'true')
        writeVideo(vid,getframe(frame));
    end
end

if strcmp(createVideo, 'true')
    close(vid)
end