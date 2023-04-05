# SLLIP MRI Analysis Pipeline

Don't forget to work in the correct environment:
```
sllip_env
```
## Organization of Data (and rsyncing)
-  DICOM files are located at home/nas/dcmstorage/ and need to be rsynced to home/qigroup/Documents/projects/sllip/dicom_conversion/dicoms/ 
-  **DCM_SUBJECTID in all caps should be edited to reflect subject name in dcmstorage folder. SUBJECTID in all caps should be edited to reflect the name for the subject:**
```
rsync -chavzP --stats /home/nas/dcmstorage/DCM_SUBJECTID/ /home/qigroup/Documents/projects/sllip/dicom_conversion/dicoms/SUBJECTID
```
For example: ```rsync -chavzP --stats /home/nas/dcmstorage/SLLIP_001_SLLIP_001/ /home/qigroup/Documents/projects/sllip/dicom_conversion/dicoms/sllip_001```

AND to home/nas/projects/sllip/data/mri/dicoms/
```
rsync -chavzP --stats /home/nas/dcmstorage/DCM_SUBJECTID/ /home/nas/projects/sllip/data/mri/dicoms/SUBJECTID
```
For example: ```rsync -chavzP --stats /home/nas/dcmstorage/SLLIP_001_SLLIP_001/ /home/nas/projects/sllip/data/mri/dicoms/sllip_001```

-  BIDS files are located at home/qigroup/Documents/projects/sllip/dicom_conversion/bids/ and will be rsynced **LATER** to home/nas/projects/sllip/data/mri/bids/
```
rsync -chavzP --stats /home/qigroup/Documents/projects/sllip/dicom_conversion/bids/ /home/nas/projects/sllip/data/mri/bids
```
-  Derivatives (fmriprep, fsl, freesurfer) are located at home/qigroup/Documents/projects/sllip/derivatives/ and will be rsynced **LATER** to home/nas/projects/sllip/data/mri/derivatives/
```
rsync -chavzP --stats /home/qigroup/Documents/projects/sllip/dicom_conversion/derivatives/ /home/nas/projects/sllip/data/mri/derivatives
```

## Converting dicoms to BIDS formatter nifti
-  On terminal complete the following steps:
```
cd /home/qigroup/Documents/projects/sllip/dicom_conversion/
docker run --rm -it --entrypoint=bash -v $(pwd):/data nipy/heudiconv:latest
cd /data/
```
-  You should now be within the container and can run the conversion. **SUBJECTID in all caps should be edited:**
```
heudiconv -d /data/dicoms/{subject}/*/*/*.IMA -s SUBJECTID -f /data/sllip_heuristics.py -c dcm2niix -b -o /data/bids
```
- Once the conversion is complete, back up the BIDS data to NAS:
```
rsync -chavzP --stats /home/qigroup/Documents/projects/sllip/dicom_conversion/bids/ /home/nas/projects/sllip/data/mri/bids
```
## Prepare data for Freesurfer edits
-  We next need to convert the anatomical data to be corrected within Freesurfer. **SUBJECTID in all caps should be edited:**
```
docker run -ti --rm -v /home/qigroup/Documents/projects/sllip/dicom_conversion/bids:/data:ro -v /home/qigroup/Documents/projects/sllip/dicom_conversion/derivatives:/out -v /home/qigroup/Documents/projects/sllip/license.txt:/opt/freesurfer/license.txt poldracklab/fmriprep:1.3.1 /data /out participant --participant_label SUBJECTID --anat-only
```
-  Check anatomical data using Quola-T and make any necessary freesurfer edits, as described in the sMRI analysis folder of this directory.

-  Backup the derivatives folder to NAS:
```
rsync -chavzP --stats /home/qigroup/Documents/projects/sllip/dicom_conversion/derivatives/ /home/nas/projects/sllip/data/mri/derivatives
```
## Run fMRIprep on ALL functional data, using corrected sMRI data
-  Documentation on running/troubleshootin fMRIprep can be found at: http://reproducibility.stanford.edu/fmriprep-tutorial-running-the-docker-image/
-  Run the below code **SUBJECTID in all caps should be edited:**
```
fmriprep-docker /home/qigroup/Documents/projects/sllip/dicom_conversion/bids /home/qigroup/Documents/projects/sllip/dicom_conversion/derivatives participant --participant-label SUBJECTID --fs-license-file /home/qigroup/Documents/projects/sllip/license.txt
```
-  Backup the derivatives folder to NAS again:
```
rsync -chavzP --stats /home/qigroup/Documents/projects/sllip/dicom_conversion/derivatives/ /home/nas/projects/sllip/data/mri/derivatives
```
## FSL fMRI Analysis
### Organize behavioral in-scanner event codes for fMRI data
-  To conduct FSL first-level analyses, each subject requires an event code file for each run of data.
-  In-scanner behavioral data is all located in a single folder that the script *sllip_inscanner_FSL_event_recode.ipynb* should be one level outside of. 
- Run the jupyter notebook *sllip_inscanner_FSL_event_recode.ipynb*

### First-level Analysis
- Follow the README.md instructions here: <https://github.com/juliagoolia28/sllip/tree/master/mri_analysis/firstlevel_fsl>
