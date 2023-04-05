## Control Point Edits
Written by Jen Leagult and Nicola Bautista: https://github.com/Qlab-UDel/qlab/wiki/Control-Point-Edits

## Open Freeview GUI
Freeview is a Freesurfer-based visualization toolkit. You should use our python script to help pull up Freeview, which will then have most of brain tissue overlays needed to assess the data.

*If using Mac Mini 1

First open the python script on the Mac Mini 1 computer with the mnt connected (if it is not connected, notify a lead researcher)

```python /Users/qigroup/mnt/sylvian/blast/data/mri/imaging/scripts/edit_freesurfer_surface_JMS.py```

Designate the directory to where you have the Freesurfer reconstructed data

```/Users/qigroup/mnt/sylvian/sllip/dicom_conversion/derivatives/freesurfer```

*If using Sylvian

First open the python script on the Sylvian computer using Teamview (if Teamview is not working, notify a lead researcher)

```python /home/qigroup/Documents/projects/blast/data/mri/imaging/scripts/edit_freesurfer_surface.py```

Designate the directory to where you have the Freesurfer reconstructed data

```/home/qigroup/Documents/projects/sllip/dicom_conversion/derivatives/freesurfer/```

On either computer:

3. Select the subject, check that the surface was found, and hit OK.
4. Click on the Editing Brain Actions tab
5. Click on the View subject button (be patient, this will take a minute to load)
6. On the left, you will see 3 tabs (Volumes, Surfaces, Point Sets).

**Loading the Necessary Files**

1. Volumes
    - Click on **"Load Volume"** under the "Volumes" tab and go to the folder that contains the MRI volumes (usually called `mri`). Load `orig.mgz` onto FreeView.
    - For `wm.mgz` (which should be loaded) change the Color map from "Grayscale" to "Heat". *Make sure that the `wm` volume is above the `orig` volume.*
    - Play with the opacity of the `wm` volume until you see white/gray matter contrast. 

2. Surfaces
    - Now go under the "Surfaces" tab. Make sure the `lh.white` and `rh.white` surfaces are loaded.
    - If not, click on the icon with the green '+' (Load Surfaces). This time, go to the folder that contains the surfaces (it's usually called `surf`). Load `lh.white` and `rh.white`.

3. Point Sets  
*This is essential to adding control points.*
    - If this is your first time adding control points to this brain, you will be using the `control.dat` file.   
    - If you have previously made a point set for this brain before, click on **"LoadPoint Set"** to load `control.dat` from the `tmp` folder (this should be in the subject folder). Again make sure you select "control points" instead of "way points".

**Adding Control Points**

Click on **"Point Set Edit"** (Action > Point Set Edit OR Command + T) to change your cursor to a point set editor. Now you can add control points to the `wm` volume. Control points are used to include white matter that is not inside the surface - if there's a large area, just put a lot of control points there. Don't try to use control points to get rid of gray matter inside the surface boundary, that's what white matter editing is for.

**Applying Control Point Edits**

In the python software, click **"Recon Control Points"** . This will take ~10 hours, leave it on the queue overnight.
*Always set control points before adjusting White Matter Edits.*
 
**Helpful Shortcuts**

- **PageUp** and **PageDown** are used to go up and down the brain. 
- **Ctrl+Z** works the way you think it does! It's the undo button. 
- Click on a control point while pressing **Shift** to delete an individual point.   
You may find it helpful to toggle (check/uncheck volumes and surfaces) in order to see exactly where the white matter/gray matter boundary is. 

- **Ctrl+V** allows volume toggling
- **Ctrl+F** allows surface toggling
- **Ctrl+C** allows toggling between the two surfaces (make sure you are under surfaces tab to use this one)
- See [the official FreeView wiki](https://surfer.nmr.mgh.harvard.edu/fswiki/FreeviewGuide/FreeviewReference/FreeviewMouseCommands) for more shortcuts

**Next Step:** White Matter Edits
