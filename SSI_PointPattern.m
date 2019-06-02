function [RetainLocs] = SSI_PointPattern(ParLocs, Rinh)
% This code simulates the SSI point process
% Inputs: Parent points of dimension Nx2, Inhibition radius 
% Ouput: Retained points

NumPilots = 1; % Keep this 1 for SSI point process


Phi_ue = ParLocs(:,1).' + 1i*ParLocs(:,2).';
NumUE = length(ParLocs);
RetnMarker = zeros(1, NumUE); % Markers the users that are ratained


for lp_ue = 1:NumUE   % sum(AssignedPilot==0)
    PilotInd = 1;
    UEsToCons = lp_ue;
    UELocs = Phi_ue(UEsToCons);
    
    
    UEsInCont = (abs(UELocs-Phi_ue) < Rinh);
    PilotsOfContUE = RetnMarker(UEsInCont);
    
    TempPilotPool = setdiff([1:NumPilots],PilotsOfContUE);
    if isempty(TempPilotPool)
        continue;
    end
    RetnMarker(UEsToCons) = PilotInd;
end
RetainLocs(:,1) = real(Phi_ue(RetnMarker==1)).';
RetainLocs(:,2) = imag(Phi_ue(RetnMarker==1)).';
end