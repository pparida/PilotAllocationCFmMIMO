function [RetainLocs] = Matern2_PointPattern(ParLocs, Rinh)
% This code simulates the Matern-II point process
% Inputs: Parent points of dimension Nx2, Inhibition radius 
% Ouput: Retained points

Phi_ue = ParLocs(:,1).' + 1i*ParLocs(:,2).';
NumUE = length(ParLocs);
RetnMarker = zeros(1, NumUE); % Markers the users that are ratained
RetnMarker(1, 1) = 1;

for lp_ue = 2:NumUE   % sum(AssignedPilot==0)
    PilotInd = 1;
    UEsToCons = lp_ue;
    UELocs = Phi_ue(UEsToCons);
    
    
    UEsInCont = (abs(UELocs-Phi_ue(1:lp_ue-1)) < Rinh);
    
    if sum(UEsInCont)~=0
        continue;
    end
    RetnMarker(UEsToCons) = PilotInd;
end
RetainLocs(:,1) = real(Phi_ue(RetnMarker==1)).';
RetainLocs(:,2) = imag(Phi_ue(RetnMarker==1)).';
end