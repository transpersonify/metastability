%The filter is designed to filter gridded data in an array of up to 5 dimensions (DATA)
%with the filtering done only in the dimension specified by DIMENSION.
%The signal in data is first decomposed in the frequency domain (amplitude vs frequency).
%Then the amplitudes associated with frequencies outside of the BANDLIMITS are set to zero.
%Then an inverse Fourier transform is performed resulting in the reconstructed signal.
 
% DATA : array to filter of up to 5 dimensions, the dimension to filter must be evenly spaced and be a multiple of 2.
% if the dimension is spaced unevenly, interpolation to regular interval is advised.
% DIMENSION : 1 integer indication the dimension to filter
% BANDLIMITS : 2 numbers indicating the boundary of the selected frequency band. The bandlimit is actually
% expressed as the period. Bandlimits have the same unit as the spacing between measurements
% ex: if filtering with measurements every day, bandlimit of [5 10] means only oscillation with periods
% of 5 to 10 days are kept in the signal. To construct a low-pass or high-pass, on can use [5 Inf] or [0 5]
% RECONSTRUCTED : array of same size as data containing the filtered signal.
 
% ATTENTION : Fourier transform are accurate for periodic signals. If the filtered values are not periodic,
% it is advised to make them periodic. Ex signal= 1 2 5 coult be modified to 1 2 5 5 2 1 for periodicity.
% Only the first half of reconstructed should be used in this case.
 
signal=load('bold_file.mat','bold');
data=signal.bold;

 
%Fourier transform and associated frequencies
for i=1:size(bold,3)
    for j=1:size(bold,2) 
       si_data=size(data);
       order=1:length(si_data);
       otherdim=order(ismember(order,1)==0);
       neworder=[1,otherdim];
       data=permute(data,[1,otherdim]);
        
        
        amplitudes = fft(data(:,i,j));
        n=size(amplitudes,1); %replaced dimension by 1
        nyquist=1/2;
        nyquist_location=n/2+1;
 
        %Generate a list of the frequencies
        if rem(size(data,1),2)==0;
        frequencies=[0,(1:n/2-1)/n,n/2/n,(n/2-1:-1:1)/n];
        end
        if rem(size(data,1),2)==1;
        frequencies=[0,(1:(n-1)/2)/n,((n-1)/2:-1:1)/n];
        end
 
       %Computes periods and decide of the ones to keep
        periods=1./frequencies;
        periodstokeep=(periods>=0.04 & periods<=0.07);
        periods(periodstokeep);
        filteredamps=amplitudes*0;
 
      %Only keep desired periods (amplitudes)
     
       filteredamps(periodstokeep)=amplitudes(periodstokeep);
    
 
      %Reconstruct the signal
      reconstructed=ifft(filteredamps,[],1);
      reconstructedr=real(reconstructed);
      reconstructedi=imag(reconstructed);
 
     %Return matrix in original order
      ordereturn=zeros([1,length(si_data)]);
      ordereturn(1)=1;
      iszero=find(ordereturn==0);
     for i=1:length(iszero)
        ordereturn(iszero(i))=i+1;
     end
     reconstructed(:,i,j)=permute(reconstructed,ordereturn);
 
    end
end