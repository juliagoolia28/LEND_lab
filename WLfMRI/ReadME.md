## Word Learning from Context (fMRI Version)

### Relabeling DICOM files
Use [this website](https://dicomviewer.net/local?datasources=dicomlocal) to identify which images were obtained

DICOM folder structure:
- sub
  - session 1
    - 3 Plane
    - MPRAGE
    - WLfMRI_1
    - WLfMRI_2
    - WM_1
    - WM_2
   - session_2
     - 3 Plane
     - MPRAGE
     - Resting
     - Langloc
     - Cogflex

### Creating BIDS with Heudiconv

