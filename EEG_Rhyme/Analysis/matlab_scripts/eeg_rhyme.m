clear
eeglab;
%% set up file and folders
% establish working directory 
maindir = '/Volumes/juschnei/lendlab/projects/EEG_Rhyme/data/rawdir/'; %folder that houses the data from the rhyme tasks (exposure, post-test1 and post-test2)
workdir = '/Volumes/juschnei/lendlab/projects/EEG_Rhyme/analysis/wkdir/'; 
txtdir = '/Volumes/juschnei/lendlab/projects/EEG_Rhyme/analysis/txtdir/';
erpdir = '/Volumes/juschnei/lendlab/projects/EEG_Rhyme/analysis/erpdir/';


% establish parameters

lowpass = 30;
highpass = 0.1;
epoch_baseline = -200.0; %epoch baseline
epoch_end = 800.0; %epoch offset

% establish subject list
[d,s,r] = xlsread ('subjects.xlsx');
subject_list = r;
numsubjects = (length(s));

for s=2:numsubjects %change number of subjects as needed
    
    subject = subject_list{s};

%% Preprocessing steps
% Step 1: load file, filter, referencing

    [ALLEEG, EEG, CURRENTSET, ALLCOM] = eeglab;
    eeglab('redraw');

    EEG = pop_loadbv (maindir, [subject '.vhdr'], [], []);
    [ALLEEG, EEG, CURRENTSET] = pop_newset(ALLEEG, EEG, 0,'setname',subject,'gui','off'); 
    EEG = eeg_checkset( EEG );

    EEG = pop_eegfilt ( EEG, highpass, lowpass, [], [0], 0, 0, 'fir1', 0);
    [ALLEEG, EEG, CURRENTSET] = pop_newset(ALLEEG, EEG, CURRENTSET,'setname',[subject '_fl'],'gui','off'); 
    EEG = eeg_checkset( EEG );

    EEG = pop_reref ( EEG, []);
    [ALLEEG, EEG, CURRENTSET] = pop_newset(ALLEEG, EEG, CURRENTSET,'setname',[subject '_fl_rr'],'gui','off'); 
    EEG = eeg_checkset( EEG );

    EEG = pop_saveset( EEG, [workdir subject '_fl_rr']);
end
%% Removing bad blocks and interpolating bad electrodes
% Step 2: Manually scroll through the data and interpolate bad
% channels/reject bad blocks. Save this as subject _clean.set in the
% working directory
% To scroll through data and remove bad blocks %{ EEGLAB >> Plot >> Channel data (scroll) %}
% To interpolate bad electrodes %{ EEGLAB >> Tools >> Interpolate electrodes >> Select from data channels %}
        % Note: we are interpolating electrodes sepherically
%% ICA
%Step 3: Run ICA

for s=1:numsubjects %change number of subjects as needed
    
    subject = subject_list{s};

    [ALLEEG, EEG, CURRENTSET, ALLCOM] = eeglab;
    eeglab('redraw');

EEG = pop_loadset ([subject '_clean.set'],workdir);
[ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );

EEG = pop_runica(EEG, 'icatype', 'runica', 'extended',1,'interrupt','on');
[ALLEEG, EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);

EEG = pop_saveset( EEG, [workdir subject '_ICA']);

end

%% Removing bad ICA Components with MARA
% Load ICA file
% Tools > IC Artifact Classification (MARA) > MARA Classification
% Select 'Plot and select components for removal' > Ok
% Review bad components and select which to remove (only remove those with
    % artifact likelihood of 70% or higher
% Record removed artifacts in participant database
% Tools > Remove components from data > Yes (Plot Single Trials)
% If plot single trials looks cleaner, click to 'Accept' the removal
% Save file as subjectID_ICA_clean.set

%% ERP Analysis

for s=4:numsubjects %change number of subjects as needed
    
    subject = subject_list{s};

     [ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
     eeglab('redraw');

% Create eventlist, apply binlist, extract epochs, and artifact rejection
EEG = pop_loadset('filename',[subject '_ICA_clean.set'],'filepath',workdir);
[ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );

EEG  = pop_creabasiceventlist( EEG , 'AlphanumericCleaning', 'on', 'BoundaryNumeric', { -99 }, 'BoundaryString', { 'boundary' }, 'Eventlist', [txtdir [subject '.txt']] ); 
EEG = eeg_checkset( EEG );
[ALLEEG, EEG, CURRENTSET] = pop_newset(ALLEEG, EEG, CURRENTSET,'gui','off'); 
    
EEG  = pop_binlister( EEG , 'BDF', [txtdir 'binlist.txt'], 'ExportEL', [txtdir [subject '_binlist.txt']],'ImportEL', [txtdir [subject '.txt']], 'IndexEL',  1, 'SendEL2', 'EEG&Text', 'Voutput', 'EEG' );
[ALLEEG, EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);
    
EEG = pop_epochbin( EEG , [epoch_baseline  epoch_end],  'pre'); 
[ALLEEG, EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);
    
EEG  = pop_artmwppth( EEG , 'Channel',  [], 'Flag',  1, 'Threshold',  100, 'Twindow', [epoch_baseline epoch_end], 'Windowsize',  200, 'Windowstep',  100 ); 
[ALLEEG, EEG, CURRENTSET] = pop_newset(ALLEEG, EEG, CURRENTSET ,'savenew',[workdir [subject '_epoch_ar.set']],'gui','off'); 

end

%% Average ERP together

EEG = pop_loadset('filename',[subject '_epoch_ar.set'],'filepath',workdir);
[ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );
ERP = pop_averager( ALLEEG , 'Criterion', 'good', 'DSindex',1, 'ExcludeBoundary', 'on', 'SEM', 'on' );
ERP = pop_savemyerp(ERP, 'erpname', subject, 'filename', [subject '.erp'], 'filepath', erpdir, 'Warning', 'on'); 