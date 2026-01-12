function ssn=ssn_generator(s, fs)
N=length(s);
noise = 1-2*rand(1,N);
[Pxx,w] = periodogram(s,[],512,fs);
b = fir2(3000,w/(fs/2),sqrt(Pxx/max(Pxx)));
ssn = filter(b,1,noise);
ssn = ssn/norm(ssn)*norm(s)*(10^0.25);
snr = 20*log10(norm(s)/norm(ssn));
fprintf("The actual SNR：%.2f dB\n",snr);
end