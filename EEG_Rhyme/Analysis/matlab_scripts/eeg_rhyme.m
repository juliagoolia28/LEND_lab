%% Notes
% when running by section over long periods of time, MATLAB may not save
% your variables. You may need to rerun the first section of code.

%%
clear
eeglab;
%%set up file and folders: Run this every time you re-open matlab
% establish working directory 
maindir = '/Volumes/juschnei/lendlab/projects/EEG_Rhyme/data/rawdir/'; %folder that houses the data from the rhyme tasks (exposure, post-test1 and post-test2)
workdir = '/Volumes/juschnei/lendlab/projects/EEG_Rhyme/analysis/wkdir/'; 
txtdir = '/Volumes/juschnei/lendlab/projects/EEG_Rhyme/analysis/txtdir/';
erpdir = '/Volumes/juschnei/lendlab/projects/EEG_Rhyme/analysis/erpdir/';


% establish parameters
 
lowpass = 30;
highpass = 0.1;
epoch_baseline = -500.0; %epoch baseline
epoch_end = 1000.0; %epoch offset

% establish subject list
[d,s,r] = xlsread ('subjects.xlsx');
subject_list = r;
numsubjects = (length(s));

%% Preprocessing steps
% Step 1: load file, filter, referencing
for s=34:numsubjects %change number of subjects as needed
    
    subject = subject_list{s};

    [ALLEEG, EEG, CURRENTSET, ALLCOM] = eeglab;
    eeglab('redraw');

    EEG = pop_loadbv(maindir, [subject '.vhdr'], [], []);
    [ALLEEG, EEG, CURRENTSET] = pop_newset(ALLEEG, EEG, 0,'setname',subject,'gui','off'); 
    EEG = eeg_checkset( EEG );

    EEG = pop_eegfilt ( EEG, highpass, lowpass, [], [0], 0, 0, 'fir1', 0);
    [ALLEEG, EEG, CURRENTSET] = pop_newset(ALLEEG, EEG, CURRENTSET,'setname',[subject '_fl'],'gui','off'); 
    EEG = eeg_checkset( EEG );

    EEG = pop_reref ( EEG, []);
    [ALLEEG, EEG, CURRENTSET] = pop_newset(ALLEEG, EEG, CURRENTSET,'setname',[subject '_fl_rr'],'gui','off'); 
    EEG = eeg_checkset( EEG );

    EEG = erplab_deleteTimeSegments(EEG, 0, 3000, 3000); %preserves data 3000ms before and after any event code, all other data is removed.

    EEG = pop_saveset( EEG, [workdir subject '_fl_rr']);
end


%% Removing bad blocks and interpolating bad electrodes

% Step 2: Manually scroll through the data and interpolate bad
% channels/reject bad blocks. Save this as subject _clean.set in the
% working directory
% To scroll through data: EEGLAB >> Tools >> Plot >> Channel data (scroll) 
% To interpolate bad electrodes EEGLAB >> Tools >> Interpolate electrodes >> Select from data channels
        % Note: we are interpolating electrodes sepherically
%% Removing unncessary blocks of data
% this sections removes large chunks of unneeded data

for s=34:numsubjects %change number of subjects as needed
    
    subject = subject_list{s};

    [ALLEEG, EEG, CURRENTSET, ALLCOM] = eeglab;
    eeglab('redraw');

EEG = pop_loadset ([subject '_fl_rr.set'],workdir);
[ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );

EEG = erplab_deleteTimeSegments(EEG, 0, 3000, 3000); %preserves data 3000ms before and after any event code, all other data is removed.

EEG = pop_saveset( EEG, [workdir subject '_clean1']); %naming scheme has been changed
end

%% ICA
%Step 3: Run ICA

for s=34 %change number of subjects as needed
    
    subject = subject_list{s};

    [ALLEEG, EEG, CURRENTSET, ALLCOM] = eeglab;
    eeglab('redraw');

EEG = pop_loadset ([subject '_clean.set'],workdir); % ensure that all files are properly named; the code will not work unless the files are named correctly
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
    % artifact likelihood of 70%(0.70) or higher
% Record removed artifacts in participant database
% Tools > Remove components from data > Yes (Plot Single Trials)
% If plot single trials looks cleaner, click to 'Accept' the removal
% Save file as subjectID_ICA_clean.set

