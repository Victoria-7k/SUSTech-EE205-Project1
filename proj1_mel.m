
clear

%% task 1
[s,fs] = audioread("C_01_01.wav");
s=s';
sw = fftshift(fft(s));
t=(1:length(s))/fs;
w=linspace(-fs/2,fs/2,length(s));
[st1,sw1] = mel_vocoder(s,fs,1,50);
[st2,sw2] = mel_vocoder(s,fs,2,50);
[st3,sw3] = mel_vocoder(s,fs,4,50);
[st4,sw4] = mel_vocoder(s,fs,6,50);
[st5,sw5] = mel_vocoder(s,fs,8,50);
figure("Name","Task1")

subplot(621)
plot(t,s)
xlabel("Time(s)")
ylabel("Amplitude")
title("Original signal (time domain)")

subplot(622)
plot(w,abs(sw))
xlabel("frequency(Hz)")
ylabel("Magnitude")
title("Original signal (frequency(Hz) domain)")

subplot(623)
plot(t,st1)
xlabel("Time(s)")
ylabel("Amplitude")
title("N=1 (time domain)")

subplot(624)
plot(w,abs(sw1))
xlabel("frequency(Hz)")
ylabel("Magnitude")
title("N=1 (frequency(Hz) domain)")

%score = visqol(s,st1,fs);
%disp(score)

subplot(625)
plot(t,st2)
xlabel("Time(s)")
ylabel("Amplitude")
title("N=2 (time domain)")

subplot(626)
plot(w,abs(sw2))
xlabel("frequency(Hz)")
ylabel("Magnitude")
title("N=2 (frequency(Hz) domain)")

subplot(627)
plot(t,st3)
xlabel("Time(s)")
ylabel("Amplitude")
title("N=4 (time domain)")

subplot(628)
plot(w,abs(sw3))
xlabel("frequency(Hz)")
ylabel("Magnitude")
title("N=4 (frequency(Hz) domain)")

subplot(629)
plot(t,st4)
xlabel("Time(s)")
ylabel("Amplitude")
title("N=6 (time domain)")

subplot(6,2,10)
plot(w,abs(sw4))
xlabel("frequency(Hz)")
ylabel("Magnitude")
title("N=6 (frequency(Hz) domain)")

subplot(6,2,11)
plot(t,st5)
xlabel("Time(s)")
ylabel("Amplitude")
title("N=8 (time domain)")

subplot(6,2,12)
plot(w,abs(sw5))
xlabel("frequency(Hz)")
ylabel("Magnitude")
title("N=8 (frequency(Hz) domain)")

%% task 1 STFT
% 设置 STFT 参数
win = hamming(512); % 窗函数
noverlap = 256; % 重叠长度
nfft = 1024; % FFT 点数

figure;
% 原始信号 STFT
subplot(6,1,1);
spectrogram(s, win, noverlap, nfft, fs, 'yaxis');
title('原始信号的 STFT 热力图');

% 处理后信号 STFT
subplot(6,1,2);
spectrogram(st1, win, noverlap, nfft, fs, 'yaxis');
title('N=1 的 STFT 热力图');

subplot(6,1,3);
spectrogram(st2, win, noverlap, nfft, fs, 'yaxis');
title('N=2 的 STFT 热力图');

subplot(6,1,4);
spectrogram(st3, win, noverlap, nfft, fs, 'yaxis');
title('N=4 的 STFT 热力图');

subplot(6,1,5);
spectrogram(st4, win, noverlap, nfft, fs, 'yaxis');
title('N=6 的 STFT 热力图');

subplot(6,1,6);
spectrogram(st5, win, noverlap, nfft, fs, 'yaxis');
title('N=8 的 STFT 热力图');

%% Task 1 ViSQOL/STOI
N_list = [2, 4, 6, 8, 16];
score1 = zeros(1, length(N_list));
score1_stoi = zeros(1, length(N_list));

for i = 1:length(N_list)
    [st_temp, ~] = mel_vocoder(s, fs, N_list(i), 50);
    score1(i) = visqol(st_temp, s, fs);
    score1_stoi(i) = stoi(st_temp, s, fs);
end

figure("Name", "Task1：还原质量评分(N change)");

% 使用 bar 绘制条形图
subplot(211)
b = bar(score1);

