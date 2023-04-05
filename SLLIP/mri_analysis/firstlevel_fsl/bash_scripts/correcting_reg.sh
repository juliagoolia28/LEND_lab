#!/bin/bash
exec 3>&1 4>&2
trap 'exec 2>&4 1>&3' 0 1 2 3
exec 1>Feat_correcting_reg_2_log.out 2>&1

cd /Users/qigroup/mnt/sylvian/sllip/dicom_conversion/derivatives/fsl/firstlevelanalysis

rlist=$(cat /Users/qigroup/mnt/sylvian/sllip/dicom_conversion/derivatives/fsl/firstlevelanalysis/bash_scripts/run.list.txt)
flist=$(cat /Users/qigroup/mnt/sylvian/sllip/dicom_conversion/derivatives/fsl/firstlevelanalysis/bash_scripts/sllip.subject.list.txt)

for run in $rlist
 do
	for subject in $flist;
		do
			cp correcting_reg sllip_${subject}/${run}.feat;
			cd sllip_${subject}/${run}.feat;
			sh correcting_reg;
			cd /Users/qigroup/mnt/sylvian/sllip/dicom_conversion/derivatives/fsl/firstlevelanalysis;
	done
done
