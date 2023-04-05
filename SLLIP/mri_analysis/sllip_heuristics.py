import os

def create_key(template, outtype=('nii.gz','dicom'), annotation_classes=None):
    if template is None or not template:
        raise ValueError('Template must be a valid format string')
    return (template, outtype, annotation_classes)


def infotodict(seqinfo):
    """Heuristic evaluator for determining which runs belong where
    allowed template fields - follow python string module:
    item: index within category
    subject: participant id
    seqitem: run number during scanning
    subindex: sub index within group
    """
    t1 = create_key('sub-{subject}/anat/sub-{subject}_T1w')
    rest = create_key('sub-{subject}/func/sub-{subject}_task-rest_run-{item:02d}_bold')
    asl = create_key('sub-{subject}/func/sub-{subject}_task-asl_run-{item:02d}_bold')

    phasediff_rest = create_key('sub-{subject}/fmap/sub-{subject}_acq-rest_run-{item:02d}_phasediff')
    mag_rest = create_key('sub-{subject}/fmap/sub-{subject}_acq-rest_run-{item:02d}_magnitude')
    phasediff_sl = create_key('sub-{subject}/fmap/sub-{subject}_acq-sl_run-{item:02d}_phasediff')
    mag_sl = create_key('sub-{subject}/fmap/sub-{subject}_acq-sl_run-{item:02d}_magnitude')

    info = {t1:[], rest:[], asl:[], phasediff_rest:[], mag_rest:[]}

    for idx, s in enumerate(seqinfo):
        if (s.dim3 == 352) and (s.dim4 == 1) and ('T1' in s.protocol_name):
            info[t1] = [s.series_id]
        if (s.dim4 == 766) and ('ep2d_bold_sms_abcd' in s.protocol_name):
            info[rest].append({'item': s.series_id})
        if (s.dim4 == 1) and (s.dim3 == 130) and ('gre_field_mapping_2.4mm' in s.protocol_name):
            info[phasediff_rest].append({'item': s.series_id})
        if (s.dim4 == 1) and (s.dim3 == 260) and ('gre_field_mapping_2.4mm' in s.protocol_name):
            info[mag_rest].append({'item': s.series_id})
        if (s.dim4 >= 230) and (not s.is_motion_corrected) and ('asl' in s.protocol_name):
            info[asl].append({'item': s.series_id})
    return info