% 设置 X 轴刻度标签为 N_list 的值
set(gca, 'XTick', 1:length(N_list), 'XTickLabel', N_list);

% 美化图形
xlabel("Number of bands (N)");
ylabel("ViSQOL Score");
title("ViSQOL vs N (SNR=-5dB, cutf=50Hz)");
grid on;

% 在每个条形上方显示具体数值
xtips = b.XEndPoints;
ytips = b.YEndPoints;
labels = string(round(ytips, 2)); % 保留两位小数
text(xtips, ytips, labels, 'HorizontalAlignment', 'center', ...
    'VerticalAlignment', 'bottom');

subplot(212)
b = bar(score1_stoi);

% 设置 X 轴刻度标签为 N_list 的值
set(gca, 'XTick', 1:length(N_list), 'XTickLabel', N_list);

% 美化图形
xlabel("Number of bands (N)");
ylabel("STOI Score");
title("STOI vs N (SNR=-5dB, cutf=50Hz)");
grid on;

% 在每个条形上方显示具体数值
xtips = b.XEndPoints;
ytips = b.YEndPoints;
labels = string(round(ytips, 2)); % 保留两位小数
text(xtips, ytips, labels, 'HorizontalAlignment', 'center', ...
    'VerticalAlignment', 'bottom');


%% task 2
[st6,sw6] = mel_vocoder(s,fs,4,20);
[st7,sw7] = mel_vocoder(s,fs,4,50);
[st8,sw8] = mel_vocoder(s,fs,4,100);
[st9,sw9] = mel_vocoder(s,fs,4,400);

figure("Name","Task2")

subplot(521)
plot(t,s)
xlabel("Time(s)")
ylabel("Amplitude")
title("Original signal (time domain)")

subplot(522)
plot(w,abs(sw))
xlabel("frequency(Hz)")
ylabel("Magnitude")
title("Original signal (frequency(Hz) domain)")

subplot(523)
plot(t,st6)
xlabel("Time(s)")
ylabel("Amplitude")
title("cutf=20Hz (time domain)")

subplot(524)
plot(w,abs(sw6))
xlabel("frequency(Hz)")
ylabel("Magnitude")
title("cutf=20Hz (frequency(Hz) domain)")

subplot(525)
plot(t,st7)
xlabel("Time(s)")
ylabel("Amplitude")
title("cutf=50Hz (time domain)")

subplot(526)
plot(w,abs(sw7))
xlabel("frequency(Hz)")
ylabel("Magnitude")
title("cutf=50Hz (frequency(Hz) domain)")

subplot(527)
plot(t,st8)
xlabel("Time(s)")
ylabel("Amplitude")
title("cutf=100Hz (time domain)")

subplot(528)
plot(w,abs(sw8))
xlabel("frequency(Hz)")
ylabel("Magnitude")
title("cutf=100Hz(frequency(Hz) domain)")

subplot(529)
plot(t,st9)
xlabel("Time(s)")
ylabel("Amplitude")
title("cutf=400Hz (time domain)")

subplot(5,2,10)
plot(w,abs(sw9))
xlabel("frequency(Hz)")
ylabel("Magnitude")
title("cutf=400Hz (frequency(Hz) domain)")

%% task 2 STFT
figure;
% 原始信号 STFT
subplot(5,1,1);
spectrogram(s, win, noverlap, nfft, fs, 'yaxis');
title('原始信号的 STFT 热力图');

% 处理后信号 STFT
subplot(5,1,2);
spectrogram(st6, win, noverlap, nfft, fs, 'yaxis');
title('cutf=20 的 STFT 热力图');

subplot(5,1,3);
spectrogram(st7, win, noverlap, nfft, fs, 'yaxis');
title('cutf=50 的 STFT 热力图');

subplot(5,1,4);
spectrogram(st8, win, noverlap, nfft, fs, 'yaxis');
title('cutf=100 的 STFT 热力图');

subplot(5,1,5);
spectrogram(st9, win, noverlap, nfft, fs, 'yaxis');
title('cut=400 的 STFT 热力图');

%% Task 2 ViSQOL/STOI
N_list = [20, 50, 100, 400];
score2 = zeros(1, length(N_list));
score2_stoi = zeros(1, length(N_list));

for i = 1:length(N_list)
    [st_temp, ~] = mel_vocoder(s, fs, N_list(i), 50);
    score2(i) = visqol(st_temp, s, fs);
    score2_stoi(i) = stoi(st_temp, s, fs);
