%%% Band Pass Filter : Direct-form FIR %%%
%%%%  0.005Hz-0.01Hz-0.2Hz-0.25Hz %%%%%%
%%%%  Sampling rate : 0.5Hz %%%%

clc
close all;
signal=load('bold_file.mat','bold');
filtered=filter(Hbp2,bold(:,:,25));
hil(:,:)=hilbert(filtered);

sigphase = angle(hil);
for i=1:68
    for j=1:68
        if(abs(sigphase(:,i)-sigphase(:,j))<=pi)
            ROI_diff(:,i,j)=abs(sigphase(:,i)-sigphase(:,j));
        else
            ROI_diff(:,i,j)=2*pi-abs(sigphase(:,i)-sigphase(:,j));
        end
    end
end



sync=1-(ROI_diff/pi);

win_width =10;  %Sliding window width
slide_incr =8;  %Slide for each iteration
numstps = (length(sigphase(:,1))-win_width)/slide_incr; %Number of windows
for i = 1:numstps
    mean_win(i,:,:) = mean(ROI_diff(i:i+win_width,:,:));  %Calculation for each window
end

for i=1:numstps
u(i,:)=nonzeros(triu(reshape(mean_win(i,:,:),68,68)));
end
u_corr=corr(u.');