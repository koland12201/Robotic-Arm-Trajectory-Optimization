function [cineq,ceq] = nonlconSprayer(U,Pos,gridDia,dt)

    % Compute nonlinear inequalities at U.
    % eval 4 borders
%     minBorderInd=10;
%     
%     u = U(1:2);
%     Pos=Pos+u*dt;
%     b1= Pos(1)-gridDia(1)+minBorderInd;
%     b2= Pos(2)-gridDia(2)+minBorderInd;
%     b3= -Pos(1)+minBorderInd;
%     b4= -Pos(2)+minBorderInd;
%     
%      cineq = [b1;b2;b3;b4];
   cineq=[];

    % Compute nonlinear equalities at U
%         ceq = [mod(U,1)];  must be "integer"

        % output must be either horizontal or vertical movement
%         ceq=zeros(length(U)/2,1); 
%         for i=1:1:(length(U)/2)-1
%            ceq(i) = xor(any(U(i)),any(U(i+1)));
%         end
        
        % must be top to bottom, no going back
%         ceq=zeros(length(U)/2,1); 
%         for i=1:2:(length(U)/2)
%            ceq(i) = U(i+1)>0;
%         end


	% no nonlinear equalities
  	ceq=[];


