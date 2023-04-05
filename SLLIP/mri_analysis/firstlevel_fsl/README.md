## SLLIP First-level Analysis

### Overview
The first level analysis for this study requires that you analyze each run seperately. Higher-level analyses will be utilized to combine across runs.
- In run 1, speech is always structured and tone is always random
- In run 2, tone is always structured and speech is always random. 
- These two runs are counterbalanced in order of presentation across participants to ensure there are no order effects driving conditional differences.

### FSL Designs
- The FSL design.feat files are all included in the folder design_files
- The design for Run 1:

![Run 1](https://github.com/juliagoolia28/sllip/blob/master/mri_analysis/firstlevel_fsl/firstlevel_run1_design.png)
- The design for Run 2:

![Run 2](https://github.com/juliagoolia28/sllip/blob/master/mri_analysis/firstlevel_fsl/firstlevel_run2_design.png)

### Executing the Analysis
- The following scripts can all be found within the bash_scripts folder:
- *run.list.txt*: This file should list the 2 run names (matching the design file names)
- *single.subj.txt*: This file should list 1 subject (number only, no characters)
- *sllip.subject.list.txt*: This file should list all subjects (number only, no characters)

Step 1.
- Make sure the three files listed above are completed correctly.

Step 2. 
- In terminal, execute the first script *cp_firstleveldesign.sh*:
```sh cp_firstleveldesign.sh```
- This script should copy your existing design files into each subject's individual folder, then make changes within the design file so that data analyzed later is specific to that subject (e.g. copies general design to 002, then ensures all data loaded will be specific to 002)

Step 3 (If this is your first run through ever. If it is not, skip to Step 4).
- In terminal, edit the script *feat_firstlevel.sh*:
```nano feat_firstlevel.sh```
- For flist, make sure the path loads the *single.subj.txt* as we want to test that our design files work first
- Save changes and exit
- In terminal, execute the script *feat_firstlevel.sh*:
```sh feat_firstlevel.sh```

Step 4. 
- Check that your feat analysis ran successfully on that single subject. 
- If it did not, edit your design files. If it did, proceed with the next steps:
- In terminal, edit the script *feat_firstlevel.sh*:
```nano feat_firstlevel.sh```
- For flist, make sure the path loads the *sllip.subject.list.txt* as we now want to run the feat analysis on all subjects
- Save changes and exit
- In terminal, execute the script *feat_firstlevel.sh*:
```sh feat_firstlevel.sh```

Step 5. 
- Once all first level feat analyses are run, we need to fix our registration (to understand why, listen to the pro: <https://mumfordbrainstats.tumblr.com/post/166054797696/feat-registration-workaround>)
- Execute the script *correcting_reg.sh*:
```sh correcting_reg.sh```
- This script will copy the correcting_reg bash script to each subject's first level feat folders and run the bash script, which corrects registration issues between fmriprep and fsl.

You are now ready for higher-level analyses!
