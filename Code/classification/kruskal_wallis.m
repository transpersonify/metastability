%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Non-Parametric 1-way ANOVA to check that ranks of three groups are
%significantly different
%Results:
%p=0.0377
% stats = 
% 
%        gnames: {3x1 cell}
%             n: [16 17 16]
%        source: 'kruskalwallis'
%     meanranks: [25.3125 18.6765 31.4062]
%          sumt: 6
% Source     SS      df     MS      Chi-sq   Prob>Chi-sq
% ------------------------------------------------------
% Groups   1337.98    2   668.991    6.55      0.0377   
% Error    8461.52   46   183.946                       
% Total    9799.5    48                                 

function [p,tbl,stats,c,m,h,nms]= kruskal_wallis(SD,age)
    close all;
   % age=csvread('age_num.csv');
    %age=age_48;
    [age_sorted,age_index]=sort(age);
    SD_age_wise=SD(age_index);
    group={};
    I=1:48;
    group(age_sorted<=27)={'young'};
    group(age_sorted>27 & age_sorted<=51)={'midage'};
    group(age_sorted>51)={'old'};
    [p,tbl,stats] = kruskalwallis(SD_age_wise,group,'on');


%%%%%%%%%%%%%%% Sceffe multiple comparision test %%%%%%%%%%%%%%%%%%%%%%%
% To see which differences are significant ones %
% Only difference between Midage-Oldage is significant
    if (p<0.05)
        figure;
        [c,m,h,nms] = multcompare(stats);
    else
        c=0;
        m=0;
        h=0;
        nms=0;
    end
end