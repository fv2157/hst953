%% Script to compute scalar indicators of RASS score for each icu stay 
%% (run this script uncommenting the desired line at the beginning and at
%% the end of the script)
%
% Author: Francesco Vicario

% --------------- UNCOMMENT TO PICK DESIRED DATASET ---------------------
% load('midazolam_rass_waveforms.mat')
% load('dexmedetomidine_rass_waveforms.mat')
% -----------------------------------------------------------------------

% find delimiters between different icustay_id
delim=1+find(icustay_id(2:end)-icustay_id(1:end-1));

% 
n_icustay=1+length(delim);
table=zeros(n_icustay,3+4);
for i=1:n_icustay
    
    if i==1
        ind_start=1;ind_end=delim(i)-1;
    elseif i==n_icustay
        ind_start=delim(i-1);ind_end=length(charttime);
    else
        ind_start=delim(i-1);ind_end=delim(i)-1;
    end
    
    deltaT=seconds(charttime(ind_start+1:ind_end)-charttime(ind_start:ind_end-1));
    totT=sum(deltaT);
    wAve_fwd=sum(deltaT.*valuenum(ind_start:ind_end-1))/totT;
    wAve_bwd=sum(deltaT.*valuenum(ind_start+1:ind_end))/totT;
    Ave=mean(valuenum(ind_start:ind_end));
    Med=median(valuenum(ind_start:ind_end));
    
    table(i,1)=subject_id(ind_start);
    table(i,2)=hadm_id(ind_start);
    table(i,3)=icustay_id(ind_start);
    table(i,4)=wAve_fwd;
    table(i,5)=wAve_bwd;
    table(i,6)=Ave;
    table(i,7)=Med;
end

% --------------- UNCOMMENT TO PICK DESIRED DATASET ---------------------
% dlmwrite('dexmedetomidine_rass_summary.csv',table,'precision',6)
% dlmwrite('midazolam_rass_summary.csv',table,'precision',6)
% -----------------------------------------------------------------------

figure;plot(table(:,4));hold on;plot(table(:,5));plot(table(:,6));plot(table(:,7));
legend('fwd','bwd','ave','med')