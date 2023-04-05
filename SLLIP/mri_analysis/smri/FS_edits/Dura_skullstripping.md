## Skullstripping
Written by Jen Legault and Nicola Bautista (https://github.com/Qlab-UDel/qlab/wiki/Skullstripping)

*Adjusting watershed parameters for ideal brainmask volume*

It's super simple and fast!

## FIRST STEP
**Before you do anything, make sure to backup the old brainmask. To do this, you will copy the `brainmask.mgz` in `mri` directory to a backup file called `brainmask_orig.mgz`. **

Example on Mac Mini 1 (must edit sub-sllipID to subject #):

```cp /Users/qigroup/mnt/sylvian/sllip/dicom_conversion/derivatives/freesurfer/sub-sllipID/mri/brainmask.mgz /Users/qigroup/mnt/sylvian/sllip/dicom_conversion/derivatives/freesurfer/sub-sllipID/mri/orig_brainmask.mgz```

From now on, we only make edits to `brainmask.mgz`. 

Also, be sure your SUBJECT DIRS are correctly setup:
On Mac Mini 1:

```
export SUBJECTS_DIR=/Users/qigroup/mnt/sylvian/sllip/dicom_conversion/derivatives/freesurfer
```

On Sylvian:

```
export SUBJECTS_DIR=/home/qigroup/Documents/projects/sllip/dicom_conversion/derivatives/freesurfer
```

To double check that you have set the correct subject’s directory you can run the command:

```
echo $SUBJECTS_DIR
```

## Next Steps
1. Open FreeView (type 'freeview' in terminal)

2. Open the following Volume files (File>Load Volume): brainmask.mgz and orig.mgz from the subject's mri folder, and make sure you put brainmask above orig (using the blue arrows)

3. Change the colormap of brainmask to heat and lower the opacity a little bit so you can see it overlaid on orig (I personally find that an opacity of ~0.11 works well). 

4. One way to control the amount of skull that is removed is by adjusting a parameter called the watershed threshold. During recon-all’s autorecon1, the skull is stripped using a watershed threshold of 25; this parameter can take any value from 0 to 50. Increasing the threshold will increase the likelihood that both brain and skull will remain (i.e., it will be a more lenient skull-strip), while decreasing the threshold will run a more aggressive skull-strip.
  - Exit FreeView and the GUI. In the terminal, run the command:
```
recon-all -skullstrip -wsthresh <h> -clean-bm -s [subject id]
```
  - Where <h> is the new threshold  and subject id is your subject
  - This will create a new brainmask.mgz file, which now has more of the skull removed.
  - Even with a lower watershed threshold, there may still be bits of skull and dura mater that remain. You can use the -gcut option to remove the latter:
  
```
recon-all -skullstrip  -clean-bm -gcut -subjid [subject id]
```
  - To examine how much dura was removed, load the `brainmask.mgz`, `T1.mgz`, and `brainmask.gcuts.mgz` files in freeview
  - After you use the watershed or gcut options, you will need to regenerate the pial surfaces with the following code:

```
recon-all -autorecon-pial -subjid <subject name>
```

**Next step:** Control Point Edits
