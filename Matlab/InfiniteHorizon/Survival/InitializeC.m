% This small program computes the initializes the value function with EU
% coeffecients
function [x_state,PolicyRules,cEU0]=InitializeC(Para,Q)

YSize=length(Para.Y);
VGrid=Para.VGrid;
VGridSize=Para.VGridSize;
GridSize=Para.GridSize;
Y=Para.Y;

ctr=1;
x_state=ones(GridSize,2);
PolicyRules=ones(GridSize,3);
for y=1:YSize
for vind=1:VGridSize
     x_state(ctr,:)=[y,VGrid(y,vind)];
        res=EUSol(y,VGrid(y,vind),Para); % Sove the EU case for state variables z,V
EU(y,vind)=res.V1(y);

         ConsEU0=res.alpha1*Y(y);  
       VStarEU0=res.V2';
       [ConsEU0 VStarEU0(1) VStarEU0(2)];
 PolicyRules(ctr,:)=[ConsEU0 VStarEU0(1) VStarEU0(2)];
 ctr=ctr+1;
 
end

% Compute the initial coeffecient for EU case
cEU0(y,:)=funfitxy(Q(y),VGrid(y,:)',EU(y,:)');
end
% Check that coeffecients are real
if isreal(cEU0)
    disp('Initial Coeff are real')
    disp(cEU0)
save('Data/coeffEU.mat','cEU0');
else 
       disp('Initial Coeff are complex')
end


