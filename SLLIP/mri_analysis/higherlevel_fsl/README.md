## SLLIP Higher-level Analysis

### Overview
The higher level analysis for this study requires that you combine across runs. Group-level analyses will be utilized to combine across subjects.

### FSL Designs
- The FSL design.feat files are all included in the folder design_files
- The design for higher level analyses:

![Higher level](https://github.com/juliagoolia28/sllip/blob/master/mri_analysis/higherlevel_fsl/higherlevel_design.png)

### Executing the Analysis
- The following scripts can all be found within the bash_scripts folder:
- *single.subj.txt*: This file should list 1 subject (number only, no characters)
- *sllip.subject.list.txt*: This file should list all subjects (number only, no characters)

Step 1.
- Make sure the two files listed above are completed correctly.

Step 2. 
- In terminal, execute the first script *cp_higherdesign.sh*:
```sh cp_higherdesign.sh```
- This script should copy your existing design files into each subject's individual folder, then make changes within the design file so that data analyzed later is specific to that subject (e.g. copies general design to 002, then ensures all data loaded will be specific to 002)

Step 3 (If this is your first run through ever. If it is not, skip to Step 4).
- In terminal, edit the script *feat_firstlevel.sh*:
```nano feat_higherlevel.sh```
- For flist, make sure the path loads the *single.subj.txt* as we want to test that our design files work first
- Save changes and exit
- In terminal, execute the script *feat_higherlevel.sh*:
```sh feat_firstlevel.sh```

Step 4. 
- Check that your feat analysis ran successfully on that single subject. 
- If it did not, edit your design files. If it did, proceed with the next steps:
- In terminal, edit the script *feat_higherlevel.sh*:
```nano feat_higherlevel.sh```
- For flist, make sure the path loads the *sllip.subject.list.txt* as we now want to run the feat analysis on all subjects
- Save changes and exit
- In terminal, execute the script *feat_higherlevel.sh*:
```sh feat_higherlevel.sh```

You are now ready for group-level analyses!
