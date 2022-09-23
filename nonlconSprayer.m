function [c,ceq] = nonlconSprayer(U)

    % Compute nonlinear inequalities at U.
    c = [];
%     c=0;

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


