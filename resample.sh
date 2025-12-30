#!/bin/bash

for s in {01..20}
do

mri_synthstrip \
    -i sub-${s}/sub-${s}_ses-01_acq-MPRAGE_run-1_part-mag_T1w.nii.gz \
    -m sub-${s}/sub-${s}_ses-01_acq-MPRAGE_run-1_part-mag_T1w_WBmask.nii.gz

N4BiasFieldCorrection \
    --image-dimensionality 3 \
    --input-image sub-${s}/sub-${s}_ses-01_acq-MPRAGE_run-1_part-mag_T1w.nii.gz \
    --mask-image sub-${s}/sub-${s}_ses-01_acq-MPRAGE_run-1_part-mag_T1w_WBmask.nii.gz \
    --output sub-${s}/sub-${s}_ses-01_acq-MPRAGE_run-1_part-mag_T1w_biascorrected.nii.gz

ImageMath \
    3 \
    sub-${s}/sub-${s}_ses-01_acq-MPRAGE_run-1_part-mag_T1w_biascorrected_brain.nii.gz \
    m \
    sub-${s}/sub-${s}_ses-01_acq-MPRAGE_run-1_part-mag_T1w_biascorrected.nii.gz \
    sub-${s}/sub-${s}_ses-01_acq-MPRAGE_run-1_part-mag_T1w_WBmask.nii.gz

ResampleImage \
    3 \
    sub-${s}/sub-${s}_ses-01_acq-MPRAGE_run-1_part-mag_T1w_WBmask.nii.gz \
    sub-${s}/sub-${s}_ses-01_acq-MPRAGE_run-1_part-mag_T1w_WBmask_iso_1mm3.nii.gz \
    1x1x1 \
    0 1 5

ResampleImage \
    3 \
    sub-${s}/sub-${s}_ses-01_acq-MPRAGE_run-1_part-mag_T1w_biascorrected_brain.nii.gz \
    sub-${s}/sub-${s}_ses-01_acq-MPRAGE_run-1_part-mag_T1w_biascorrected_brain_iso_1mm3.nii.gz \
    1x1x1 \
    0 3 5

ResampleImage \
    3 \
    sub-${s}/sub-${s}_ses-01_acq-EP2D_dir-AP_part-mag_dwi_denoised_eddy_dtifit_S0.nii.gz \
    sub-${s}/sub-${s}_ses-01_acq-EP2D_dir-AP_part-mag_dwi_denoised_eddy_dtifit_S0_iso_1mm3.nii.gz \
    1x1x1 \
    0 3 5

ResampleImage \
    3 \
    sub-${s}/sub-${s}_ses-01_acq-EP2D_dir-AP_part-mag_dwi_denoised_eddy_dtifit_FA.nii.gz \
    sub-${s}/sub-${s}_ses-01_acq-EP2D_dir-AP_part-mag_dwi_denoised_eddy_dtifit_FA_iso_1mm3.nii.gz \
    1x1x1 \
    0 3 6

ResampleImage \
    3 \
    sub-${s}/sub-${s}_ses-01_acq-MPRAGE_run-1_part-mag_T1w_WBmask.nii.gz \
    sub-${s}/sub-${s}_ses-01_acq-MPRAGE_run-1_part-mag_T1w_WBmask_iso_07mm3.nii.gz \
    0.7x0.7x0.7 \
    0 1 5

ResampleImage \
    3 \
    sub-${s}/sub-${s}_ses-01_acq-MPRAGE_run-1_part-mag_T1w_biascorrected_brain.nii.gz \
    sub-${s}/sub-${s}_ses-01_acq-MPRAGE_run-1_part-mag_T1w_biascorrected_brain_iso_07mm3.nii.gz \
    0.7x0.7x0.7 \
    0 3 5

ResampleImage \
    3 \
    sub-${s}/sub-${s}_ses-01_acq-EP2D_dir-AP_part-mag_dwi_denoised_eddy_dtifit_S0.nii.gz \
    sub-${s}/sub-${s}_ses-01_acq-EP2D_dir-AP_part-mag_dwi_denoised_eddy_dtifit_S0_iso_07mm3.nii.gz \
    0.7x0.7x0.7 \
    0 3 5

ResampleImage \
    3 \
    sub-${s}/sub-${s}_ses-01_acq-EP2D_dir-AP_part-mag_dwi_denoised_eddy_dtifit_FA.nii.gz \
    sub-${s}/sub-${s}_ses-01_acq-EP2D_dir-AP_part-mag_dwi_denoised_eddy_dtifit_FA_iso_07mm3.nii.gz \
    0.7x0.7x0.7 \
    0 3 6

