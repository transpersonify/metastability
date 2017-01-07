load('instantaneous_phase.mat');
load('community_phase_mean.mat');
%dmn=[5,39,22,56,27,61];
%fpcn=[25,59,62,28,7,41];
%dmn=find(ci0==ci0(24));
%control=find(ci0==ci0(34));
%sensory=find(ci0==ci0(23));
T=size(sigphase,1);
synchrony=exp(1i*sigphase);
coherence_dmn=reshape(abs(mean(synchrony(:,dmn,:),2)),T,49);
coherence_control=reshape(abs(mean(synchrony(:,control,:),2)),T,49);
coherence_sensory=reshape(abs(mean(synchrony(:,sensory,:),2)),T,49);
SD_dmn=std(coherence_dmn,1);
SD_control=std(coherence_control,1);
SD_sensory=std(coherence_sensory,1);

save ('SD_dmn.mat','SD_dmn');
save('SD_control.mat','SD_control');
save('SD_sensory.mat','SD_sensory');

%%%%%%%%%%%% Kruskal Wallis DMN %%%%%%%%%%%%%%%%%%%%%
% Source     SS      df     MS      Chi-sq   Prob>Chi-sq
% ------------------------------------------------------
% Groups   1921.67    2   960.837    9.41       0.009   
% Error    7877.83   46   171.257                       
% Total    9799.5    48       
% Midage   Old      Lower      Midage-Old    Upper     p-value    
%2.0000    3.0000  -27.0442  -14.8621   -2.6801    0.0116



%[p1,tbl1,stats1,c1,m1,h1,nms1]=kruskal_wallis(SD_dmn);


%%%%%%%%%%%%%%% Kruskal-wallis FPCN %%%%%%%%%%%%%%
%   NOT SIGNIFICANT DIFFERENCEs
%[p,tbl,stats,c,m,h,nms]=kruskal_wallis(SD_fpcn);


