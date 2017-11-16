%% Generate test data.
fs = 22050;
% t = [1/fs:1/fs:60] * 2*pi;
% raw_data = sin(100*t) + sin(300*t) + sin(500*t);
data_1 = 'test_signal_1-three_sinusoids.mat';
data_2 = 'test_signal_2-artificial_heartbeat.mat';
data_3 = 'test_signal_3-real_doppler.mat';
% save(data_1,'raw_data');

% Set figures to maximise on my left screen. Change to taste.
set(0,'DefaultFigurePosition',[134 1 1787 1005])

plot_params = struct(  ...
    'PlotP',true,     ...
    'XLim',[0 10000],  ...
    'YLim',[-5 5]      ...
    )


%%Vector 4

load(data_1);
Offline_EMD(raw_data(1:10000));

config = EMD_Default_Config();
EMD_Test('test',data_1,10000,1,config,'/home/lws/tmp/test4/file1/',plot_params);

plot_params = struct(  ...
    'PlotP',true,     ...
    'XLim',[0 fs*10],  ...
    'YLim',[-5 5]      ...
    )


load(data_2);
Offline_EMD(raw_data(1:fs*10));

config = EMD_Default_Config();
EMD_Test('test',data_2,fs*10,1,config,'/home/lws/tmp/test4/file1/',plot_params);

load(data_3);
Offline_EMD(raw_data(1:10000));

config = EMD_Default_Config();
EMD_Test('test',data_3,fs*10,1,config,'/home/lws/tmp/test4/file1/',plot_params);

%% Runtime evaluation. Run for 1 second input, 2 second input, 3 second input,
%% etc.
% num_runs = 3;
% 
% hermite_config = EMD_Default_Config();
% hermite_config('IMF:SIFT_BLOCK:ENVELOPE_INTERPOLATION_METHOD') = 'Hermite';
% runtimes_hermite = {};
% 
% 
% pchip_config = EMD_Default_Config();
% pchip_config('IMF:SIFT_BLOCK:ENVELOPE_INTERPOLATION_METHOD') = 'PCHIP';
% runtimes_pchip = {};
% 
% spline_config = EMD_Default_Config();
% spline_config('IMF:SIFT_BLOCK:ENVELOPE_INTERPOLATION_METHOD') = 'Cubic';
% runtimes_spline = {};
% 
% for usetime = [1:10 15:5:50 60:10:100]
%     runtimes_hermite{end+1} = EMD_Test(...
%         'Basic test', ...
%         data_filename, ...
%         usetime*fs, ...
%         num_runs, ...
%         hermite_config, ...
%         sprintf('/home/lws/tmp/EMD_Basic_Testing/Hermite/%3i_seconds/',usetime), ...
%         plot_params...
%     );
%     
%     runtimes_pchip{end+1} = EMD_Test(...
%         'Basic test', ...
%         data_filename, ...
%         usetime*fs, ...
%         num_runs, ...
%         pchip_config, ...
%         sprintf('/home/lws/tmp/EMD_Basic_Testing/PCHIP/%3i_seconds/',usetime), ...
%         plot_params...
%     );
%     
%     runtimes_spline{end+1} = EMD_Test(...
%         'Basic test', ...
%         data_filename, ...
%         usetime*fs, ...
%         num_runs, ...
%         spline_config, ...
%         sprintf('/home/lws/tmp/EMD_Basic_Testing/Cubic/%3i_seconds/',usetime), ...
%         plot_params...
%     );
% end

%% Vector 1 : vary run time and signals.
%{
num_runs = 1;
config = EMD_Default_Config();
config('IMF:SIFT_BLOCK:ENVELOPE_INTERPOLATION_METHOD') = 'PCHIP';

runtimes_v1=[];

for signal_length = [1:10 15:5:30]
    runtimes_v1(1,signal_length) = EMD_Test(...
        sprintf('Input signal: #1 (simple). signal length %i.', signal_length ),...
        data_1, ... %CHANGE THIS, FOOL
        signal_length*fs, ...
        num_runs, ...
        config, ...
        sprintf('/home/lws/tmp/EMD_Testing/Vector1/Signal_1-%3i_seconds/',signal_length), ...
        plot_params...
        );

    runtimes_v1(2,signal_length) = EMD_Test(...
        sprintf('Input signal: #2 (artifical heartbeats.). signal length %i.', signal_length ),...
        data_2, ... %CHANGE THIS, FOOL
        signal_length*fs, ...
        num_runs, ...
        config, ...
        sprintf('/home/lws/tmp/EMD_Testing/Vector1/Signal_2-%3i_seconds/',signal_length), ...
        plot_params...
        );

    runtimes_v1(3,signal_length) = EMD_Test(...
        sprintf('Input signal: #3 (real doppler.). signal length %i.', signal_length ),...
        data_3, ... %CHANGE THIS, FOOL
        signal_length*fs, ...
        num_runs, ...
        config, ...
        sprintf('/home/lws/tmp/EMD_Testing/Vector1/Signal_3-%3i_seconds/',signal_length), ...
        plot_params...
        );
end
%}

