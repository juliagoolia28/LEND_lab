#!/bin/bash

# Only use this script if you are running a participant through feat for the first time.  This is a three-step process combined into one script. 

# make a log file which outputs any errors. Change the name of the log file everytime you run this.
exec 3>&1 4>&2
trap 'exec 2>&4 1>&3' 0 1 2 3
exec 1>cp_firstlevel_log.out 2>&1

# specify folder where main feat design folders and participant folders exist
cd /Users/qigroup/mnt/sylvian/sllip/dicom_conversion/derivatives/fsl/firstlevelanalysis/

# specify which runs, including VSL, ASL, runs 1-4, that you want to include.  If you want to change this, change the contents of the run.list.txt file 
rlist=$(cat /Users/qigroup/mnt/sylvian/sllip/dicom_conversion/derivatives/fsl/firstlevelanalysis/bash_scripts/run.list.txt)

# specify which participants you want to run through.  If you want to change the participants, change the contents of the subject.list.txt file
flist=$(cat /Users/qigroup/mnt/sylvian/sllip/dicom_conversion/derivatives/fsl/firstlevelanalysis/bash_scripts/sllip.subject.list.txt)

# runs a nested loop where for each participant and the runs you specified, it will copy the main design file and put a copy of that in each participant's folder.  It then searches those participant and run-specific design files for "001", and replaces it with the correct participant's ID.  Finally, it runs Feat for each participarticipant run.  

for run in $rlist
 do
	for subject in $flist;
		do
			cp design_files/${run}_design_child.fsf sllip_${subject}/;
			sed -i '' 's/\001/'${subject}'/g' sllip_${subject}/${run}_design_child.fsf;
	done
done
