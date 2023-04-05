## Task Design
The general overall task design of SLLIP is an investigation into whether language input or uptake (SL) across domains is a stronger predictor of vocabulary. This task is a shortened version of the task developed by Dr. Zhenghan Qi examining SL across domains and modalities: <https://github.com/juliagoolia28/qlab/tree/master/experiments/sl-fmri-expt> 

		                  Domain
                      Linguistic    Non-Linguistic
    Modality Auditory Speech (SSL)	Tone (TSL)

Within each condition (SSL & TSL), stimuli were presented in both a "structured" manner (contains statistical regularities) and presented at random (no statistical regularities) in different blocks. The structured condition contained "triplets":

  - The structured mini-blocks were composed of stimuli of the same type, the presentation order of which followed an embedded pattern of four unique triplets, so that the transitional probability within a triplet was 1 and between triplets was 0.25.

  - Each structured mini-block contained eight repetitions of each of the four triplets.

  - In contrast with the structured blocks, the random blocks contained 12 unique sounds different from the structured blocks, ordered pseudo-randomly, so that there were no combinations of three stimulus that were repeated more than once.

  - The transitional probability between stimuli in the random blocks was 0.083.

### Stimuli
#### Auditory Statistical Learning (ASL)
The auditory stimuli were constructed of twelve English syllables (pi,pu,pa,ti,tu.ta,di,du,da,bi,bu,ba) and twelve musical tones (F,G,D,G#,C#,B,C,F#,D#,E,A,A#).

### Design
- Images were ordered in four 4.42-minute (ASL) streams, with each stream comprised of 3 structured and 3 random mini-blocks randomly ordered (randomization described below), and a resting block between two subsequent mini-blocks (total of 6 blank/silent blocks).
- Auditory stimuli SOA = 480 msec
- 96 triplets were presented per run in ASL 
- A total of 288 structured, 288 random, and 72 blank items were presented in one run of ASL.

### Procedure
- Participants watched/listened to the two continuous streams of stimuli described above, while performing a target detection task.
- While listening to the stream of stimuli, participants tracked a target stimulus, and were instructed to press a response button when they heard the target.  
- Within each task, the participant tracked one linguistic target and one non-linguistic target. Targets (4 options for SSL but 2 options for TSL (see note)) are randomly assigned to each individual participants.
- At the beginning of each mini-block, the participant was reminded of the target.
- Response time was recorded.

**ORIGINAL AUDITORY TASK**:<https://github.com/juliagoolia28/qlab/tree/master/experiments/sl-fmri-expt/shortened_fmri/scanner_stim_without_test/auditory> /auditory_runN_N.xlsx

- In Runs 1 & 2, Tone was always random while Speech was always structured
- In Runs 3 & 4, Tone was always structured while Speech was always random

### How to run the experiment:

Download the whole folder of the task that needs to be run. Open the .py file with PsychoPy and enter the parameters as instructed in the .py file.
