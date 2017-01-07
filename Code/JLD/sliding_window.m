% close all;
%signal=load('bold_file.mat','bold');
% filtered=filter(Hbp2,bold(:,:,43));
% win_width = 30;  %Sliding window width
% slide_incr = 1;  %Slide for each iteration
% numstps = (length(bold(:,1,1))-win_width)/slide_incr; %Number of windows
% for i = 1:numstps
%    mean_win(i,:) = mean(filtered(i:i+win_width,:));  %Calculation for each window
% end


clc
signal=load('bold_file.mat','bold');


young_mean=reshape(mean(bold(:,:,age_index(1:23)),3),661,68);
mid_mean=reshape(mean(bold(:,:,age_index(24:42)),3),661,68);
old_mean=reshape(mean(bold(:,:,age_index(43:49)),3),661,68);



filtered=filter(Hbp2,young_mean);
hil=hilbert(filtered);
sigphase = angle(hil);


win_width = 30;  %Sliding window width
slide_incr = 1;  %Slide for each iteration
numstps = (length(sigphase(:,1,1))-win_width)/slide_incr; %Number of windows
for i = 1:numstps
    mean_win(i,:) = mean(sigphase(i:i+win_width,:));  %Calculation for each window
end


sigphase_mean=mean(mean_win,2);
for i=1:numstps
    for j=1:numstps
        diff(i,j)=cos(sigphase_mean(i)-sigphase_mean(j));
    end
end
figure;
imagesc(diff);





filtered=filter(Hbp2,mid_mean);
hil=hilbert(filtered);
sigphase = angle(hil);

win_width = 30;  %Sliding window width
slide_incr = 1;  %Slide for each iteration
numstps = (length(sigphase(:,1,1))-win_width)/slide_incr; %Number of windows
for i = 1:numstps
    mean_win(i,:) = mean(sigphase(i:i+win_width,:));  %Calculation for each window
end


sigphase_mean=mean(mean_win,2);
for i=1:numstps
    for j=1:numstps
        diff(i,j)=cos(sigphase_mean(i)-sigphase_mean(j));
    end
end
figure;
imagesc(diff);


filtered=filter(Hbp2,old_mean);
hil=hilbert(filtered);
sigphase = angle(hil);

win_width = 30;  %Sliding window width
slide_incr = 1;  %Slide for each iteration
numstps = (length(sigphase(:,1,1))-win_width)/slide_incr; %Number of windows
for i = 1:numstps
    mean_win(i,:) = mean(sigphase(i:i+win_width,:));  %Calculation for each window
end


sigphase_mean=mean(mean_win,2);
for i=1:numstps
    for j=1:numstps
        diff(i,j)=cos(sigphase_mean(i)-sigphase_mean(j));
    end
end
figure;
imagesc(diff);

