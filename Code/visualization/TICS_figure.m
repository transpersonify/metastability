clc;
close all;
signal=load('bold_file.mat','bold');
bold=signal.bold;
%filtered=filter(Hbp_final,bold);
Fs=1/1.940;
F=[0.025 0.04 0.07 0.09];
A=[0 1 0];
DEV=[0.05,0.01,0.05];
T=661;
[N,Fo,Ao,W] = firpmord(F,A,DEV,Fs);
if(mod(N,2)==1)
    N=N+1;	% it has to be even -> b is odd -> delay is integer = N/2
end

b=firpm(N, Fo, Ao, W);

for i=1:49
    for j=1:68
    tsout=conv(b,bold(:,j,i));  % produces a T+N-1 length signal
    tsout=flipud(conv(b,flipud(tsout)));
    tsout = tsout((N/2+1):(end-N/2));
    tsout=tsout((N+1):end-N);
	filtered(:,j,i)=tsout;
   end
end


plot(filtered(:,23,4));
figure;
plot(filtered(:,12,6));
T=size(filtered,1);
 for j=1:49
     for k=1:68
        hil=hilbert(filtered(:,k,j));
        sigphase(:,k,j) = angle(hil);
     end
 end
 for i=1:68
     for j=1:68
         sigdiff=sigphase(:,i,:)-sigphase(:,j,:);
         sync(:,i,j,:)=exp(1i*sigdiff);
     end
 end
 synchrony=abs(1/T*sum(sync,1));
 SD=abs(std(sync,1));
%  mean_sync=reshape(abs(mean(synchrony,2)),T,49);
%  SD=std(mean_sync,0,1);
% 
% %  R=(1/68)*(sum(c,2));
% %  R=reshape(abs(R),T,49);
% % mean_R=mean(R);
% % SD=std(R);
% % mean_RplusSTD=mean_R+SD;
% % mean_RminusSTD=mean_R-SD;
% % 
% % 
% % 
% % 
% %  fig1=figure;
% % % plot(R);
% % % xlabel('time(s)');
% % % ylabel('Phase Synchrony');
% % % print(fig1,'All_Subjects_Phase_Synchrony','-dpng','-r300');
% % % close all;
% % 
% % 
% % %%%%% Sample Synchrony and Metastability %%%%%
% % % fig2=figure;
% % figure;
% % plot(R(:,23));
% % hold on;
% % plot(1:607,ones(1,607)*mean_R(23),'r');alpha(.25);
% % hold on;
% % %plot(1:661,ones(1,661)*mean_RplusSTD(35),'r');alpha(0.25); 
% % %plot(1:661,ones(1,661)*mean_RminusSTD(35),'r');alpha(.25);
% % fill([1:607 fliplr(1:607)], [ones(1,607)*mean_RplusSTD(23) fliplr(ones(1,607)*mean_RminusSTD(23))],'r');
% % alpha(0.25);
% % xlabel('time(s)');
% % ylabel('Phase Synchrony');
% % % print(fig2,'Toy_example','-dpng','-r300');
% % % 
% % % close all;
% % 
% % %%% Age CSV %%%
% SD=transpose(SD);
% age=csvread('age_num.csv');
% [age_sorted,age_index]=sort(age);
% SD_age_wise=SD(age_index);
% lev1 =30;
% lev2=54;
% young = (age_sorted<=lev1);
% middle_aged= (age_sorted>lev1 & age_sorted<=lev2);
% old=(age_sorted>lev2);
% temp=age_sorted;
% 
% 
% youngvsSD=[age_sorted.*young , SD_age_wise.*young];
% midagevsSD=[age_sorted.*middle_aged , SD_age_wise.*middle_aged];
% oldvsSD=[age_sorted.*old , SD_age_wise.*old];
% 
% youngvsSD([~young;~young])=NaN;
% midagevsSD([~middle_aged;~middle_aged])=NaN;
% oldvsSD([~old;~old])=NaN;
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
% 
% 
% %%% FIT POLY
% f=fittype('poly1');
% [fit1,gof,fitinfo]=fit(age_sorted,SD_age_wise,f);
% myfig=figure;
% plot(fit1,age_sorted,SD_age_wise);
% p11 = predint(fit1,age_sorted,0.95,'observation','off');
% hold on; fill([age_sorted;fliplr(age_sorted.').'], [p11(:,1);fliplr(p11(:,2).').'],'g');
% scatter(age_sorted,SD_age_wise);
% lsline;
% xlabel('Age');
% ylabel('Metastability');
% 
% 
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
