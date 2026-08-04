%%%% LMS自适应滤波算法实现滤波功能 %%%%

% 产生理想信号
t = 0:1999
%xs = 10*cos(0.5*t);%xs为理想的余弦信号
%绘制理想信号的图像
%figure;
%subplot(5,1,1);
%grid;%显示窗格
%plot(t,xs);
%title("理想信号");
%dft
%xs = 10*cos(0.5*t);%xs为理想的余弦信号
fs=20;
M=2000;
tx=(0:M-1)/fs
f1=0.5/(2*pi);
y=10*cos(2*pi*f1*tx);
X1=fft(y);
Y1=abs(X1)*2/2000;
freq=fs*(0:M/2)/2000;
%magX1=abs(X1)/max(abs(X1));
subplot(5,1,1);
plot(tx,y);
title("signal-time domain");
subplot(5,1,2);
plot(freq,Y1(1:M/2+1),'k');xlim([0 1]);
title("signal-freq domain");

%产生随机噪声信号
%xn = randn(1,200);%产生一个1×200大小的噪声信号
fs2=20;
M2=2000;
tx2=(0:M2-1)/fs2
f2=5/(2*pi);
xn=8*sin(2*pi*f2*tx2);
%绘制随机噪声的图像
subplot(5,1,3);
plot(tx2,xn);
title("noise-time domain");

X2=fft(xn);
Y2=abs(X2)*2/2000;
freq2=fs2*(0:M2/2)/2000;
subplot(5,1,4);
plot(freq2,Y2(1:M2/2+1),'k');xlim([0 1]);
title("nosie-freq domain");

%产生输入信号
%xn = xs+0.5*xn;
%xn = xn.';%将输入信号由行向量转置为列向量
%dn = xs.';%将理想信号由行向量转置为列向量
%绘制输入信号和理想信号的图像
%figure;
%subplot(2,1,1);
%plot(t,xn,'r',t,dn,'blue');
%legend('混有噪声后的输入信号','理想信号');
%title('输入信号和理想信号的对比');
%频谱分析
fs3=20;
M3=2000;
%tx3=(0:M3-1)/fs3
%f2=5/(2*pi);
%xn3=10*cos(0.5*tx3)+4*sin(5*tx3);
%X3=fft(xn3);
%Y3=abs(X3)*2/2000;
%freq3=fs3*(0:M3/2)/2000;
%subplot(2,1,2);
%plot(freq3,Y3(1:M2/2+1),'k');xlim([0 2]);
%title("噪声频率信号");

%产生输入信号
xn = 0.5*y+xn;

figure;
subplot(5,1,1);
plot(tx2,xn,'blue');
title("combined signal-time domain");

X5=fft(xn);
Y5=abs(X5)*2/2000;
freq3=fs3*(0:M3/2)/2000;
subplot(5,1,2);
plot(freq3,Y5(1:M2/2+1),'k');xlim([0 1]);
title("combined signal-freq domain");


%xn = xn.';%将输入信号由行向量转置为列向量
%dn = y.';%将理想信号由行向量转置为列向量
dn =  xn.';%将理想信号由行向量转置为列向量
xn=y.';
%求收敛常数
fe = max(eig(xn*xn.'));%求解输入xn的自相关矩阵的最大特征值fe,A = eig(B),意为将矩阵B的特征值组成向量A
mu = 2*(1/fe);

%引用LMS算法实现滤波
[w,en,yn] = LMS(xn,dn,mu);

%绘制滤波器输出信号和误差信号图像

subplot(5,1,3);
grid;
txy=(0:100);
plot(tx2,yn);
title('Filtered signal-time domain');
subplot(5,1,5);
grid;
plot(t,xn,'red',t,yn,'blue',t,en,'yellow');
legend('Input signal','Output signal','error signal');
title('三种信号的比较');


X4=fft(yn);
Y4=abs(X4)*2/2000;
freq4=fs3*(0:M3/2)/2000;
subplot(5,1,4);
plot(freq4,Y4(1:M2/2+1),'k');xlim([0 1]);
title('Filtered signal-freq domain');

X5=fft(en);
Y5=abs(X5)*2/2000;
freq5=fs3*(0:M3/2)/2000;
figure;
subplot(2,1,1);
plot(en); 
title('What we actually want signal-freq domain');
subplot(2,1,2);
plot(freq5,Y5(1:M2/2+1),'k');xlim([0 1]);
title('What we actually want signal-freq domain');


