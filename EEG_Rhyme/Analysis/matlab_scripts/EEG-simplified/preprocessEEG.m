function [EEG, com] = preprocessEEG(subject_start, subject_end, subjects, rawdir, workdir, highpass,lowpass)

com = ' ';
EEG = [];

for s = subject_start : subject_end
    subject = subjects{s};
    
    EEG = pop_loadbv(rawdir, [subject '.vhdr']);
    EEG = pop_eegfilt ( EEG, highpass, lowpass, [], [0], 0, 0, 'fir1', 0);
    EEG = pop_reref ( EEG, []);
    EEG = erplab_deleteTimeSegments(EEG, 0, 3000, 3000);
    EEG = eeg_checkset( EEG );
    [ALLEEG, EEG, CURRENTSET] = pop_newset(ALLEEG, EEG, CURRENTSET,'setname',[subject '_fl_rr'],'gui','off'); 
    EEG = pop_saveset( EEG, [workdir subject '_fl_rr']);
end


% Usage: preprocess raw EEG data according to LEND Lab EEG pipeline.

% Inputs:
%    
%   subject_start: subject file to start loading (the position of the file
%   name in subject_names
%
%   subject_end: last subject file to load (the position of the file name
%   in subject_names
%   
%   subjects: a str list of subject names to be loaded into the EEG
%   object
%
%   rawdir: path to raw EEG BrainVision (.vhdr) files
%
%   workdir: path to working directory
%
%   highpass: highpass filter
%
%   lowpass: lowpass filter


% Notes:

% This function requires that a subject list be loaded using xlsread.
% Follow the accompanying example for further information.
%
% Example:
%
% rawdir = "path/to/raw/files";
% workdir = "paht/to/working/directory";
% highpass = 0.1;
% lowpass = 30.0;
% [d,s,r] = xlsread ('subjects.xlsx');
% subjects = r;
% subject_start = 1; % load the file name in position 1
% subject_end = 3; % load through file name in position 3 then stop  
%
% preprocessEEG(subject_start, subject_end, subjects, rawdir, workdir, highpass,lowpass)

%%
