function Cost = evalCostSingle(currentGrid,Pos,targetGrid,sprayerGrid,U,dt,Horizon)
%EVALCOST Summary of this function goes here
%   Detailed explanation goes here

% Penalty coefficients
k1=[0.001,0.001];
k2=800;


nPos=2;
Cost=0;

    for i=1:Horizon
        u = U(nPos*i-nPos+1:nPos*i);

        % sim spray
        [currentGrid,Pos]=sprayerDynamics(currentGrid,sprayerGrid,Pos,u,dt);
        
        % Cost for current step
        
        Cost1= k1*(u.^2);
        
        Cost2= k2*sum((currentGrid-targetGrid).^2,'all');
    
        Cost=Cost+Cost1+Cost2;
    end
end