%% Vector 2 : Vary number of IMFs extracted.
%{
num_runs = 1;
config = EMD_Default_Config();

runtimes_v2 = [];
for num_imfs = [2 4 6]
    config('EMD:NUMBER_OF_IMFS') = num_imfs;
    runtimes_v2(1,num_imfs) = EMD_Test(...
        sprintf('Input signal: #1 (simple). extracting %i IMFs from signal length %i.', num_imfs, signal_length ),...
        data_1, ... %CHANGE THIS, FOOL
        signal_length*fs, ...
        num_runs, ...
        config, ...
        sprintf('/home/lws/tmp/EMD_Testing/Vector2/Signal_1-%i_imfs-%3i_seconds/',num_imfs, signal_length), ...
        plot_params...
        );
    
        runtimes_v2(2,num_imfs) = EMD_Test(...
        sprintf('Input signal: #1 (artifical heartbeats.). extracting %i IMFs from signal length %i.', num_imfs, signal_length ),...
        data_2, ... %CHANGE THIS, FOOL
        signal_length*fs, ...
        num_runs, ...
        config, ...
        sprintf('/home/lws/tmp/EMD_Testing/Vector2/Signal_2-%i_imfs-%3i_seconds/',num_imfs, signal_length), ...
        plot_params...
        );
    
        runtimes_v2(3,num_imfs) = EMD_Test(...
        sprintf('Input signal: #3 (real doppler.). extracting %i IMFs from signal length %i.', num_imfs, signal_length ),...
        data_3, ... %CHANGE THIS, FOOL
        signal_length*fs, ...
        num_runs, ...
        config, ...
        sprintf('/home/lws/tmp/EMD_Testing/Vector2/Signal_3-%i_imfs-%3i_seconds/',num_imfs, signal_length), ...
        plot_params...
        );
end
%}
% 
% % Vector 3 : Vary the number of sifting iterations.
% num_runs = 1;
% config = EMD_Default_Config();
% signal_length = 10;
% num_imfs = 5
% runtimes_v3 = [];
% for sifting_iterations = [2 4 6 8 10]
%     config('IMF:SIFT_BLOCK:NUM_SIFTING_ITERATIONS') = sifting_iterations;
%     runtimes_v3(1,sifting_iterations) = EMD_Test(...
%         sprintf('Input signal: #1 (simple). extracting %i IMFs from signal length %i using %i sifting iterations.', num_imfs, signal_length, sifting_iterations ),...
%         data_1, ... %CHANGE THIS, FOOL
%         signal_length*fs, ...
%         num_runs, ...
%         config, ...
%         sprintf('/home/lws/tmp/EMD_Testing/Vector3/Signal_1-%i_sifting_iters/',sifting_iterations), ...
%         plot_params...
%         );
%     
%         runtimes_v3(2,sifting_iterations) = EMD_Test(...
%         sprintf('Input signal: #1 (artifical heartbeats.). extracting %i IMFs from signal length %i using %i sifting iterations.', num_imfs, signal_length, sifting_iterations ),...
%         data_2, ... %CHANGE THIS, FOOL
%         signal_length*fs, ...
%         num_runs, ...
%         config, ...
%         sprintf('/home/lws/tmp/EMD_Testing/Vector3/Signal_2-%i_sifting_iters/',sifting_iterations), ...
%         plot_params...
%         );
%     
%         runtimes_v3(3,sifting_iterations) = EMD_Test(...
%         sprintf('Input signal: #3 (real doppler.). extracting %i IMFs from signal length %i using %i sifting iterations.', num_imfs, signal_length, sifting_iterations ),...
%         data_3, ... %CHANGE THIS, FOOL
%         signal_length*fs, ...
%         num_runs, ...
%         config, ...
%         sprintf('/home/lws/tmp/EMD_Testing/Vector3/Signal_3-%i_sifting_iters/',sifting_iterations), ...
%         plot_params...
%         );
% 
% end
