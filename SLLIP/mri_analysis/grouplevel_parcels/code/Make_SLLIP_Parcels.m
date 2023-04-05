%% Script to make parcels from a dataset

% First get a cell array with the full path to each individual subject file

PROJECT_DIR = '/Volumes/data-1/users/julie/make_parcels-julie/';

FILENAMES = {};

for i = 1:30
    FILENAMES{i} = [PROJECT_DIR 'data/sllip/ssl_random/' num2str(i) '_zstat1.nii.gz'];
end

options = struct( ...
	'SET_FREESURFER', 'export FREESURFER_HOME=/Applications/freesurfer', ... # Point to your freesurfer directory so the code can find mri_convert
	'path_to_freesurfer_bin', ':/Applications/freesurfer/bin', ... # Point to where MRIread.m and MRIwrite.m live in case they are not already in your path
	'THRESH', 2.326, ... # Numeric value to threshold volumes at 2.326348
	'PCT_SUBJ_IN_PARC', 0.60, ... # Percent of subjects needed to consider a parcel "significant" or, representing the majority of subjects.
    'peak_spacing', 0, ... # Minimum distance between peaks of different parcels, in number of voxels. Ex. 3 means all local maxima have to be 3 voxels apart.
	'EXPERIMENT', 'ssl_rd_str', ... # For naming outputs
	'PATH_TO_RESULTS_DIR', [PROJECT_DIR 'parcels/sllip/ssl_rd_str_60pct_thresh2.326']); % Where to put the outputs

generate_parcels(FILENAMES, options);