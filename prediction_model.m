%% DRY-BULB TEMPERATURE PREDICTION MODEL GIVEN MAXIMUM & MINIMUM AVERAGE HOURLY DRY-BULB TEMPERATURE INPUT

%function receives the minimum and maximum average monthly dry-bulb temperature as input, outputs the daily hourly temperature distribution, 
% and generate a graph of the predicted hourly temperature distribution

function predicted_hourly_temp = min_max_model_Tdb(Tmin,Tmax)

    % MODEL HARMONICS COEFFICIENTS
    ao = 0.4534;
    an = [-0.3503 0.0940  0.0142 0.0202 0.0000 0.0000 0.0000 0.0000 0.0000 0.0000 0.0000 0.0000];
    bn = [-0.2923 0.0726 -0.0020 0.0053 0.0000 0.0000 0.0000 0.0000 0.0000 0.0000 0.0000 0.0000];
    
    %VARIABLE INITIALIZATION
    T = 24; %period of 24 hours
    N = 12; %12 harmonics
    time = 1:24; 
    sine_sum = 0;
    cosine_sum = 0;
    dt = zeros(1,24);
    range_ = Tmax-Tmin;
    
    % MODEL HARMONICS COMPUTATION
    for t=1:T
            for n=1:N
                sine_sum = sine_sum + an(n)*sin(n*pi*t/12);
                cosine_sum = cosine_sum + bn(n)*cos(n*pi*t/12);
            end
            dt(1,t) = ao + sine_sum + cosine_sum; %Create Model Harmonics 
            sine_sum = 0;
            cosine_sum = 0;
    end

    % MODEL REPRESENTATION & PREDICTIONS
    predicted_hourly_temp = (dt * range_) + Tmin;

    % GENERATE THE PLOT OF THE PREDICTED HOURLY TEMPERATURE
    figure;
    hold on;
    plot(time,predicted_hourly_temp, 'bs-', 'LineWidth',2,'MarkerSize',5);
    xlabel('Time of Day (Hours)');
    ylabel('Dry Bulb Temperature (°C)');
    title('PREDICTED HOURLY Tdb DISTRIBUTION', 'FontSize',12);
    grid on;
    

end

%% DRY-BULB TEMPERATURE PREDICTION MODEL GIVEN RAW MONTHLY DATA INPUT

%function receives raw monthly dry-bulb temperature data as input, computes the mean hourly temperature,
% outputs the daily hourly temperature distribution, and generate a graph of the predicted hourly temperature distribution

%input data should be of the form NxM matrix, where size of N equals the
%number of days in the month and M is the number of hours in a day (24)

function  predicted_hourly_temp= raw_monthly_input_model_Tdb(raw_monthly_data)

    % MODEL HARMONICS COEFFICIENTS
    ao = 0.4534;
    an = [-0.3503 0.0940  0.0142 0.0202 0.0000 0.0000 0.0000 0.0000 0.0000 0.0000 0.0000 0.0000];
    bn = [-0.2923 0.0726 -0.0020 0.0053 0.0000 0.0000 0.0000 0.0000 0.0000 0.0000 0.0000 0.0000];
    
    %DATA PROCESSING
    monthly_hourly_average = mean(raw_monthly_data,1);
    Tmin = min(monthly_hourly_average);
    range_ = range(monthly_hourly_average);

    disp("Size of matrix");
    disp(size(monthly_hourly_average))

    %VARIABLE INITIALIZATION
    T = 24; %period of 24 hours
    N = 12; %12 harmonics
    time = 1:24;
    sine_sum = 0;
    cosine_sum = 0;
    dt = zeros(1,24);
    
    % MODEL HARMONICS COMPUTATION
    for t=1:T
            for n=1:N
                sine_sum = sine_sum + an(n)*sin(n*pi*t/12);
                cosine_sum = cosine_sum + bn(n)*cos(n*pi*t/12);
            end
            dt(1,t) = ao + sine_sum + cosine_sum; %Create Model Harmonics 
            sine_sum = 0;
            cosine_sum = 0;
    end

    % MODEL REPRESENTATION & PREDICTIONS
    predicted_hourly_temp = (dt * range_) + Tmin;

    % GENERATE THE PLOT OF THE PREDICTED HOURLY TEMPERATURE
    figure;
    hold on;
    plot(time,predicted_hourly_temp, 'bs-', 'LineWidth',2,'MarkerSize',5);
    xlabel('Time of Day (Hours)');
    ylabel('Dry Bulb Temperature (°C)');
    title('PREDICTED HOURLY Tdb DISTRIBUTION', 'FontSize',12);
    grid on;

