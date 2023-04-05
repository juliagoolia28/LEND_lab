%% Run fROI Analysis 

SET_FREESURFER = 'export FREESURFER_HOME=/Applications/freesurfer'; % Point to your freesurfer directory so the code can find mri_convert
path_to_freesurfer_bin = 'export FREESURFER_HOME=/Applications/freesurfer'; % Point to where MRIread.m and MRIwrite.m live in case they are not already in your path
	
path1 = getenv('PATH');
path1 = [path1 path_to_freesurfer_bin];
setenv('PATH', path1)
unix(SET_FREESURFER);

PROJECT_DIR = '/Volumes/data-1/users/julie/make_parcels-julie/';
PARCEL_DIR = [PROJECT_DIR 'parcels/sllip/ssl_rd_str_60pct_thresh2.326_14-Apr-2021/'];
opts.PARCEL_FILE = [PARCEL_DIR 'ssl_rd_str_probability_map_thresh2subjs_smoothed_parcels_sig.nii.gz'];

opts.SUBJ_DEFINE_DATA_DIR = [PROJECT_DIR 'data/sllip/ssl_random/relabeled/'];
opts.SUBJ_MEASURE_DATA_DIR = [PROJECT_DIR 'data/sllip/ssl_random_copes/'];

opts.RESULTS_DIR = [PROJECT_DIR 'data/froi_analysis_results/'];
if ~exist(opts.RESULTS_DIR,'dir')
    mkdir(opts.RESULTS_DIR)
end

% Conditions to measure
opts.COND = {'sllip_ssl_str_v_rd_contrast'};
opts.SUBJ_IDS = 1:30;

run_SLLIP_froi_resp_mag(opts);

clear opts