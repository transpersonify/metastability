fs1 = 0.025;
fp1 = 0.04;
fp2 = 0.07;
fs2 = 0.09;
Fs=1/1.940;
[h, del] = firpm(40, [0 fs1 fp1 fp2 fs2 Fs/2]*2, [0 0 1 1 0 0]);

L = 512;
[A, om] = firamp(h, 1, L);
f=om/(2*pi);
figure(1)
clf
plot(f, A)
xlim([0 Fs/2])
title('Amplitude response')
xlabel('Frequency (normalized)')