#!/bin/bash

# This step only needs to happen if you are creating a Freesurfer-based mask off of an fMRI mask for the very first time.  Once the mask has been created, you no longer need to repeat this step.

# Makes a log file which outputs any errors. Change the name of the log file everytime you run this.
exec 3>&1 4>&2
trap 'exec 2>&4 1>&3' 0 1 2 3
exec 1>mask2label_roi3_log.out 2>&1

# Specify folder where participant freesurfer folders exist
export SUBJECTS_DIR=/home/qigroup/Documents/projects/sllip/dicom_conversion/derivatives/freesurfer

# Moves you into participant freesurfer folder
cd /home/qigroup/Documents/projects/sllip/dicom_conversion/derivatives/freesurfer

# Specifies which ROIs you want to create.  If you want to change the ROIs, change the contents of the ROI_3.list.txt file. 
mlist=$(cat /home/qigroup/Documents/projects/sllip/dicom_conversion/derivatives/freesurfer/langloc_masks/code/all_LH_ROIs.list.txt)

# Runs a loop where for each ROI you specified, it creates a registration file for that ROI and maps that onto fsaverage, then converts the volume file to a surface file that Freesurfer can read and registers it to fsaverage, and finally creates an ROI-specific label file which can later be registered to invididual participants in the next step.  This will currently only run for the left hemisphere.  If you want to do this for the right hemisphere, change the ROI file to the right hemisphere masks and change the flag "--hemi lh" to "--hemi rh" and the flag "--surf fsaverage lh" to "--surf fsaverage rh".
for i in $mlist;
	do
	bbregister --mov /home/qigroup/Documents/projects/sllip/dicom_conversion/derivatives/freesurfer/langloc_masks/masks/$i.mgh \
		--s fsaverage --t1 \
		--reg /home/qigroup/Documents/projects/sllip/dicom_conversion/derivatives/freesurfer/langloc_masks/masks/fsaverage_register_$i.dat ;
	mri_vol2surf --mov /home/qigroup/Documents/projects/sllip/dicom_conversion/derivatives/freesurfer/langloc_masks/masks/$i.mgh \
		--srcreg /home/qigroup/Documents/projects/sllip/dicom_conversion/derivatives/freesurfer/langloc_masks/masks/fsaverage_register_$i.dat \
		--trgsubject fsaverage \
		--out /home/qigroup/Documents/projects/sllip/dicom_conversion/derivatives/freesurfer/langloc_masks/masks/${i}_surf.mgh \
		--hemi lh ;
	cd /home/qigroup/Documents/projects/sllip/dicom_conversion/derivatives/freesurfer/langloc_masks/masks
	mri_cor2label --i ${i}_surf.mgh \
		--l ${i}_surf.label \
		--surf fsaverage lh --id 1 ;
	done
