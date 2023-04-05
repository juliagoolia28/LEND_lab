## Extracting Structural Measures from Functional Masks
### This was developed by Jen Legault and original citations/source code can be found here: https://github.com/jlegault/multivariate_sMRI_analyses/tree/master/scripts_to_extract_GM_measures

### Overview
This allows you to tak .nii.gz funcitonal masks, convert them into freesurfer masks, and extract GMV/CT measures from your structural data within these funcitonal ROIS (fROIs).

## Step 1. Convert masks.
Use the mri_convert function to alter .nii files to .mgh

```mri_convert AngGy_ant.nii AngGy_ant.mgh```

## Step 2. Create FS Masks & Labels.
- Create .txt files for each hemisphere listing ROIs (for example, see: all_LH_ROIs.list.txt)
- Create a list of subject IDs, based on FS directory (for example, see: subject.list.txt)
- Modify the paths in your create_masks.sh script to mirror your own direectories
- All label files will be saved to the fsaverage directory "label"
- Check your log script. If you have this error 
```
 "dyld: lazy symbol binding failed: Symbol not found: ___emutls_get_address
  Referenced from: freesurfer/bin/../lib/gcc/lib/libgomp.1.dylib
  Expected in: /usr/lib/libSystem.B.dylib"
  ```
  Go to this website: https://surfer.nmr.mgh.harvard.edu/fswiki/ReleaseNotes

## Step 3. Label individual subjects.
- Edit the labelsubject.sh script based on your hemisphere and directories
- Run this for each hemisphere

## Step 4. Extract GM measures. 
- Edit the extractGM.sh script based on your hemisphere and directories
- Run this for each hemisphere
- Your .log files contain the metadata with GM measures
