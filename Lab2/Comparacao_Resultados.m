%% 1. Configurações Globais
fs = 10e6;              % Freq. de amostragem (10MHz para captar harmônicas de 1MHz)
T = 1/fs;               
L = 10^5;               % Resolução espectral
t = (0:L-1)*T;          
f0 = 100e3;             % Fundamental de 100 kHz 
Amp = 0.1;              % Amplitude de 0.1 Vp 

%% 2. Geração dos Sinais
% Onda Senoidal 
sig{1} = Amp * sin(2*pi*f0*t); 
titles{1} = 'Espectro - Onda Senoidal';

% Onda Quadrada 
sig{2} = Amp * square(2*pi*f0*t); 
titles{2} = 'Espectro - Onda Quadrada';

% Onda Triangular
sig{3} = Amp * sawtooth(2*pi*f0*t, 0.5); 
titles{3} = 'Espectro - Onda Triangular';

% Pulso (Duty Cycle 10%)
sig{4} = Amp * (square(2*pi*f0*t, 10) + 1)/2; 
titles{4} = 'Espectro - Pulso (10% Duty Cycle)';

%% 3. Processamento e Plotagem
figure('Name', 'Análise de Espectro - Experiência 1');

for i = 1:4
    % Cálculo da FFT
    Y = fft(sig{i});
    P2 = abs(Y/L);
    P1 = P2(1:L/2+1);
    P1(2:end-1) = 2*P1(2:end-1);
    f = fs*(0:(L/2))/L;
    
    % Plotagem (Foco até 1 MHz conforme o roteiro)
    subplot(2, 2, i);
    plot(f/1e3, P1, 'LineWidth', 1.5); 
    title(titles{i});
    xlabel('Frequência (kHz)');
    ylabel('Amplitude (V)');
    xlim([0 1000]); % Limite de 1 MHz [cite: 24, 29, 32]
    grid on;
end