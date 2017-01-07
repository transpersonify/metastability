%load('instantaneous_phase.mat');
Control=[3;17;24;26;30;37;41;51;52;58;60;64];
DMN=[1;7;9;14;15;18;19;25;27;29;35;43;47;48;49;59;61;24;41;58];
DAN=[8;28;42;62;7;61;41];
VAN=[2;22;23;34;36;53;56;57;68;26;27;30;60;64;61];
Limbic=[5;6;11;13;31;32;40;45;65;66;8;42;47];
SMN=[16;21;33;50;55;63;67;23;29;34;57;68];
Visual=[4;10;12;20;38;44;46;54;6;40];
%fpcn=[25,59,62,28,7,41];
N=48;  %%%%% Subjects %%%%%%

T=size(sigphase,1);
synchrony=exp(1i*sigphase);
coherence_control=reshape(abs(mean(synchrony(:,Control,:),2)),T,N);
coherence_dmn=reshape(abs(mean(synchrony(:,DMN,:),2)),T,N);
coherence_dan=reshape(abs(mean(synchrony(:,DAN,:),2)),T,N);
coherence_van=reshape(abs(mean(synchrony(:,VAN,:),2)),T,N);
coherence_limbic=reshape(abs(mean(synchrony(:,Limbic,:),2)),T,N);
coherence_SMN=reshape(abs(mean(synchrony(:,SMN,:),2)),T,N);
coherence_visual=reshape(abs(mean(synchrony(:,Visual,:),2)),T,N);

SD_control=std(coherence_control,1);
SD_dmn=std(coherence_dmn,1);
SD_dan=std(coherence_dan,1);
SD_van=std(coherence_van,1);
SD_limbic=std(coherence_limbic,1);
SD_SMN=std(coherence_SMN,1);
SD_visual=std(coherence_visual,1);


%%%%%%%%%%%%%%% Results Kruskal_Wallis %%%%%%%%%%%%%%%%%%%%%
%Control : Source     SS      df     MS      Chi-sq   Prob>Chi-sq
% ------------------------------------------------------
% Groups   1312.39    2   656.193    6.43      0.0402   
% Error    8487.11   46   184.502                       
% Total    9799.5    48       

%     1.0000    2.0000    0.3143   12.4963   24.6784    0.0428
%     1.0000    3.0000   -7.4590    4.9062   17.2715    0.6240
%     2.0000    3.0000  -19.7721   -7.5901    4.5920    0.3126



% Significance: between YOUNG and MID-AGE subjects

%%%% DMN : Not significant

%%% DAN : Source     SS      df     MS      Chi-sq   Prob>Chi-sq
% ------------------------------------------------------
% Groups   2187.77    2   1093.88   10.72      0.0047   
% Error    7611.73   46    165.47                       
% Total    9799.5    48                                 

%     1.0000    2.0000   -3.1048    9.0772   21.2593    0.1895
%     1.0000    3.0000  -19.5215   -7.1562    5.2090    0.3666
%     2.0000    3.0000  -28.4155  -16.2335   -4.0514    0.0049



%%% Significant between MID-AGE and OLD

%%%%%%%%%%%%%%%% Limbic %%%%%%%%%%%%%%%%%%%%%%%
% Source     SS      df     MS      Chi-sq   Prob>Chi-sq
% ------------------------------------------------------
% Groups   1621.55    2   810.773    7.94      0.0188   
% Error    8177.95   46   177.782                       
% Total    9799.5    48                  

%     1.0000    2.0000  -10.7556    1.4265   13.6085    0.9598
%     1.0000    3.0000  -23.8340  -11.4688    0.8965    0.0760
%     2.0000    3.0000  -25.0773  -12.8952   -0.7132    0.0348

%%% Significant between MID-AGE and OLD


%%%%%%%%%%% SMN : Not significant %%%%%


%%%%%%%%%%%% VAN : Source     SS      df     MS      Chi-sq   Prob>Chi-sq
% ------------------------------------------------------
% Groups   2419.75    2   1209.88   11.85      0.0027   
% Error    7379.75   46    160.43                       
% Total    9799.5    48                                 

%     1.0000    2.0000    1.9356   14.1176   26.2997    0.0179
%     1.0000    3.0000  -13.5840   -1.2188   11.1465    0.9713
%     2.0000    3.0000  -27.5184  -15.3364   -3.1543    0.0087
% SIgnificant between YOUNG-MID and MID-OLD

%%%%%%%%% Visual : Not Significant %%%%%%%%%%%%%

