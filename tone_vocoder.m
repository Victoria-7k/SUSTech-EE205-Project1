function [st,sw] = tone_vocoder(s,fs,N,cutf)
st = zeros(1,length(s));
y1n = zeros(1,length(s));
D_200 = f2dmap(200);
D_7000 = f2dmap(7000);
size = linspace(D_200,D_7000,N+1);
fDivided = d2fmap(size);

for i=1:N
    %frequecy interval
    f1 = fDivided(i);
    f2 = fDivided(i+1);
    %Bandpass 
    [b,a] = butter(4,[f1 f2]/(fs/2));
    y = abs(filter(b,a,s));
    %Envelope
    [c,d] = butter(4,cutf/(fs/2),"low");
    y1 = filter(c,d,y);
    fsin=(f1+f2)/2;
    y1n = y1n+y1;
    %Generate a sinewave
    t=0:1/fs:(length(s)-1)/fs;
    y2=sin(2*pi*fsin*t);
    %multiply
    st=st+ y1.*y2;

    st=st*norm(s)/norm(st);
    sw=fftshift(fft(st,length(st)));
end  
end
