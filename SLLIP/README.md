# sllip
Details for the NSF Funded project about Statistical Learning and Language Input as Protective factors (SLLIP).

## Getting Started
### Create environment for SLLIP analyses to occur
Everytime you work on SLLIP data analysis, you need to work within a designated environment:
-  Please copy and paste the content of https://github.com/juliagoolia28/sllip/tree/master/mri_analysis/sample_bashrc into your own ~/.bashrc
-  Then type in terminal:
```
source ~/.bashrc
sllip_env
```
## Checking Data Transfer
After running a participant, we want to ensure that data has been transferred to the correct locations. Using the Data Transfer checklist in RedCap for each participant, you can use the following code to easily check on data for each participant. 
Be sure that nas (the Qlab drive) is mapped onto whatever computer you are working on

- MRI In-Scanner behavioral (Order_N = Order_1 or Order_2)

The participant should have the following file types: .csv, .log & .psydat. They will have these three files for auditory_1 and auditory_3.
```
cd /nas/projects/sllip/data/in-scanner-behavioral/Order_N/
```
- MRI data to Dicoms computer is checked at the CBBI (please skip)
- MRI data to DCM storage
```
cd /nas/dcmstorage/
```
- MRE via Twix is completed by Julie (please skip)
- Video from SD Card

The participant should have at least one .MP4 file. It is okay if there are multiple.
```
cd /nas/projects/sllip/data/mother-child_dyads/
```
- Audio from Voice Recorder

The participant should have at least one .MP3 file, but it is okay if they have a folder created with multiple files.
```
cd /nas/projects/sllip/data/assessments/
```
- LENA Audio Files are checked by Julie or Hannah (please skip)
```
cd /nas/projects/sllip/LENA/
```

## Checking Data Processing 
After we begin to transfer and analyze a participant's data, we want to ensure that data has been transferred to the correct locations and analyzed. Using the Data Transfer checklist in RedCap for each participant, you can use the following code to easily check on data analysis for each participant.

For this task, you will need to work on the Linux computer:
```
ssh qigroup@sylvian.ling.udel.edu
```
Information about password & google authenticator are located in the lab.

- Dicoms transferred locally to dicom_conversion folder
```
cd /home/qigroup/Documents/projects/sllip/dicom_conversion/dicoms
```
- Dicoms transferred to nas
```
cd /home/nas/projects/sllip/data/mri/dicoms
```
- Dicoms converted to BIDS formatted nifti files
```
cd /home/qigroup/Documents/projects/sllip/dicom_conversion/bids
```
- BIDS transferred to nas
```
cd /home/nas/projects/sllip/data/mri/bids
```
