[s,fs] = audioread("C_01_01.wav");
s=s';
t=(1:length(s))/fs;
[st,sw] = tone_vocoder(s,fs,4,100);