end

figure("Name", "Task4：还原质量评分(cutf change)");

% 使用 bar 绘制条形图
subplot(211)
b = bar(score2);

% 设置 X 轴刻度标签为 N_list 的值
set(gca, 'XTick', 1:length(N_list), 'XTickLabel', N_list);

% 美化图形
xlabel("Cutoff Frequency");
ylabel("ViSQOL Score");
ylim([0 4.5])
title("ViSQOL vs cutf (SNR=-5dB, N=6)");
grid on;

% 在每个条形上方显示具体数值
xtips = b.XEndPoints;
ytips = b.YEndPoints;
labels = string(round(ytips, 2)); % 保留两位小数
text(xtips, ytips, labels, 'HorizontalAlignment', 'center', ...
    'VerticalAlignment', 'bottom');

subplot(212)
b = bar(score2_stoi);

% 设置 X 轴刻度标签为 N_list 的值
set(gca, 'XTick', 1:length(N_list), 'XTickLabel', N_list);

% 美化图形
xlabel("Cutoff Frequency");
ylabel("STOI Score");
title("STOI vs cutf (SNR=-5dB, N=6)");
grid on;

% 在每个条形上方显示具体数值
xtips = b.XEndPoints;
ytips = b.YEndPoints;
labels = string(round(ytips, 2)); % 保留两位小数
text(xtips, ytips, labels, 'HorizontalAlignment', 'center', ...
    'VerticalAlignment', 'bottom');

%% Task3
%生成噪音
ssn=ssn_generator(s, fs);
snr_dB=-5;
P_s=sum(s.^2)/length(s);
P_n=sum(ssn.^2)/length(ssn);
k=sqrt(P_s/(10^(snr_dB/10)*P_n));
s_noisy=s+k*ssn;
sw_noisy=fftshift(fft(s_noisy));

[st3_N2,sw3_N2]=mel_vocoder(s_noisy,fs,2,50);
[st3_N4,sw3_N4]=mel_vocoder(s_noisy,fs,4,50);
[st3_N6,sw3_N6]=mel_vocoder(s_noisy,fs,6,50);
[st3_N8,sw3_N8]=mel_vocoder(s_noisy,fs,8,50);
[st3_N16,sw3_N16]=mel_vocoder(s_noisy,fs,16,50);

%SNR验证
fprintf("Task3 带噪信号SNR验证：\n");
snr_actual=snr_verify(s, s_noisy);

figure("Name","Task3：带噪信号合成（SNR=-5dB，cutf=50Hz)");
%干净语音
subplot(7,2,1);
plot(t,s);
xlabel("Time(s)");
ylabel("Amplitude");
title("Original signal (time domain)");

subplot(7,2,2);
plot(w,abs(sw));
xlabel("Frequency(Hz)");
ylabel("Magnitude");
title("Original signal (frequency(Hz) domain)");

%带噪语音
subplot(7,2,3);
plot(t,s_noisy);
xlabel("Time(s)");
ylabel("Amplitude");
title("Noisy (SNR=-5dB, time)");

subplot(7,2,4);
plot(w,abs(sw_noisy));
xlabel("Frequency(Hz)");
ylabel("Magnitude");
title("Noisy (SNR=-5dB, freq)");

%N=2~N=16合成语音
subplot(7,2,5);
plot(t,st3_N2);
xlabel("Time(s)");
ylabel("Amplitude");
title("N=2 (time)");

subplot(7,2,6);
plot(w,abs(sw3_N2));
xlabel("Frequency(Hz)");
ylabel("Magnitude");
title("N=2 (freq)");

subplot(7,2,7);
plot(t,st3_N4);
xlabel("Time(s)");
ylabel("Amplitude");
title("N=4 (time)");

subplot(7,2,8);
plot(w,abs(sw3_N4));
xlabel("Frequency(Hz)");
ylabel("Magnitude");
title("N=4 (freq)");

subplot(7,2,9);
plot(t,st3_N6);
xlabel("Time(s)");
ylabel("Amplitude");
title("N=6 (time)");

subplot(7,2,10);
plot(w,abs(sw3_N6));
xlabel("Frequency(Hz)");
ylabel("Magnitude");
title("N=6 (freq)");

