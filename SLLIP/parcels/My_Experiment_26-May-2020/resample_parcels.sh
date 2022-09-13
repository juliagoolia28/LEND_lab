#!/bin/bash
flirt -in original_to_resample/parcel_1.nii.gz -ref original_to_resample/mask.nii.gz -applyxfm -out parcel_1.nii.gz 
flirt -in original_to_resample/parcel_2.nii.gz -ref original_to_resample/mask.nii.gz -applyxfm -out parcel_2.nii.gz 
flirt -in original_to_resample/parcel_3.nii.gz -ref original_to_resample/mask.nii.gz -applyxfm -out parcel_3.nii.gz 
flirt -in original_to_resample/parcel_4.nii.gz -ref original_to_resample/mask.nii.gz -applyxfm -out parcel_4.nii.gz 
flirt -in original_to_resample/parcel_5.nii.gz -ref original_to_resample/mask.nii.gz -applyxfm -out parcel_5.nii.gz 

