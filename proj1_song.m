
clear

%% task 1
[s,fs] = audioread("song.wav");
% 分离左右声道
left_channel = s(:, 1);
right_channel = s(:, 2);
% 合并两个声道为一个单声道
mono_channel = (left_channel + right_channel) / 2;
% 将单声道音频写入新的文件
audiowrite('mono_song.wav', mono_channel, fs);

[s,fs] = audioread("mono_song.wav");
s=s';
s=resample(s,16000,48000);
fs=fs/3;
sw = fftshift(fft(s));
t=(1:length(s))/fs;
w=linspace(-fs/2,fs/2,length(s));
[st1,sw1] = tone_vocoder(s,fs,1,50);
[st2,sw2] = tone_vocoder(s,fs,2,50);
[st3,sw3] = tone_vocoder(s,fs,4,50);
[st4,sw4] = tone_vocoder(s,fs,6,50);
[st5,sw5] = tone_vocoder(s,fs,8,50);
figure("Name","Task1")

subplot(621)
plot(t,s)
xlabel("Time(s)")
ylabel("Amplitude")
title("Original signal (time domain)")
xlim([0 5])
ylim([-2 2])

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
xlim([0 5])
ylim([-2 2])

subplot(624)
plot(w,abs(sw1))
xlabel("frequency(Hz)")
ylabel("Magnitude")
title("N=1 (frequency(Hz) domain)")

subplot(625)
plot(t,st2)
xlabel("Time(s)")
ylabel("Amplitude")
title("N=2 (time domain)")
xlim([0 5])
ylim([-2 2])

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
xlim([0 5])
ylim([-2 2])

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
xlim([0 5])
ylim([-2 2])

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
xlim([0 5])
ylim([-2 2])

subplot(6,2,12)
plot(w,abs(sw5))
xlabel("frequency(Hz)")
ylabel("Magnitude")
title("N=8 (frequency(Hz) domain)")

%% task 2
[st6,sw6] = tone_vocoder(s,fs,4,20);
[st7,sw7] = tone_vocoder(s,fs,4,50);
[st8,sw8] = tone_vocoder(s,fs,4,100);
[st9,sw9] = tone_vocoder(s,fs,4,400);
%[st10,sw10] = tone_vocoder(s,fs,4,800);
% TODO

figure("Name","Task2")

subplot(521)
plot(t,s)
xlabel("Time(s)")
ylabel("Amplitude")
title("Original signal (time domain)")
xlim([0 5])
ylim([-2 2])

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
xlim([0 5])
ylim([-2 2])

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
xlim([0 5])
ylim([-2 2])

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
xlim([0 5])
ylim([-2 2])

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
xlim([0 5])
ylim([-2 2])

subplot(5,2,10)
plot(w,abs(sw9))
xlabel("frequency(Hz)")
ylabel("Magnitude")
title("cutf=400Hz (frequency(Hz) domain)")

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
        [st_n, sw_n] = tone_vocoder(s, fs, current_N, current_cutf);
        
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
% 设置 STFT 参数
win = hamming(512); % 窗函数
noverlap = 256; % 重叠长度
nfft = 1024; % FFT 点数
[st_v,sw_v]=new_vocoder(s,fs,best_N,best_cutf,4,4);
[st_s,sw_s]=new_vocoder(s,fs,N_range(r),cutf_range(c),4,4);

figure;
% 原始信号 STFT
subplot(3,1,1);
spectrogram(s, win, noverlap, nfft, fs, 'yaxis');
title('STFT spectrogram of the original signal');

% 处理后信号 STFT
subplot(3,1,2);
spectrogram(st_v, win, noverlap, nfft, fs, 'yaxis');
title('ViSQOL最佳信号的 STFT 热力图');
subplot(3,1,3);
spectrogram(st_s, win, noverlap, nfft, fs, 'yaxis');
title('STOI最佳信号的 STFT 热力图');
audiowrite("ViSQOL_best_song.wav",st_v,fs)
audiowrite("STOI_best_song.wav",st_s,fs)