%%% Band-Pass filter %%%%
fs = 0.5;                 % sampling rate
F = [0.035 0.04 0.07 0.075];  % band limits
A = [0 1 0];                % band type: 0='stop', 1='pass'
dev = [0.0001 10^(0.1/20)-1 0.0001]; % ripple/attenuation spec
[M,Wn,beta,typ] = kaiserord(F,A,dev,fs);  % window parameters
b = fir1(M,Wn,typ,kaiser(M+1,beta),'noscale'); % filter design