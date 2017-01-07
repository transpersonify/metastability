clc
close all;
signal=load('bold_file.mat','bold');
bold=signal.bold;
filtered=filter(Hbp2,bold);
for j=1:49
hil(:,:,j)=hilbert(filtered(:,:,j));
end
z=filtered+hil;
sigphase = angle(z);
c=exp(i*sigphase);
R=1/68*(sum(c,2));
R=reshape(abs(R),661,49);
mean_R=mean(R);
SD=std(R);
mean_RplusSTD=mean_R+SD;
mean_RminusSTD=mean_R-SD;




% fig1=figure;
% plot(R);
% xlabel('time(s)');
% ylabel('Phase Synchrony');
% print(fig1,'All_Subjects_Phase_Synchrony','-dpng','-r300');
% close all;


%%%%% Sample Synchrony and Metastability %%%%%
% fig2=figure;
figure;
plot(R(:,23));
hold on;
plot(1:661,ones(1,661)*mean_R(23),'r');alpha(.25);
hold on;
%plot(1:661,ones(1,661)*mean_RplusSTD(35),'r');alpha(0.25); 
%plot(1:661,ones(1,661)*mean_RminusSTD(35),'r');alpha(.25);
fill([1:661 fliplr(1:661)], [ones(1,661)*mean_RplusSTD(23) fliplr(ones(1,661)*mean_RminusSTD(23))],'r');
alpha(0.25);
xlabel('time(s)');
ylabel('Phase Synchrony');
% print(fig2,'Toy_example','-dpng','-r300');
% 
% close all;

%%% Age CSV %%%
SD=transpose(SD);
age=csvread('age_num.csv');
[age_sorted,age_index]=sort(age);
SD_age_wise=SD(age_index);
lev1 =25;
lev2=50;
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

figure;
scatter(youngvsSD(:,1),youngvsSD(:,2),'g','filled');
hold on;
scatter(midagevsSD(:,1),midagevsSD(:,2),'b','filled');
hold on;
scatter(oldvsSD(:,1),oldvsSD(:,2),'r','filled');
xlabel('Age');
ylabel('Metastability');
legend2=legend('Young', 'Middle-Aged', 'Old','location','NorthEast');
set(legend2,...
    'LineWidth',1,...
    'FontSize',10);% print(fig3,'Metastability','-dpng','-r300');