%% ERP Analysis

clear
eeglab;
%%set up file and folders: Run this every time you re-open matlab
% establish working directory 
maindir = '/Volumes/juschnei/lendlab/projects/EEG_Rhyme/data/rawdir/'; %folder that houses the data from the rhyme tasks (exposure, post-test1 and post-test2)
workdir = '/Volumes/juschnei/lendlab/projects/EEG_Rhyme/analysis/wkdir/'; 
txtdir = '/Volumes/juschnei/lendlab/projects/EEG_Rhyme/analysis/txtdir/';
erpdir = '/Volumes/juschnei/lendlab/projects/EEG_Rhyme/analysis/erpdir/';

% establish subject list
% When analyzing multiple subjects at once, change subject list to correct
% condition

[d,s,r] = xlsread ('norhyme_subjects.xlsx');
%[d,s,r] = xlsread ('rhyme_subjects.xlsx');
subject_list = r;
numsubjects = (length(s));

epoch_baseline = -500.0; %epoch baseline
epoch_end = 1000.0; %epoch offset
condition = 'norhyme'; %rhyme or norhyme (NO SPACES), MAKE SURE TO CHANGE DEPENDING ON PARTICIPANT (see participant database)
%condition = 'rhyme' ;


for s=12:numsubjects %change number of subjects as needed
    
    subject = subject_list{s};

     [ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
     eeglab('redraw');

% Create eventlist, apply binlist, extract epochs, and artifact rejection
EEG = pop_loadset ([subject '_ICA_clean.set'], workdir);
[ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );

EEG  = pop_creabasiceventlist( EEG , 'AlphanumericCleaning', 'on', 'BoundaryNumeric', { -99 }, 'BoundaryString', { 'boundary' }, 'Eventlist', [txtdir [subject '.txt']] ); 
EEG = eeg_checkset( EEG );
[ALLEEG, EEG, CURRENTSET] = pop_newset(ALLEEG, EEG, CURRENTSET,'gui','off'); 

EEG  = pop_binlister( EEG , 'BDF', [txtdir filesep 'binlists/' condition '_binlist.txt'], 'IndexEL',  1, 'SendEL2', 'EEG', 'Voutput', 'EEG' ); % GUI: 10-Aug-2022 11:28:45
[ALLEEG, EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);
    
EEG = pop_epochbin( EEG , [epoch_baseline epoch_end],  'pre'); 
[ALLEEG, EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);

EEG = pop_exporteegeventlist( EEG , 'Filename', [txtdir subject '_bins.txt'] ); % GUI: 11-Aug-2022 13:27:29

EEG  = pop_artextval( EEG , 'Channel',  [], 'Flag',  1, 'Threshold', [ -75 75], 'Twindow', [epoch_baseline epoch_end] );
EEG  = pop_artmwppth( EEG , 'Channel',  [], 'Flag',  1, 'Threshold', 75, 'Twindow', [epoch_baseline epoch_end], 'Windowsize',  200, 'Windowstep',  100 ); 
[ALLEEG, EEG, CURRENTSET] = pop_newset(ALLEEG, EEG, CURRENTSET ,'savenew',[workdir [subject '_epoch_ar.set']],'gui','off'); 

end

%% Editing and Saving binlist
%{ The binlist is saved in the txtdir in the server (see "setting up files and folders" section for the exact loaction). For later analysis to be completed,
%you must edit the binlist and save it as a .csv file. Below are the
%instructions for how to do that correctly: %}

% 1. Open txtdir
% 2. select [subject_id_bins.txt] and open it as an Excel doc
% 3. Delete rows 1-46
% 4. Save the file in the txtdir in a .csv format. 

%% Editing and saving binlist


% establish subject list and text directory

[d,s,r] = xlsread ('subjects.xlsx');
subjects_list = r;
numsubjects = (length(s));
maindir = '/Volumes/juschnei/lendlab/projects/EEG_Rhyme/data/rawdir/'; %folder that houses the data from the rhyme tasks (exposure, post-test1 and post-test2)
workdir = '/Volumes/juschnei/lendlab/projects/EEG_Rhyme/analysis/wkdir/'; 
txtdir = '/Volumes/juschnei/lendlab/projects/EEG_Rhyme/analysis/txtdir/';
erpdir = '/Volumes/juschnei/lendlab/projects/EEG_Rhyme/analysis/erpdir/';

for s=1 %change number of subjects as needed
    
    subject = subjects_list{s};


C = readcell ([subject '_bins.txt']);
writematrix ([subject '_bins.txt']);
C ([1:40], :) =[];




end

%}  



