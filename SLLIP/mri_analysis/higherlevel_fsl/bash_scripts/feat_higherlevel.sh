#!/bin/bash
exec 3>&1 4>&2
trap 'exec 2>&4 1>&3' 0 1 2 3
exec 1>rename_cope_log1.out 2>&1

cd /Users/qigroup/mnt/sylvian/sllip/dicom_conversion/derivatives/fsl/higherlevelanalysis

flist=$(cat /Users/qigroup/mnt/sylvian/sllip/dicom_conversion/derivatives/fsl/higherlevelanalysis/bash_scripts/sllip.subject.list.txt)

for subject in $flist;
	do
		Feat sllip_${subject}/ASL_child_design.fsf;
done
