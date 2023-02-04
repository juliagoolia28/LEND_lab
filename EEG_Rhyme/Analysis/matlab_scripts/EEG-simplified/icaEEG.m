function [EEG, com] = icaEEG(subject_start, subject_end, subjects, workdir)

EEG = [];    
com = ' ';

for s=subject_start : subject_end
    subject = subjects{s};

    EEG = pop_loadset ([subject '_clean.set'],workdir);
    [ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );
    
    EEG = pop_runica(EEG, 'icatype', 'runica', 'extended',1,'interrupt','on');
    [ALLEEG, EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);
    
    EEG = pop_saveset( EEG, [workdir subject '_ICA']);
    
end

% Usage: running independant component analysis (ICA) according to the
% LEND Lab EEG pipline.
% 
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
%   workdir: path to working directory
%
% Example:
%
% icaEEG(subject_start, subject_end, subjects, workdir)