subplot(7,2,11);
plot(t,st3_N8);
xlabel("Time(s)");
ylabel("Amplitude");
title("N=8 (time)");

subplot(7,2,12);
plot(w,abs(sw3_N8));
xlabel("Frequency(Hz)");
ylabel("Magnitude");
title("N=8 (freq)");

subplot(7,2,13);
plot(t,st3_N16);
xlabel("Time(s)");
ylabel("Amplitude");
title("N=16 (time)");

subplot(7,2,14);
plot(w,abs(sw3_N16));
xlabel("Frequency(Hz)");
ylabel("Magnitude");
title("N=16 (freq)");

%% Task 3 ViSQOL/STOI
N_list = [2, 4, 6, 8, 16];
score3 = zeros(1, length(N_list));
score3_stoi = zeros(1, length(N_list));

for i = 1:length(N_list)
    [st_temp, ~] = mel_vocoder(s_noisy, fs, N_list(i), 50);
    score3(i) = visqol(st_temp, s, fs);
    score3_stoi(i) = stoi(st_temp, s, fs);
end

figure("Name", "Task3：还原质量评分(N change)");

% 使用 bar 绘制条形图
subplot(211)
b = bar(score3);

% 设置 X 轴刻度标签为 N_list 的值
set(gca, 'XTick', 1:length(N_list), 'XTickLabel', N_list);

% 美化图形
xlabel("Number of bands (N)");
ylabel("ViSQOL Score");
title("ViSQOL vs N (SNR=-5dB, cutf=50Hz)");
grid on;

% 在每个条形上方显示具体数值
xtips = b.XEndPoints;
ytips = b.YEndPoints;
labels = string(round(ytips, 2)); % 保留两位小数
text(xtips, ytips, labels, 'HorizontalAlignment', 'center', ...
    'VerticalAlignment', 'bottom');

subplot(212)
b = bar(score3_stoi);

% 设置 X 轴刻度标签为 N_list 的值
set(gca, 'XTick', 1:length(N_list), 'XTickLabel', N_list);

% 美化图形
xlabel("Number of bands (N)");
ylabel("STOI Score");
title("STOI vs N (SNR=-5dB, cutf=50Hz)");
grid on;

% 在每个条形上方显示具体数值
xtips = b.XEndPoints;
ytips = b.YEndPoints;
labels = string(round(ytips, 2)); % 保留两位小数
text(xtips, ytips, labels, 'HorizontalAlignment', 'center', ...
    'VerticalAlignment', 'bottom');

%% Task 3 STFT

figure;
% 原始信号 STFT
subplot(7,1,1);
spectrogram(s, win, noverlap, nfft, fs, 'yaxis');
title('原始信号的 STFT 热力图');

% 处理后信号 STFT
subplot(7,1,2);
spectrogram(s_noisy, win, noverlap, nfft, fs, 'yaxis');
title('N=1 的 STFT 热力图');

subplot(7,1,3);
spectrogram(st3_N2, win, noverlap, nfft, fs, 'yaxis');
title('N=2 的 STFT 热力图');

subplot(7,1,4);
spectrogram(st3_N4, win, noverlap, nfft, fs, 'yaxis');
title('N=4 的 STFT 热力图');

subplot(7,1,5);
spectrogram(st3_N6, win, noverlap, nfft, fs, 'yaxis');
title('N=6 的 STFT 热力图');

subplot(7,1,6);
spectrogram(st3_N8, win, noverlap, nfft, fs, 'yaxis');
title('N=8 的 STFT 热力图');

subplot(7,1,7);
spectrogram(st3_N16, win, noverlap, nfft, fs, 'yaxis');
title('N=16 的 STFT 热力图');

%% Task 4
[st4_c20,sw4_c20]=mel_vocoder(s_noisy,fs,6,20);
[st4_c50,sw4_c50]=mel_vocoder(s_noisy,fs,6,50);
[st4_c100,sw4_c100]=mel_vocoder(s_noisy,fs,6,100);
[st4_c400,sw4_c400]=mel_vocoder(s_noisy,fs,6,400);

figure("Name","Task4：带噪信号合成（SNR=-5dB，N=6）");
%干净语音
subplot(6,2,1);
plot(t,s);
xlabel("Time(s)");
ylabel("Amplitude");
title("Original signal (time domain)");

