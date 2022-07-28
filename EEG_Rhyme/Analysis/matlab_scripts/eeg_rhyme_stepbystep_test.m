clear
eeglab;
%% set up file and folders
% establish working directory 
maindir = '/Volumes/juschnei/lendlab/projects/EEG_Rhyme/data/rawdir/';
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

for s=1:numsubjects %change number of subjects as needed
    
    subject = subject_list{s};

%% Preprocessing steps
% Step 1: load file, filter, referencing, run ica, apply channel location
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
