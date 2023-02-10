%% Function: erpaverageEEG(subject_start, subject_end, subjects, workdir, erpdir)
% Author: Will Decker
% Usage: average ERPs across participants

%% Inputs 

%{ 
    subject_start: subject file to start loading (the position of the file name in subject_names
     
    subject_end: last subject file to load (the position of the file name in subject_names
    
    subjects: a str list of subject names to be loaded into the EEG object
    
    workdir: path to working directory

    erpdir: path to ERP directory

%}

function [EEG, com] = erpaverageEEG(subject_start, subject_end, subjects, workdir, erpdir)

EEG = [];
com = ' ';

for s = subject_start : subject_end
    subject = subjects{s};

    % establish data objects
   [ALLEEG, EEG, CURRENTSET, ALLCOM] = eeglab;
    eeglab('redraw');

    % load dataset
    EEG = pop_loadset([subject '_epoch_ar.set'],workdir); 
    [ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );

    % average ERPs
    ERP = pop_averager( ALLEEG , 'Criterion', 'good', 'DSindex',1, 'ExcludeBoundary', 'on', 'SEM', 'on' );
    ERP = pop_savemyerp(ERP, 'erpname', subject, 'filename', [subject '.erp'], 'filepath', erpdir, 'Warning', 'on'); 

    % filter ERPs
    ERP = pop_loaderp( 'filename', [subject '.erp'], 'filepath', [erpdir condition filesep] );
    ERP = pop_filterp( ERP,  [] , 'Cutoff',  20, 'Design', 'butter', 'Filter', 'lowpass', 'Order',  2 );
    ERP = pop_binoperator( ERP, {  'b13 = b12-b11 label Late minus Early trials'});
    ERP = pop_erpchanoperator( ERP, {  ...
      'ch32 = (ch1 + ch2 + ch3 + ch4 + ch5 + ch6)/6 label left frontal',  ...
      'ch33 = (ch26 + ch27 + ch28 + ch29 + ch30 + ch31)/6 label right frontal',...
      'ch34 = (ch7 + ch8 + ch9 + ch10 + ch11)/5 label left central',  ...
      'ch35 = (ch20 + ch21 + ch22 + ch24 + ch25)/5 label right central',...
      'ch36 = (ch13 + ch14 + ch15)/3 label left parietal',  ...
      'ch37 = (ch17 + ch18 + ch19)/3 label right parietal', ...
      'ch38 = (ch1 + ch6 + ch28 + ch31)/4 label frontal'} , 'ErrorMsg', 'popup',...
     'KeepLocations',  1, 'Warning', 'on' );
    ERP = pop_savemyerp(ERP, 'erpname', [subject 'filt'], 'filename', [subject '_filt.erp'], 'filepath', [erpdir condition filesep]);

end