antsRegistration \
    --verbose 1 \
    --random-seed 13 \
    --dimensionality 3 \
    --float 1 \
    --collapse-output-transforms 1 \
    --output [ sub-${s}/sub-${s}_ses-01_acq-EP2D_dir-AP_part-mag_dwi_denoised_eddy_dtifit_S0_iso_1mm3_reg2T1_,sub-${s}/sub-${s}_ses-01_acq-EP2D_dir-AP_part-mag_dwi_denoised_eddy_dtifit_S0_iso_1mm3_reg2T1_Warped.nii.gz,sub-${s}/sub-${s}_ses-01_acq-EP2D_dir-AP_part-mag_dwi_denoised_eddy_dtifit_S0_iso_1mm3_reg2T1_InverseWarped.nii.gz ] \
    --interpolation LanczosWindowedSinc \
    --use-histogram-matching 0 \
    --winsorize-image-intensities [ 0.005,0.995 ] \
    --transform Affine[ 0.1 ] \
    --metric MI[ sub-${s}/sub-${s}_ses-01_acq-MPRAGE_run-1_part-mag_T1w_biascorrected_brain_iso_1mm3.nii.gz,sub-${s}/sub-${s}_ses-01_acq-EP2D_dir-AP_part-mag_dwi_denoised_eddy_dtifit_S0_iso_1mm3.nii.gz,1,32,Regular,0.25 ] \
    --convergence [ 1000x500,1e-6,10 ] \
    --shrink-factors 2x1 \
    --smoothing-sigmas 2x0vox

antsApplyTransforms \
    --verbose 1 \
    --dimensionality 3 \
    --float 1 \
    --input-image-type 0 \
    --input sub-${s}/sub-${s}_ses-01_acq-EP2D_dir-AP_part-mag_dwi_denoised_eddy_dtifit_FA_iso_1mm3.nii.gz \
    --reference-image sub-${s}/sub-${s}_ses-01_acq-MPRAGE_run-1_part-mag_T1w_biascorrected_brain_iso_1mm3.nii.gz \
    --output sub-${s}/sub-${s}_ses-01_acq-EP2D_dir-AP_part-mag_dwi_denoised_eddy_dtifit_FA_iso_1mm3_reg2T1_Warped.nii.gz \
    --interpolation LanczosWindowedSinc \
    --transform sub-${s}/sub-${s}_ses-01_acq-EP2D_dir-AP_part-mag_dwi_denoised_eddy_dtifit_S0_iso_1mm3_reg2T1_0GenericAffine.mat

antsRegistration \
    --verbose 1 \
    --random-seed 13 \
    --dimensionality 3 \
    --float 1 \
    --collapse-output-transforms 1 \
    --output [ sub-${s}/sub-${s}_ses-01_acq-EP2D_dir-AP_part-mag_dwi_denoised_eddy_dtifit_S0_iso_07mm3_reg2T1_,sub-${s}/sub-${s}_ses-01_acq-EP2D_dir-AP_part-mag_dwi_denoised_eddy_dtifit_S0_iso_07mm3_reg2T1_Warped.nii.gz,sub-${s}/sub-${s}_ses-01_acq-EP2D_dir-AP_part-mag_dwi_denoised_eddy_dtifit_S0_iso_07mm3_reg2T1_InverseWarped.nii.gz ] \
    --interpolation LanczosWindowedSinc \
    --use-histogram-matching 0 \
    --winsorize-image-intensities [ 0.005,0.995 ] \
    --transform Affine[ 0.1 ] \
    --metric MI[ sub-${s}/sub-${s}_ses-01_acq-MPRAGE_run-1_part-mag_T1w_biascorrected_brain_iso_07mm3.nii.gz,sub-${s}/sub-${s}_ses-01_acq-EP2D_dir-AP_part-mag_dwi_denoised_eddy_dtifit_S0_iso_07mm3.nii.gz,1,32,Regular,0.25 ] \
    --convergence [ 1000x500,1e-6,10 ] \
    --shrink-factors 2x1 \
    --smoothing-sigmas 2x0vox

antsApplyTransforms \
    --verbose 1 \
    --dimensionality 3 \
    --float 1 \
    --input-image-type 0 \
    --input sub-${s}/sub-${s}_ses-01_acq-EP2D_dir-AP_part-mag_dwi_denoised_eddy_dtifit_FA_iso_07mm3.nii.gz \
    --reference-image sub-${s}/sub-${s}_ses-01_acq-MPRAGE_run-1_part-mag_T1w_biascorrected_brain_iso_07mm3.nii.gz \
    --output sub-${s}/sub-${s}_ses-01_acq-EP2D_dir-AP_part-mag_dwi_denoised_eddy_dtifit_FA_iso_07mm3_reg2T1_Warped.nii.gz \
    --interpolation LanczosWindowedSinc \
    --transform sub-${s}/sub-${s}_ses-01_acq-EP2D_dir-AP_part-mag_dwi_denoised_eddy_dtifit_S0_iso_07mm3_reg2T1_0GenericAffine.mat

done