sampling_frequency = 19000; % 19 kHz
duration = 20; % 20 seconds
bits_per_sample = 8; % 8 bits per sample
snr_db = 15; % Desired SNR in dB

noisy_audio = recordVoice(sampling_frequency, duration, bits_per_sample, snr_db);

LPfilter(noisy_audio, 7e3, 'c');