subplot(6,2,2);
plot(w,abs(sw));
xlabel("Frequency(Hz)");
ylabel("Magnitude");
title("Original signal (frequency(Hz) domain)");

%带噪语音
subplot(6,2,3);
plot(t,s_noisy);
xlabel("Time(s)");
ylabel("Amplitude");
title("Noisy (SNR=-5dB, time)");

subplot(6,2,4);
plot(w,abs(sw_noisy));
xlabel("Frequency(Hz)");
ylabel("Magnitude");
title("Noisy (SNR=-5dB, freq)");

% cutf=20Hz~400Hz
subplot(6,2,5);
plot(t,st4_c20);
xlabel("Time(s)");
ylabel("Amplitude");
title("cutf=20Hz (time)");

subplot(6,2,6);
plot(w,abs(sw4_c20));
xlabel("Frequency(Hz)");
ylabel("Magnitude");
title("cutf=20Hz (freq)");

subplot(6,2,7);
plot(t,st4_c50);
xlabel("Time(s)");
ylabel("Amplitude");
title("cutf=50Hz (time)");

subplot(6,2,8);
plot(w,abs(sw4_c50));
xlabel("Frequency(Hz)");
ylabel("Magnitude");
title("cutf=50Hz (freq)");

subplot(6,2,9); 
plot(t,st4_c100);
xlabel("Time(s)");
ylabel("Amplitude");
title("cutf=100Hz (time)");

subplot(6,2,10);
plot(w,abs(sw4_c100));
xlabel("Frequency(Hz)");
ylabel("Magnitude");
title("cutf=100Hz (freq)");

subplot(6,2,11);
plot(t,st4_c400);
xlabel("Time(s)");
ylabel("Amplitude");
title("cutf=400Hz (time)");

subplot(6,2,12);
plot(w,abs(sw4_c400));
xlabel("Frequency(Hz)");
ylabel("Magnitude");
title("cutf=400Hz (freq)");

%% Task 4 ViSQOL/STOI
N_list = [20, 50, 100, 400];
score4 = zeros(1, length(N_list));
score4_stoi = zeros(1, length(N_list));

for i = 1:length(N_list)
    [st_temp, ~] = mel_vocoder(s_noisy, fs, N_list(i), 50);
    score4(i) = visqol(st_temp, s, fs);
    score4_stoi(i) = stoi(st_temp, s, fs);
end

figure("Name", "Task4：还原质量评分(cutf change)");

% 使用 bar 绘制条形图
subplot(211)
b = bar(score4);

% 设置 X 轴刻度标签为 N_list 的值
set(gca, 'XTick', 1:length(N_list), 'XTickLabel', N_list);

% 美化图形
xlabel("Cutoff Frequency");
ylabel("ViSQOL Score");
title("ViSQOL vs cutf (SNR=-5dB, N=6)");
grid on;

% 在每个条形上方显示具体数值
xtips = b.XEndPoints;
ytips = b.YEndPoints;
labels = string(round(ytips, 2)); % 保留两位小数
text(xtips, ytips, labels, 'HorizontalAlignment', 'center', ...
    'VerticalAlignment', 'bottom');

subplot(212)
b = bar(score4_stoi);

% 设置 X 轴刻度标签为 N_list 的值
set(gca, 'XTick', 1:length(N_list), 'XTickLabel', N_list);

% 美化图形
xlabel("Cutoff Frequency");
ylabel("STOI Score");
title("STOI vs cutf (SNR=-5dB, N=6)");
grid on;

% 在每个条形上方显示具体数值
xtips = b.XEndPoints;
ytips = b.YEndPoints;
labels = string(round(ytips, 2)); % 保留两位小数
text(xtips, ytips, labels, 'HorizontalAlignment', 'center', ...
    'VerticalAlignment', 'bottom');

%% Task 4 STFT

figure;
% 原始信号 STFT
subplot(6,1,1);
spectrogram(s, win, noverlap, nfft, fs, 'yaxis');
title('原始信号的 STFT 热力图');

% 处理后信号 STFT
subplot(6,1,2);
spectrogram(s_noisy, win, noverlap, nfft, fs, 'yaxis');
title('带噪声音 的 STFT 热力图');

subplot(6,1,3);
spectrogram(st4_c20, win, noverlap, nfft, fs, 'yaxis');
title('cutf=20 的 STFT 热力图');

