function noisy_audio = recordVoice(sampling_frequency, duration, bits_per_sample, snr_db)
    % Create an audiorecorder object with the specified parameters
    recorder = audiorecorder(sampling_frequency, bits_per_sample, 1); % Mono recording

    % Start recording
    disp('Recording started. Please speak into the microphone.');
    recordblocking(recorder, duration);
    disp('Recording stopped.');

    % Retrieve the recorded audio data
    recorded_audio = getaudiodata(recorder);

    % Calculate the signal power per sample (linear)
    % signal_power_linear = mean(recorded_audio.^2);
    
    signal_power_linear = sum(abs(recorded_audio).^2/length(recorded_audio));

    % Calculate the signal power per sample (dB)
    signal_power_db = 10 * log10(signal_power_linear);

    % Add AWGN with a specified SNR
    noisy_audio = awgn(recorded_audio, snr_db, signal_power_db);

    nPow = sum(abs(noisy_audio).^2/length(noisy_audio));

    % Save the original recorded audio to a WAV file
    audiowrite('recorded_audio.wav', recorded_audio, sampling_frequency);

    % Save the noisy audio to a WAV file
    audiowrite('noisy_audio.wav', noisy_audio, sampling_frequency);

    % Display the signal power per sample in dB
    disp(['Signal power per sample (dB): ', num2str(signal_power_db)]);
end