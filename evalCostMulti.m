function Cost = evalCostMulti(currentGrid,targetGrid,U,dt,Horizon)
%EVALCOST Summary of this function goes here
%   Detailed explanation goes here

% Penalty coefficients
k1=0;
k2=10;

gridSize=size(currentGrid);
nGrid=gridSize(1)*gridSize(2);
% nGrid=2;

nPos=2;
Cost = zeros((nPos+nGrid)*Horizon,1);
Pos = U(nPos*1-nPos+1:nPos*1);
lastPos=Pos;

    for i=1:Horizon
        Pos = U(nPos*i-nPos+1:nPos*i);

        % sim spray
        currentGrid=sprayerDynamics(currentGrid,Pos,dt);
        
        % Cost for current step
        Cost((i-1)*(nPos+nGrid)+1:i*(nPos+nGrid))=[...
        +k1 .* (Pos-lastPos).^2;
        +k2 .* sum(sum((currentGrid-targetGrid).^2));
        +sum(sum(-log((targetGrid+0.2)-currentGrid)))
        ];
        
        lastPos=Pos;
    end
end

