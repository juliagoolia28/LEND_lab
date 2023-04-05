## SLLIP Group-level Analysis

### Overview
The group level analysis for this study requires that you combine across subjects. Plotting can occur afterwards in either FSL eyes or by using the glass brain scripts developed for this study: <https://github.com/juliagoolia28/sllip/blob/master/mri_analysis/grouplevel_fsl/plotting_glass_brain.ipynb>

### FSL Designs
The FSL design.fsf files for the group level can be designed in many ways. Here we use FLAME 1 to average across a single group for each cope:

![Overall design](https://github.com/juliagoolia28/sllip/blob/master/mri_analysis/grouplevel_fsl/grouplevel_design.png)

#### Interpreting the Tone Output
The design for the TONE condition group level analyses can be found here: <https://github.com/juliagoolia28/sllip/blob/master/mri_analysis/grouplevel_fsl/tone_design.fsf>
Within the output directory 'tone.gfeat' the copes can be interpreted as follows:
- Cope 1 = Tone Structured > Tone Random
- Cope 2 = Tone Random > Tone Structured
- Cope 3 = Tone Overall > Rest

#### Interpreting the Speech Output
The design for the SPEECH condition group level analyses can be found here: <https://github.com/juliagoolia28/sllip/blob/master/mri_analysis/grouplevel_fsl/speech_design.fsf>
Within the output directory 'speech.gfeat' the copes can be interpreted as follows:
- Cope 1 = Speech Random > Speech Structured
- Cope 2 = Speech Structured > Speech Random 
- Cope 3 = Speech Overall > Rest

#### Interpreting the Speech versus Tone Output
The design for the SPEECH versus TONE condition group level analyses can be found here: <https://github.com/juliagoolia28/sllip/blob/master/mri_analysis/grouplevel_fsl/svt_design.fsf>
Within the output directory 'speechvtone.gfeat' the copes can be interpreted as follows:
- Cope 1 = Random > Structured
- Cope 2 = Structured > Random 
- Cope 3 = Speech > Tone

#### Interpreting the Mean Output
The design for the MEAN condition group level analyses can be found here: <https://github.com/juliagoolia28/sllip/blob/master/mri_analysis/grouplevel_fsl/mean_design.fsf>
Within the output directory 'speechvtone.gfeat' the copes can be interpreted as follows:
- Cope 1 = Overall activation in Run 2 > Overall activation in Run 1
- Cope 2 = Overall activation in Run 1 > Overall activation in Run 2
- Cope 3 = Task > Rest