subplot(6,1,4);
spectrogram(st4_c50, win, noverlap, nfft, fs, 'yaxis');
title('cutf=50 的 STFT 热力图');

subplot(6,1,5);
spectrogram(st4_c100, win, noverlap, nfft, fs, 'yaxis');
title('cutf=100 的 STFT 热力图');

subplot(6,1,6);
spectrogram(st4_c400, win, noverlap, nfft, fs, 'yaxis');
title('cutf=400 的 STFT 热力图');

%% 
% %% Bonus 1: N (abandoned)
% N_1 = 100;
% score1=zeros(1,N_1);
% for i=1:N_1
%     [st_n,sw_n]=mel_vocoder(s,fs,i,50);
%     score1(i) = visqol(st_n,s,fs);
% end
% [max_value, max_index] = max(score1);
% figure
% plot(score1)
% title("The ViSQOL score for different N")
% xlabel("N")
% ylabel("ViSQOL score")
% 
% %% Bonus 2: cutf (large scale)(abandoned)
% % So far, the best cutf is 174 for N=48?
% N_2 = 100;
% score2=zeros(1,N_2);
% n=linspace(1,1000,100);
% for i=1:N_2
%     [st_n,sw_n]=mel_vocoder(s,fs,48,i*10);
%     score2(i) = visqol(st_n,s,fs);
% end
% figure
% plot(n,score2)
% title("The ViSQOL score for different cutf")
% xlabel("cutf")
% ylabel("ViSQOL score")
% 
% %% Bonus 2: cutf (specify)(abandoned)
% 
% N_3=20;
% score3=zeros(1,N_3);
% n=171:190;
% for i=1:N_3
%     [st_n,sw_n]=mel_vocoder(s,fs,48,i+170);
%     score3(i) = visqol(st_n,s,fs);
% end
% figure
% plot(n,score3)
% title("The ViSQOL score for different cutf")
% xlabel("cutf")
% ylabel("ViSQOL score")


%% 2D Parameter Search: Comparing STOI and ViSQOL

% 1. 参数设置
step = 5;
N_range = 1:step:100;           % 通道数 N (步长设大一点以节省时间)
cutf_range = 50:10*step:1000;     % 截止频率 cutf (Hz)

len_N = length(N_range);
len_cutf = length(cutf_range);

% 2. 初始化两个矩阵
score_visqol = zeros(len_N, len_cutf); % 存 ViSQOL 分数
score_stoi = zeros(len_N, len_cutf);   % 存 STOI 分数

% 初始化进度条
h = waitbar(0, '正在计算 STOI 和 ViSQOL...');
total_steps = len_N * len_cutf;
count = 0;

% 3. 双重循环
for i = 1:len_N
    for j = 1:len_cutf
        current_N = N_range(i);
        current_cutf = cutf_range(j);
        
        % 运行 Vocoder (生成测试信号)
        [st_n, sw_n] = mel_vocoder(s, fs, current_N, current_cutf);
        
        % --- 计算 ViSQOL (质量) ---
        % 注意：visqol 可能需要一些时间
        score_visqol(i, j) = visqol(st_n, s, fs);
        
        % --- 计算 STOI (可懂度) ---
        % 用法: d = stoi(clean, degraded, fs_signal)
        % 必须确保 s 和 st_n 长度完全一致
        score_stoi(i, j) = stoi(s, st_n, fs);
        
        % 更新进度
        count = count + 1;
        waitbar(count / total_steps, h, sprintf('Progress: %.1f%%', (count/total_steps)*100));
    end
end
close(h);

% 4. 可视化对比
figure('Position', [100, 100, 1000, 400]); % 创建一个宽一点的窗口

% 准备网格
[X_cutf, Y_N] = meshgrid(cutf_range, N_range);

% 子图 1: ViSQOL (质量)
subplot(1, 2, 1);
surf(X_cutf, Y_N, score_visqol);
shading interp;
colorbar;
title('ViSQOL (Quality)');
xlabel('Cutoff Freq (Hz)'); ylabel('Channels (N)');
zlabel('Score (MOS)');
view(45, 30);

% 子图 2: STOI (可懂度)
subplot(1, 2, 2);
surf(X_cutf, Y_N, score_stoi);
shading interp;
colorbar;
title('STOI (Intelligibility)');
xlabel('Cutoff Freq (Hz)'); ylabel('Channels (N)');
zlabel('Score (0-1)');
view(45, 30);

