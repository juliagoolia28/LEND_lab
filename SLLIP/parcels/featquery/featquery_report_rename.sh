#!/bin/bash

# Only use this script if you are running a participant through feat for the first time.  This is a three-step process combined into one script. 

# make a log file which outputs any errors. Change the name of the log file everytime you run this.
exec 3>&1 4>&2
trap 'exec 2>&4 1>&3' 0 1 2 3
exec 1>Feat_first_level_7_log.out 2>&1

# specify folder where main feat design folders and participant folders exist
cd /Volumes/juschnei/lendlab/projects/sllip/sllip_nas/data/mri/derivatives/fsl/higherlevelanalysis

# specify which copes, that you want to include.  If you want to change this, change the contents of the run.list.txt file
plist=$(cat /Volumes/juschnei/lendlab/projects/sllip/make_parcels-tengwen/featquery/parcel.list.txt)

# specify which participants you want to run through.  If you want to change the participants, change the contents of the subject.list.txt file
flist=$(cat /Volumes/juschnei/lendlab/projects/sllip/make_parcels-tengwen/featquery/sllip.subject.list.txt)

# runs a nested loop where for each participant and the copes you specified, it will copy the main design file and put a copy of that in each participant's folder.  It then searches those participant and run-specific design files for "001", and replaces it with the correct participant's ID.  Finally, it runs Feat for each participant run.

for parcel in $plist
 do
	for subject in $flist;
		do
			cp /Volumes/juschnei/lendlab/projects/sllip/sllip_nas/data/mri/derivatives/fsl/higherlevelanalysis/sllip_${subject}/ASL.gfeat/cope2.feat/featquery_parcel${parcel}_Tengwen/report.txt /Volumes/juschnei/lendlab/projects/sllip/make_parcels-Tengwen/featquery/nwr_parcel_reports/parcel${parcel}/sllip_${subject}_report.txt
	done
done
