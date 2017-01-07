%%% Run calculate_metastability.m before this %%%
% % %%% Age CSV %%%
clear all;
load('unsorted_metastability.mat');
SD=transpose(SD);
age=csvread('age_num.csv');
%load('age.mat');
[age_sorted,age_index]=sort(age);
SD_age_wise=SD(age_index);
lev1 =27;
lev2=51;
young = (age_sorted<=lev1);
middle_aged= (age_sorted>lev1 & age_sorted<=lev2);
old=(age_sorted>lev2);
temp=age_sorted;


youngvsSD=[age_sorted.*young , SD_age_wise.*young];
midagevsSD=[age_sorted.*middle_aged , SD_age_wise.*middle_aged];
oldvsSD=[age_sorted.*old , SD_age_wise.*old];

youngvsSD([~young;~young])=NaN;
midagevsSD([~middle_aged;~middle_aged])=NaN;
oldvsSD([~old;~old])=NaN;
% 
% figure;
% scatter(youngvsSD(:,1),youngvsSD(:,2),'g','filled');
% hold on;
% scatter(midagevsSD(:,1),midagevsSD(:,2),'b','filled');
% hold on;
% scatter(oldvsSD(:,1),oldvsSD(:,2),'c','filled');
% xlabel('Age');
% ylabel('Metastability');
% legend2=legend('Young', 'Middle-Aged', 'Old','location','NorthEast');
% set(legend2,...
%     'LineWidth',1,...
%     'FontSize',10);% print(fig3,'Metastability','-dpng','-r300');
% 


%%% FIT POLY
f=fittype('smoothingspline');
f=fittype('poly1');
[fit1,gof,fitinfo]=fit(age_sorted,SD_age_wise,f);
%smooth=fitinfo.p
%options = fitoptions('Method','SmoothingSpline',...
%                     'SmoothingParam',0.0001);
% [fit1,gof,fitinfo]=fit(age_sorted,SD_age_wise,f);

myfig=figure;
p11 = predint(fit1,age_sorted,0.95,'observation','off');
hold on; fill([age_sorted;fliplr(age_sorted.').'], [p11(:,1);fliplr(p11(:,2).').'],'g');
scatter(age_sorted,SD_age_wise,'filled');
plot(fit1,age_sorted,SD_age_wise);
gof
%lsline;
xlabel('Age');
ylabel('Metastability');
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
