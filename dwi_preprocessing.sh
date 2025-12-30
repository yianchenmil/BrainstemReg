#!/bin/bash

for s in {01..20}; do

    topup \
        --imain=sub-${s}/sub-${s}_TOPUP_input.nii.gz \
        --datain=topup.acqparams \
        -config=topup.config \
        --out=sub-${s}/sub-${s}_TOPUP_output \
        --fout=sub-${s}/sub-${s}_TOPUP_fieldmap_in_Hz.nii.gz \
        --iout=sub-${s}/sub-${s}_TOPUP_input_unwarped.nii.gz

    dwidenoise \
        sub-${s}/sub-${s}_ses-01_acq-EP2D_dir-AP_part-mag_dwi.nii.gz \
        sub-${s}/sub-${s}_ses-01_acq-EP2D_dir-AP_part-mag_dwi_denoised.nii.gz

    eddy_cuda10.2 \
        --imain=sub-${s}/sub-${s}_ses-01_acq-EP2D_dir-AP_part-mag_dwi_denoised.nii.gz \
        --mask=sub-${s}/sub-${s}_TOPUP_input_unwarped_Tmean_brainmask.nii.gz \
        --index=eddy.indices \
        --acqp=topup.acqparams \
        --bvecs=sub-${s}/sub-${s}_ses-01_acq-EP2D_dir-AP_part-mag_dwi.bvec \
        --bvals=sub-${s}/sub-${s}_ses-01_acq-EP2D_dir-AP_part-mag_dwi.bval \
        --json=sub-${s}/sub-${s}_ses-01_acq-EP2D_dir-AP_part-mag_dwi.json \
        --topup=sub-${s}/sub-${s}_TOPUP_output \
        --estimate_move_by_susceptibility \
        --repol \
        --ol_type=both \
        --mporder=5 \
        --s2v_niter=5 \
        --s2v_interp=spline \
        --niter=10 \
        --ol_nstd=5 \
        --out=sub-${s}/sub-${s}_ses-01_acq-EP2D_dir-AP_part-mag_dwi_denoised_eddy \
        --cnr_maps \
        --residuals \
        --verbose

    fslmaths \
    sub-${s}/sub-${s}_ses-01_acq-EP2D_dir-AP_part-mag_dwi_denoised_eddy.nii.gz \
    -thr 0 \
    sub-${s}/sub-${s}_ses-01_acq-EP2D_dir-AP_part-mag_dwi_denoised_eddy.nii.gz \
    -odt float

dtifit \
    -k sub-${s}/sub-${s}_ses-01_acq-EP2D_dir-AP_part-mag_dwi_denoised_eddy.nii.gz \
    -o sub-${s}/sub-${s}_ses-01_acq-EP2D_dir-AP_part-mag_dwi_denoised_eddy_dtifit \
    -m sub-${s}/sub-${s}_TOPUP_input_unwarped_Tmean_brainmask.nii.gz \
    -r sub-${s}/sub-${s}_ses-01_acq-EP2D_dir-AP_part-mag_dwi_denoised_eddy.eddy_rotated_bvecs \
    -b sub-${s}/sub-${s}_ses-01_acq-EP2D_dir-AP_part-mag_dwi.bval \
    --save_tensor \
    --kurt \
    --sse \
    --wls
done