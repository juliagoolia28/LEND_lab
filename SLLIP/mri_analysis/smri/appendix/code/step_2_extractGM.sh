#!/bin/bash

# This is the final step in the pipeline to extract GM measures from individual participants for designated ROIs.

# Makes a log file which outputs the final GM measures you want for each subject. Change the name of the log file everytime you run this.
exec 3>&1 4>&2
trap 'exec 2>&4 1>&3' 0 1 2 3
exec 1>GM_extracted_roi_RH.log 2>&1

# Specify folder where participant freesurfer folders exist
export SUBJECTS_DIR=/home/qigroup/Documents/projects/sllip/dicom_conversion/derivatives/freesurfer

# Specify folder where mask exists
cd /home/qigroup/Documents/projects/sllip/dicom_conversion/derivatives/freesurfer/langloc_masks/masks

# Specify which ROIs (mlist) and participants (flist) you want to run through.  If you want to change the ROIs, change the contents of the ROI_3.list.txt file.  If you want to change the participants, change the contents of the subject.list.txt file
mlist=$(cat /home/qigroup/Documents/projects/sllip/dicom_conversion/derivatives/freesurfer/langloc_masks/code/all_RH_ROIs.list.txt)
#mlist=$(cat /home/qigroup/Documents/projects/sllip/dicom_conversion/derivatives/freesurfer/langloc_masks/code/all_LH_ROIs.list.txt)
flist=$(cat /home/qigroup/Documents/projects/sllip/dicom_conversion/derivatives/freesurfer/langloc_masks/code/subject.list.txt)

# Runs a nested loop where for each ROI and participant you specified, it will gather the statistical information like GM measures for each subject's individual subject-specific ROI label file . This will currently only run for the left hemisphere.  If you want to do this for the right hemisphere, change the ROI file to the right hemisphere masks and change the last flag "-b $subject lh" to "-b $subject rh".
# All of the important information like subject-specific GM measures will be output into the log file you created, e.g. GM_extracted_roi3_log.out.
for roi in $mlist;
	do
	for subject in $flist;
		do
			mris_anatomical_stats -l /home/qigroup/Documents/projects/sllip/dicom_conversion/derivatives/freesurfer/langloc_masks/${subject}_${roi}_surf.label -b $subject rh ;
		done
	done
