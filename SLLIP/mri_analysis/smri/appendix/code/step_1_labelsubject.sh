#!/bin/bash

# This is the first step in the pipeline to extract GM measures from individual participants for designated ROIs.

# Makes a log file which outputs any errors. Change the name of the log file everytime you run this.
exec 3>&1 4>&2
trap 'exec 2>&4 1>&3' 0 1 2 3
exec 1>label_to_subject_roi3_log.out 2>&1

# Specify folder where participant freesurfer folders exist
export SUBJECTS_DIR=/home/qigroup/Documents/projects/sllip/dicom_conversion/derivatives/freesurfer

# Specify folder where mask exists
cd /home/qigroup/Documents/projects/sllip/dicom_conversion/derivatives/freesurfer/langloc_masks/masks

# Specify which ROIs (mlist) and participants (flist) you want to run through.  If you want to change the ROIs, change the contents of the ROI_3.list.txt file.  If you want to change the participants, change the contents of the subject.list.txt file.
mlist=$(cat /home/qigroup/Documents/projects/sllip/dicom_conversion/derivatives/freesurfer/langloc_masks/code/all_RH_ROIs.list.txt)
flist=$(cat /home/qigroup/Documents/projects/sllip/dicom_conversion/derivatives/freesurfer/langloc_masks/code/subject.list.txt)

# Runs a nested loop where for each ROI you specified, it creates a label file that freesurfer can read.  It then registers that mask to each participant you designated. This will currently only run for the left hemisphere.  If you want to do this for the right hemisphere, change ROI file to the right hemisphere masks and the last flag "--hemi lh" to "--hemi rh".
for roi in $mlist;
	do
	for subject in $flist;
		do
			mri_label2label --srcsubject fsaverage \
			--srclabel /home/qigroup/Documents/projects/sllip/dicom_conversion/derivatives/freesurfer/langloc_masks/masks/${roi}_surf.label \
			--trgsubject $subject --trglabel /home/qigroup/Documents/projects/sllip/dicom_conversion/derivatives/freesurfer/langloc_masks/${subject}_${roi}_surf.label \
			--regmethod surface --hemi lh ;
		done
	done
