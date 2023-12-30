function hh = dtmfdesign(fb, L, fs)

    % Initialize the matrix to hold the impulse responses
    hh = zeros(L, length(fb));
    
    % Design each filter
    for i = 1:length(fb)

        % Time index n
        n = 0:(L-1); 

        % Unnormalized coefficients for a cosine filter
        h = cos(2*pi*fb(i)*n/fs);

        % Take the FFT to get the frequency response
        H = fft(h);

        % Find the maximum magnitude of the frequency response
        maxH = max(abs(H));

        % Normalize the filter gain so that the peak is 1
        beta = 1/maxH;

        % Store the normalized impulse response
        hh(:,i) = beta * h;
    end
end