% 5. 寻找 ViSQOL/STOI 的最佳点
[max_score, max_linear_idx] = max(score_visqol(:));
[best_row, best_col] = ind2sub(size(score_visqol), max_linear_idx);
best_N = N_range(best_row);
best_cutf = cutf_range(best_col);
fprintf('搜索完成！\n');
fprintf('最高 ViSQOL 分数: %.4f\n', max_score);
fprintf('最佳参数组合: N = %d, cutf = %d\n', best_N, best_cutf);
[max_stoi, idx] = max(score_stoi(:));
[r, c] = ind2sub(size(score_stoi), idx);
fprintf('最佳 STOI 分数: %.4f (N=%d, cutf=%d)\n', ...
    max_stoi, N_range(r), cutf_range(c));

%%
% %% Bonus 3: nLP
% N_4 = 10;
% score4=zeros(1,N_4);
% for i=1:N_4
%     [st_n,sw_n]=mel_vocoder(s,fs,48,174,4,i);
%     score4(i) = visqol(st_n,s,fs);
% end
% figure
% plot(score4)
% title("The ViSQOL score for different cutf")
% xlabel("Order of Lowpass filter")
% ylabel("ViSQOL score")
% 
% %% Bonus 4：nBP
% N_5 = 5;
% score5=zeros(1,N_5);
% for i=1:N_5
%     [st_n,sw_n]=mel_vocoder(s,fs,48,174,i,9);
%     score5(i) = visqol(st_n,s,fs);
% end
% figure
% plot(score5)
% title("The ViSQOL score for different cutf")
% xlabel("Order of Lowpass filter")
% ylabel("ViSQOL score")

%%
% %% Mel (abandoned)
% [st_b,sw_b]=mel_vocoder(s,fs,49,610,4,4);
% audiowrite("111.wav",st_b,fs)
% [mel_original, f] = melSpectrogram(s, fs, 'Window', hamming(512), 'OverlapLength', 256);
% [mel_processed, ~] = melSpectrogram(st_b, fs, 'Window', hamming(512), 'OverlapLength', 256);
% 
% figure;
% % 原始信号梅尔频谱
% subplot(4,1,1);
% imagesc(s);
% set(gca, 'YDir', 'normal');
% xlabel('时间帧');
% ylabel('梅尔频率 bin');
% title('原始信号的梅尔频谱图');
% xlim([0,50000])
% %colorbar;
% 
% % 处理后信号梅尔频谱
% subplot(4,1,2);
% imagesc(st_b);
% set(gca, 'YDir', 'normal');
% xlabel('时间帧');
% ylabel('梅尔频率 bin');
% title('处理后信号的梅尔频谱图');
% xlim([0,50000])
% %colorbar;
% 
% subplot(4,1,3);
% plot(abs(sw))
% %xlim([0,50000])
% %ylim([-0.3,0.3])
% 
% subplot(4,1,4);
% plot(abs(sw_b))
% %xlim([0,50000])
% %ylim([-0.3,0.3])

%% STFT clean
% 设置 STFT 参数
win = hamming(512); % 窗函数
noverlap = 256; % 重叠长度
nfft = 1024; % FFT 点数

[st_v,sw_v]=mel_vocoder(s,fs,best_N,best_cutf,4,4);
[st_s,sw_s]=mel_vocoder(s,fs,N_range(r),cutf_range(c),4,4);

figure;
% 原始信号 STFT
subplot(3,1,1);
spectrogram(s, win, noverlap, nfft, fs, 'yaxis');
ylabel("freq (kHz)")
xlabel("time (s)")
title('STFT Spectrogram of the original signal');

% 处理后信号 STFT
subplot(3,1,2);
spectrogram(st_v, win, noverlap, nfft, fs, 'yaxis');
title('STFT Spectrogram of the ViSQOL best signal');
ylabel("freq (kHz)")
xlabel("time (s)")
subplot(3,1,3);
spectrogram(st_s, win, noverlap, nfft, fs, 'yaxis');
title('STFT Spectrogram of the STOI best signal');
ylabel("freq (kHz)")
xlabel("time (s)")
audiowrite("ViSQOL_best_mel.wav",st_v,fs)
audiowrite("STOI_best_mel.wav",st_s,fs)

