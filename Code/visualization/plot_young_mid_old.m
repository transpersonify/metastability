data = xlsread('/home/shruti/Downloads/scores.xlsx');


load('SD_networks_48.mat','age');

[age_sorted,age_index]=sort(age);
data_age_wise=data(age_index,:);
young_count = sum((age_sorted<=27)==1);
young = data_age_wise(1:young_count,:);

midage_count = sum((age_sorted>27 & age_sorted<=51)==1);
midage = data_age_wise(young_count+1:young_count+midage_count,:);

old_count = sum((age_sorted>51)==1);
oldage = data_age_wise(young_count+midage_count+1:young_count+midage_count+old_count,:);

scatter(young(:,1),young(:,2),50,'r*');
hold on
scatter(midage(:,1),midage(:,2),50,'gd');
scatter(oldage(:,1),oldage(:,2),50,'b+');
legend('young','midage','old') ;
xlabel('DF1','FontSize',12,'FontWeight','bold');
ylabel('DF2','FontSize',12,'FontWeight','bold');
hold off
X = {'Control','DMN','DAN','VAN','Limbic','SMN','Visual'};
Y = [0.646 -0.801;-1.160 -0.525;0.394  0.741;1.234  0.829;-0.363  0.182;-0.519  0.295;-0.089  0.225];
fig = figure;
bar(Y,'group');
%xlabel('control','dan','dmn');
legend('DF1', 'DF2');
set(gca, 'XTick', 1:7, 'XTickLabel', X);