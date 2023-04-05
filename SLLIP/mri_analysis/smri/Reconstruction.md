**Perform control point and white matter recon separately. Always start with control points, followed by white matter edits.**  
**Don't edit white matter and then run control point recon, it will ignore your changes!**  
*Reconstruction must all take place on the ba3 server.*

**CP Reconstruction**  
Once you have completed adding control points, go to the terminal to set your main subjects directory and add your job to the queue:  
```bash
$ export SUBJECTS_DIR=/path/to/subjects/directory
$ echo "recon-all -autorecon2-cp -autorecon3 -subjid <Subject Folder Name>" | qsub -V -N <Subject Folder Name> -o ./logs/ -e ./logs/ -q recon
```
*This will take ~10 hours. I recommend leaving it on the queue overnight.*

**WM Reconstruction**  
Then, complete white matter editing and run WM recon in the terminal: 
```bash
$ export SUBJECTS_DIR=/path/to/subjects/directory
$ echo "recon-all -autorecon2-wm -autorecon3 -subjid <Subject Folder Name>" | qsub -V -N <Subject Folder Name> -o ./logs/ -e ./logs/ -q recon
```
*This will also take ~10 hours.*

**Checking Your Status**  
Type in `$ squeue -u <username>` in the terminal.
- Make sure that the job is on the queue by ensuring that the **S** column says **R**, the job color is blue, and that the **Time** is elapsing.  Your subject folder name will appear in the **Name** column.
![iqstat](http://www.mit.edu/~nayeonk/iqstat.png)  
- When it’s no longer on the queue, it means it’s done. Open up the brain on FreeView and review the changes made by your edits. 

If there are issues, see [Troubleshooting](FreeSurfer-Troubleshooting).

**Next step:** White Matter Edits or you're ready for final review!
