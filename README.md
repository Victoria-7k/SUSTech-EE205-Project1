# SUSTech-EE205-Project1

这是SUSTech EE205 信号和系统 project 1 人工耳蜗的参考程序。
本项目旨在通过 MATLAB 模拟人工耳蜗的信号处理机制，主要实现了基于不同策略的声音合成。
This is the reference code for SUSTech EE205 Signals and Systems Project 1: Artificial Cochlea.
This project aims to simulate the signal processing mechanism of the artificial cochlea using MATLAB, primarily implementing sound synthesis based on different strategies.

**严禁抄袭 仅供参考 请勿直接用于提交作业**
**STRICTLY PROHIBITED: NO PLAGIARISM. This code is for reference only. DO NOT use directly for assignment submission.**

## 1. 项目简介 Project Overview
本项目实现了声码器的基本功能，模拟了声音信号在耳蜗中的频率分解与重构过程。主要包含以下两种实现方式：
* **Tone Vocoder**: 使用正弦波作为载波合成声音。
* **Mel Vocoder**: 基于 Mel 频率刻度进行分段和合成 (通常涉及噪声激励或特定的包络提取)。
This project implements the basic functions of a vocoder, simulating the process of frequency decomposition and reconstruction of sound signals in the cochlea. It mainly includes the following two implementations:
* **Tone Vocoder**: Synthesizes sound using sine waves as carriers.
* **Mel Vocoder**：Segments and synthesizes sound based on the Mel frequency scale.

### 核心功能函数 Core Functions
* `tone_vocoder.m`: **主函数**。实现了基于正弦波的声音频率分段与合成。
* `mel_vocoder.m`: 实现了基于 Mel 频谱的声音处理与合成。
* `new_vocoder.m`: (可选) 改进或测试用的新版 Vocoder 实现。
* `ssn_generator.m`: 生成言语形状噪声 (Speech Shaped Noise,SSN)，通常用于噪声激励的 Vocoder。
* `tone_vocoder.m`: Main Function. Implements sound frequency segmentation and synthesis based on sine waves.
* `mel_vocoder.m`: Implements sound processing and synthesis based on the Mel spectrum.
* `new_vocoder.m`: New version of vocoder implementation for improvement or testing purposes.
* `ssn_generator.m`: Generates Speech Shaped Noise (SSN), typically used for noise-excited vocoders.

### 映射与转换工具 Mapping Utilities
用于在频率（Hz）、Mel 刻度与耳蜗位置之间进行转换：
* `f2mmap.m` / `m2fmap.m`: 实现频率与 Mel 刻度之间的相互转换。
* `f2dmap.m` / `d2fmap.m`: 实现频率与耳蜗基底膜距离之间的相互转换 (通常基于 Greenwood 函数)。
Used for converting between frequency (Hz), Mel scale, and cochlear position:
* `f2mmap.m` / `m2fmap.m`: Implements mutual conversion between frequency and Mel scale.
* `f2dmap.m` / `d2fmap.m`: Implements mutual conversion between frequency and cochlear basilar membrane distance (usually based on the Greenwood function).

### 运行脚本 Runners & Scripts
* `proj1.m`: 项目的总入口脚本，用于演示基本功能。
* `proj1_mel.m`: 专门用于演示 Mel Vocoder 的脚本。
* `proj1_song.m`: 用于处理长音频（如歌曲）的演示脚本。
* `draw.m`: 绘图工具脚本，用于生成频谱图或波形对比图。
* `proj1.m`: General entry script for the project, used to demonstrate basic functions.
* `proj1_mel.m`: Script specifically designed to demonstrate the Mel Vocoder.
* `proj1_song.m`: Demo script used for processing long audio files (e.g., songs).
* `draw.m`: Plotting tool script used to generate spectrograms or waveform comparison plots.

### 数据文件Data
* `C_01_01.wav`: 测试语音文件。
* `song.wav`: 测试歌曲文件（Attention by NewJeans）。
* `C_01_01.wav`: Test speech file.
* `song.wav`: Test song file (Attention by NewJeans).

## 3. 使用方法Usage

### 环境要求Requirements
* 所需环境 :
    - MATLAB 版本: (R2025b) 25.2
    - OS: MACA64
* 所需工具箱: Signal Processing Toolbox (v25.2), Audio Toolbox (v25.2)
* Environment Requirements :
    - MATLAB version: (R2025b) 25.2
    - OS: MACA64
* Required Tooloxes: Signal Processing Toolbox (v25.2), Audio Toolbox (v25.2)

### 运行示例Running Examples
在 MATLAB 命令窗口中运行主脚本即可看到结果和波形图：
Run the main script in the MATLAB command window to see the results and waveform plots:
```matlab
% main
proj1

% Mel Vocoder
proj1_mel
`---`
