## White Matter Edits
Written by Jen Leagult and Nicola Bautista: https://github.com/Qlab-UDel/qlab/wiki/White-Matter-Edits

After editing control points to include white matter that was outside of the surface, you may need to edit the white matter volume itself to get rid of gray matter that is inside the surface boundary.

1. **Backup.** As usual, the first thing to do is backup the original white matter volume file. To do this, go to your subject's `mri` folder and copy `wm.mgz` to `wm_orig.mgz`.

2. **Open FreeView and load the necessary files.** This part is just like opening up the files for control point edits. Open FreeView and load the `orig.mgz` and `wm.mgz` volumes from the `mri` folder, and the `lh.white` and `rh.white` surfaces from the `surf` folder. Make sure `wm` is above `orig` and change the colormap of the `wm` volume to heat and lower the opacity so you can see it over the `orig` volume. 
    *Note that you don't have to open the control points this time.*

3. **Erase gray matter.** There will be areas in the brain where FreeSurfer thought that gray matter was white and drew the surface around it. In this case, the red/yellow `wm` volume will cover those gray matter areas, and we need to erase the `wm` volume there for FreeSurfer to get it right the next time around. On the left of the screen under the "Volumes" tab, make sure `wm` is selected and set "Brush value" to 0 - this will enable you to erase areas of the volume. Now look through the brain and find the areas that are actually gray matter inside the surface boundary and erase them.

4. **Recon the brain.** When you're done and satisfied, go to the python software and press **"Recon WM Edits"**.

For more about white matter edits, see [the official FreeSurfer wiki](http://ftp.nmr.mgh.harvard.edu/fswiki/FsTutorial/WhiteMatterEdits).
