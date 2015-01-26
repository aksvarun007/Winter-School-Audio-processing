function[y]=filterfir1(x,Fs,typeoffilt)

fc=150;
Wn=(2/Fs)*fc;

b=fir1(20,Wn,typeoffilt,kaiser(21,3));
%fvtool(b,1,'Fs',Fs)

y=filter(b,1,x);
t=0:1/Fs:1;
plot(t(1:100),x(1:100))
hold on
plot(t(1:100),x(1:100))
xlabel('Time (s)');
ylabel('Amplitude');
%legend('Original Signal');

