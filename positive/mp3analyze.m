function [y,Fs]=mp3analyze(fname)

f=fopen(fname,'r+');
fseek(f,20,0); 
fwrite(f,[3 0]); 
fclose(f);
[y,Fs]=wavread(fname);
n=512;
yfft=fft(y,n);
k=0:Fs/n:(n-1)*Fs/n;
yabs=abs(yfft);
figure;
stem(k,yabs);