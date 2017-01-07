clc;
close all;
signal=load('bold_file_48.mat','bold');
bold=signal.bold;
%bold = bsxfun(@minus,bold,mean(bold,1)); 
%bold=newb;
%filtered=filter(Hbp,bold);
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

for i=1:48
    for j=1:68
    tsout=conv(b,bold(:,j,i));  % produces a T+N-1 length signal
    tsout=flipud(conv(b,flipud(tsout)));
    tsout = tsout((N/2+1):(end-N/2));
    tsout=tsout((N+1):end-N);
	filtered(:,j,i)=tsout;
   end
end

%filtered=bold;
plot(filtered(:,23,4));
figure;
plot(filtered(:,12,6));
T=size(filtered,1);
 for j=1:48
     for k=1:68
        hil=hilbert(filtered(:,k,j));
        sigphase(:,k,j) = angle(hil);
        synchrony=exp(1i*sigphase);
     end
 end
%  for i=1:68
%      for j=1:68
%          sigdiff=sigphase(:,i,:)-sigphase(:,j,:);
%          sync(:,i,j,:)=exp(1i*sigdiff);
%      end
%  end
%  synchrony=abs(1/T*sum(sync,1));
%  SD=abs(std(sync,1));
   coherence=reshape(abs(mean(synchrony,2)),T,48);
   SD=std(coherence,0,1); 
 save('unsorted_metastability_48_unfiltered.mat','SD');
 save('instantaneous_phase_48_unfiltered.mat','sigphase');  
   
%save('unsorted_metastability.mat','SD');
%save('instantaneous_phase.mat','sigphase');