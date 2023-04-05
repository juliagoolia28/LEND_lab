#!/bin/bash
exec 3>&1 4>&2
trap 'exec 2>&4 1>&3' 0 1 2 3
exec 1>Feat_first_level_mac_log1.out 2>&1

cd /Users/qigroup/mnt/sylvian/sllip/dicom_conversion/derivatives/fsl/firstlevelanalysis

rlist=$(cat /Users/qigroup/mnt/sylvian/sllip/dicom_conversion/derivatives/fsl/firstlevelanalysis/bash_scripts/run.list.txt)
flist=$(cat /Users/qigroup/mnt/sylvian/sllip/dicom_conversion/derivatives/fsl/firstlevelanalysis/bash_scripts/singlesubj.txt)

for run in $rlist
 do
	for subject in $flist;
		do
#			cd /Users/qigroup/mnt/sylvian/sllip/dicom_conversion/derivatives/fsl/firstlevelanalysis
			Feat sllip_${subject}/${run}_design_child.fsf;
	done
done
