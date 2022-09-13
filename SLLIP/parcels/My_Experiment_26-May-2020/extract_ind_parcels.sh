#!/bin/bash
fslmaths -dt int My_Experiment_probability_map_thresh2subjs_smoothed_parcels_sig.nii.gz -thr 1 -uthr 1 -bin parcel_1
fslmaths -dt int My_Experiment_probability_map_thresh2subjs_smoothed_parcels_sig.nii.gz -thr 2 -uthr 2 -bin parcel_2
fslmaths -dt int My_Experiment_probability_map_thresh2subjs_smoothed_parcels_sig.nii.gz -thr 3 -uthr 3 -bin parcel_3
fslmaths -dt int My_Experiment_probability_map_thresh2subjs_smoothed_parcels_sig.nii.gz -thr 4 -uthr 4 -bin parcel_4
fslmaths -dt int My_Experiment_probability_map_thresh2subjs_smoothed_parcels_sig.nii.gz -thr 5 -uthr 5 -bin parcel_5