end


%% RELATIVE HUMIDITY PREDICTION MODEL GIVEN MAXIMUM & MINIMUM AVERAGE HOURLY RELATIVE HUMIDITY INPUT

%function receives the minimum and maximum average monthly relative humidity as input, outputs the daily relative humidity distribution 
% and generate a graph of the predicted hourly relative humidity distribution

function predicted_hourly_temp = min_max_model_RH(RHmin,RHmax)

    % MODEL HARMONICS COEFFICIENTS
    ao = 0.5472;
    an = [0.3529 -0.1009 -0.0202 0.0254 0.0000 0.0000 0.0000 0.0000 0.0000 0.0000 0.0000 0.0000];
    bn = [0.3004 -0.0761  0.0070 0.0036 0.0000 0.0000 0.0000 0.0000 0.0000 0.0000 0.0000 0.0000];
    
    %VARIABLE INITIALIZATION
    T = 24; %period of 24 hours
    N = 12; %12 harmonics
    time = 1:24; 
    sine_sum = 0;
    cosine_sum = 0;
    dt = zeros(1,24);
    range_ = RHmax-RHmin;
    
    % MODEL HARMONICS COMPUTATION
    for t=1:T
            for n=1:N
                sine_sum = sine_sum + an(n)*sin(n*pi*t/12);
                cosine_sum = cosine_sum + bn(n)*cos(n*pi*t/12);
            end
            dt(1,t) = ao + sine_sum + cosine_sum; %Create Model Harmonics 
            sine_sum = 0;
            cosine_sum = 0;
    end

    % MODEL REPRESENTATION & PREDICTIONS
    predicted_hourly_temp = (dt * range_) + Tmin;

     % GENERATE THE PLOT OF THE PREDICTED RELATIVE HUMIDITY
    figure;
    hold on;
    plot(time,predicted_hourly_RH, 'ro-', 'LineWidth',2,'MarkerSize',5);
    xlabel('Time of Day (Hours)');
    ylabel('Relative Humidity (%)');
    title('PREDICTED HOURLY RH DISTRIBUTION', 'FontSize',12);
    grid on;
    

end

%% RELATIVE HUMIDITY PREDICTION MODEL GIVEN RAW MONTHLY DATA INPUT

%function receives raw monthly relative humidity data as input, computes the mean hourly relative humidity,
% outputs the daily hourly relative humidity distribution, and generate a graph of the predicted hourly relative humidity distribution

%input data should be of the form NxM matrix, where size of N equals the
%number of days in the month and M is the number of hours in a day (24)

function  predicted_hourly_temp= raw_monthly_input_model_RH(raw_monthly_data)

    % MODEL HARMONICS COEFFICIENTS
    ao = 0.5472;
    an = [0.3529 -0.1009 -0.0202 0.0254 0.0000 0.0000 0.0000 0.0000 0.0000 0.0000 0.0000 0.0000];
    bn = [0.3004 -0.0761  0.0070 0.0036 0.0000 0.0000 0.0000 0.0000 0.0000 0.0000 0.0000 0.0000];
    
    %DATA PROCESSING
    monthly_hourly_average = mean(raw_monthly_data,1);
    Tmin = min(monthly_hourly_average);
    range_ = range(monthly_hourly_average);

    disp("Size of matrix");
    disp(size(monthly_hourly_average))

    %VARIABLE INITIALIZATION
    T = 24; %period of 24 hours
    N = 12; %12 harmonics
    time = 1:24;
    sine_sum = 0;
    cosine_sum = 0;
    dt = zeros(1,24);
    
    % MODEL HARMONICS COMPUTATION
    for t=1:T
            for n=1:N
                sine_sum = sine_sum + an(n)*sin(n*pi*t/12);
                cosine_sum = cosine_sum + bn(n)*cos(n*pi*t/12);
            end
            dt(1,t) = ao + sine_sum + cosine_sum; %Create Model Harmonics 
            sine_sum = 0;
            cosine_sum = 0;
    end

    % MODEL REPRESENTATION & PREDICTIONS
    predicted_hourly_RH = (dt * range_) + Tmin;

    % GENERATE THE PLOT OF THE PREDICTED RELATIVE HUMIDITY
    figure;
    hold on;
    plot(time,predicted_hourly_RH, 'ro-', 'LineWidth',2,'MarkerSize',5);
    xlabel('Time of Day (Hours)');
    ylabel('Relative Humidity (%)');
    title('PREDICTED HOURLY RH DISTRIBUTION', 'FontSize',12);
    grid on;

end