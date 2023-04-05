## sMRI Multivariate Analyses
This analysis allows one to create sMRI masks from functional data, and then use those masks as ROIs to extract sMRI metrics (gmv/SA) from within each ROI.

All work conducted here is based on initial analyses run by Dr. Jen Legault, which can be found [here](https://github.com/jlegault/multivariate_sMRI_analyses).

### Setup
Each python script will rely on text files that establish your subject list and ROIs.
Included in 'code' are examples of my subject.list.txt and my all_ROIS.list.txt

### Create Masks
You only need to run this step if you have not yet created the sMRI masks from functional data.
Based on your all_ROIs.list.txt it will create masks from the functional data provided.

### step_1_labelsubject.sh
- This will run a nested loop for each ROI you specified in your all_ROIS.list.txt.
- It creates a label file necessary for FS to read.
- Next, it registers that mask to each participant designated in your subject.list.txt file.
- Once you have made the appropriate edits:
``` sh step_1_labelsubject.sh```
*Note*: I run this once per hemisphere (LH_ROIs.txt/RH_ROIs.txt). Be sure you have all the correct label files you need before proceeding.

### step_2_extractGM.sh
- This runs a nested loop where for each ROI and participant you specified, it will gather the statistical information like GM measures for each subject's individual subject-specific ROI label file . 
- This will currently only run for the left hemisphere.  If you want to do this for the right hemisphere, change the ROI file to the right hemisphere masks and change the last flag "-b $subject lh" to "-b $subject rh".
- Output is stored as a log file (e.g. GM_extracted_roi_LH.log)
- Once you have made the appropriate edits:
``` sh step_2_extrachGM.sh```