%% Average ERP together

clear
eeglab;
%%set up file and folders: Run this every time you re-open matlab
% establish working directory 
maindir = '/Volumes/juschnei/lendlab/projects/EEG_Rhyme/data/rawdir/'; %folder that houses the data from the rhyme tasks (exposure, post-test1 and post-test2)
workdir = '/Volumes/juschnei/lendlab/projects/EEG_Rhyme/analysis/wkdir/'; 
txtdir = '/Volumes/juschnei/lendlab/projects/EEG_Rhyme/analysis/txtdir/';
erpdir = '/Volumes/juschnei/lendlab/projects/EEG_Rhyme/analysis/erpdir/';

% establish subject list
% When analyzing multiple subjects at once, change subject list to correct
% condition

%[d,s,r] = xlsread ('norhyme_subjects.xlsx');
[d,s,r] = xlsread ('rhyme_subjects.xlsx');
subject_list = r;
numsubjects = (length(s));

epoch_baseline = -500.0; %epoch baseline
epoch_end = 1000.0; %epoch offset
%condition = 'norhyme'; %rhyme or norhyme (NO SPACES), MAKE SURE TO CHANGE DEPENDING ON PARTICIPANT (see participant database)
condition = 'rhyme' ;


for s=4:numsubjects %change number of subjects as needed
    
    subject = subject_list{s};

     [ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
     eeglab('redraw');

EEG = pop_loadset('filename',[subject '_epoch_ar.set'],'filepath',workdir);
ERP = pop_averager( EEG , 'Criterion', 'good', 'DSindex',1, 'ExcludeBoundary', 'on', 'SEM', 'on' );
ERP = pop_savemyerp(ERP, 'erpname', subject, 'filename', [subject '.erp'], 'filepath', [erpdir filesep condition filesep], 'Warning', 'on'); 

end

%% ERP Edits: Filter, Channel edit, Bin editor

erpdir = '/Volumes/juschnei/lendlab/projects/EEG_Rhyme/analysis/erpdir/';

[d,s,r] = xlsread ('norhyme_subjects.xlsx');
%[d,s,r] = xlsread ('rhyme_subjects.xlsx');
subject_list = r;
numsubjects = (length(s));

epoch_baseline = -500.0; %epoch baseline
epoch_end = 1000.0; %epoch offset
condition = 'norhyme'; %rhyme or norhyme (NO SPACES), MAKE SURE TO CHANGE DEPENDING ON PARTICIPANT (see participant database)
%condition = 'rhyme' ;

for s=4t :numsubjects %change number of subjects as needed
    
    subject = subject_list{s};

     [ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
     eeglab('redraw');

ERP = pop_loaderp( 'filename', [subject '.erp'], 'filepath', [erpdir condition filesep] );
ERP = pop_filterp( ERP,  [] , 'Cutoff',  20, 'Design', 'butter', 'Filter', 'lowpass', 'Order',  2 );
ERP = pop_binoperator( ERP, {  'b21 = b12-b11 label Late minus Early trials',  'b22 = (b13+b15+b17+b19)/4 label Learned Overall',...
  'b23 = (b14+b16+b18+b20)/4 label Not Learned Overall'});
ERP = pop_erpchanoperator( ERP, {  'ch32 = (ch1 +ch2 + ch3 + ch4 + ch5 +ch6)/6 label left frontal',  'ch33 = (ch26 +ch27 + ch28 + ch29 + ch30 +ch31)/6 label right frontal',...
  'ch34 = (ch7+ch8+ch9+ch10+ch11)/5 label left central',  'ch35 = (ch20+ch21+ch22+ch24+ch25)/5 label right central',...
  'ch36 = (ch13+ch14+ch15)/3 label left parietal',  'ch37 = (ch17+ch18+ch19)/3 label right parietal'} , 'ErrorMsg', 'popup',...
 'KeepLocations',  1, 'Warning', 'on' );
ERP = pop_savemyerp(ERP, 'erpname', [subject 'filt'], 'filename', [subject '_filt.erp'], 'filepath', [erpdir condition filesep]);

end

