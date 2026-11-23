
clear;
close all;
clc;

%% Original 7 kHz Signal

fs_original = 48000;
signal_frequency = 7000;
duration = 2;
amplitude = 0.20;

t = 0:1/fs_original:duration-1/fs_original;
x = amplitude * sin(2*pi*signal_frequency*t);

%% Listen to Original Signal

disp('Playing original 7 kHz signal...');
sound(x, fs_original);
pause(duration + 1);

%% Sampling Frequency Tests

sampling_frequencies = [24000 16000 12000 8000];

% Results table
results = zeros(length(sampling_frequencies), 4);

for k = 1:length(sampling_frequencies)

    fs_low = sampling_frequencies(k);

    %% Downsample without anti-aliasing filter

    M = fs_original / fs_low;

    if mod(M,1) ~= 0
        error('Invalid sampling frequency.');
    end

    x_alias = x(1:M:end);

    nyquist_frequency = fs_low / 2;

    %% Calculate observed alias frequency

    observed_frequency = abs(mod(signal_frequency + fs_low/2, ...
        fs_low) - fs_low/2);

    if signal_frequency > nyquist_frequency
        aliasing = 1;
        aliasing_text = 'YES';
    else
        aliasing = 0;
        aliasing_text = 'NO';
    end

    %% Display results

    fprintf('\nSampling frequency: %.0f Hz\n', fs_low);
    fprintf('Nyquist frequency: %.0f Hz\n', nyquist_frequency);
    fprintf('Observed peak: %.0f Hz\n', observed_frequency);
    fprintf('Aliasing: %s\n', aliasing_text);

    results(k,:) = [fs_low, nyquist_frequency, ...
        observed_frequency, aliasing];

    %% Listen to downsampled signal

    fprintf('Playing signal sampled at %.0f Hz...\n', fs_low);
    sound(x_alias, fs_low);
    pause(duration + 1);

    %% Plot frequency spectra

    figure('Color','white');

    subplot(2,1,1);

    periodogram(x, [], [], fs_original/1000);

    xlim([0 10]);

    xline(7, '--r', 'Original: 7 kHz', ...
        'LineWidth', 1.5);

    title('Original Signal: 7 kHz');
    xlabel('Frequency (kHz)');
    ylabel('Power/Frequency');
    grid on;

    subplot(2,1,2);

    periodogram(x_alias, [], [], fs_low/1000);

    xlim([0 fs_low/2000]);

    title(['After Downsampling: ', ...
        num2str(fs_low/1000), ' kHz']);

    xlabel('Frequency (kHz)');
    ylabel('Power/Frequency');
    grid on;

    %% Save figure

    filename = ['spectrum_', ...
        num2str(fs_low/1000), 'kHz.png'];

    saveas(gcf, filename);

end

%% Final Results Table

fprintf('\n\nFINAL RESULTS TABLE\n');
fprintf('Sampling (Hz) | Nyquist (Hz) | Peak (Hz) | Aliasing\n');

for k = 1:size(results,1)

    if results(k,4) == 1
        answer = 'YES';
    else
        answer = 'NO';
    end

    fprintf('%12.0f | %12.0f | %9.0f | %s\n', ...
        results(k,1), results(k,2), ...
        results(k,3), answer);
end

fprintf('\nAll four spectrum figures have been saved.\n');