%% STFT noisy
% 2D Parameter Search: Comparing STOI and ViSQOL

% 1. 参数设置
step = 5;
N_range = 1:step:100;           % 通道数 N (步长设大一点以节省时间)
cutf_range = 50:10*step:1000;     % 截止频率 cutf (Hz)

len_N = length(N_range);
len_cutf = length(cutf_range);

% 2. 初始化两个矩阵
score_visqol = zeros(len_N, len_cutf); % 存 ViSQOL 分数
score_stoi = zeros(len_N, len_cutf);   % 存 STOI 分数

% 初始化进度条
h = waitbar(0, '正在计算 STOI 和 ViSQOL...');
total_steps = len_N * len_cutf;
count = 0;

% 3. 双重循环
for i = 1:len_N
    for j = 1:len_cutf
        current_N = N_range(i);
        current_cutf = cutf_range(j);
        
        % 运行 Vocoder (生成测试信号)
        [st_n, sw_n] = mel_vocoder(s_noisy, fs, current_N, current_cutf);
        
        % --- 计算 ViSQOL (质量) ---
        % 注意：visqol 可能需要一些时间
        score_visqol(i, j) = visqol(st_n, s, fs);
        
        % --- 计算 STOI (可懂度) ---
        % 用法: d = stoi(clean, degraded, fs_signal)
        % 必须确保 s 和 st_n 长度完全一致
        score_stoi(i, j) = stoi(st_n, s, fs);
        
        % 更新进度
        count = count + 1;
        waitbar(count / total_steps, h, sprintf('Progress: %.1f%%', (count/total_steps)*100));
    end
end
close(h);

% 4. 可视化对比
figure('Position', [100, 100, 1000, 400]); % 创建一个宽一点的窗口

% 准备网格
[X_cutf, Y_N] = meshgrid(cutf_range, N_range);

% 子图 1: ViSQOL (质量)
subplot(1, 2, 1);
surf(X_cutf, Y_N, score_visqol);
shading interp;
colorbar;
title('ViSQOL (Quality)');
xlabel('Cutoff Freq (Hz)'); ylabel('Channels (N)');
zlabel('Score (MOS)');
view(45, 30);

% 子图 2: STOI (可懂度)
subplot(1, 2, 2);
surf(X_cutf, Y_N, score_stoi);
shading interp;
colorbar;
title('STOI (Intelligibility)');
xlabel('Cutoff Freq (Hz)'); ylabel('Channels (N)');
zlabel('Score (0-1)');
view(45, 30);

% 5. 寻找 ViSQOL/STOI 的最佳点
[max_score, max_linear_idx] = max(score_visqol(:));
[best_row, best_col] = ind2sub(size(score_visqol), max_linear_idx);
best_N = N_range(best_row);
best_cutf = cutf_range(best_col);
fprintf('搜索完成！\n');
fprintf('最高 ViSQOL 分数: %.4f\n', max_score);
fprintf('最佳参数组合: N = %d, cutf = %d\n', best_N, best_cutf);
[max_stoi, idx] = max(score_stoi(:));
[r, c] = ind2sub(size(score_stoi), idx);
fprintf('最佳 STOI 分数: %.4f (N=%d, cutf=%d)\n', ...
    max_stoi, N_range(r), cutf_range(c));

%% 
[st_v,sw_v]=mel_vocoder(s_noisy,fs,best_N,best_cutf,4,4);
[st_s,sw_s]=mel_vocoder(s_noisy,fs,N_range(r),cutf_range(c),4,4);

figure;
% 原始信号 STFT
subplot(4,1,1);
spectrogram(s, win, noverlap, nfft, fs, 'yaxis');
title('原始信号的 STFT 热力图');
subplot(4,1,2);
spectrogram(s_noisy, win, noverlap, nfft, fs, 'yaxis');
title('带噪声信号的 STFT 热力图');

% 处理后信号 STFT
subplot(4,1,3);
spectrogram(st_v, win, noverlap, nfft, fs, 'yaxis');
title('ViSQOL最佳信号的 STFT 热力图');
subplot(4,1,4);
spectrogram(st_s, win, noverlap, nfft, fs, 'yaxis');
title('STOI最佳信号的 STFT 热力图');
audiowrite("ViSQOL_best_noisy_mel.wav",st_v,fs)
audiowrite("STOI_best_noisy_mel.wav",st_s,fs)