#!/bin/bash

for s in {01..20}; do
    for res in "07mm3" "1mm3"; do
        for n in "RN_l" "RN_r" "SN_l" "SN_r" "DR"; do

        antsApplyTransforms \
        --verbose 1 \
        --dimensionality 3 \
        --float 1 \
        --input-image-type 0 \
        --input ${IIT_directory}/${n}.nii.gz \
        --reference-image ${Subject_directory}/sub-${s}/sub-${s}_ses-01_acq-MPRAGE_run-1_part-mag_T1w_biascorrected_brain_iso_${res}.nii.gz \
        --output ${Subject_directory}/sub-${s}/${n}_ANTsreg2Subj_Warped_t1_${res}.nii.gz \
        --interpolation GenericLabel \
        --transform ${Subject_directory}/sub-${s}/IITmean_t1_256_deVessel_ANTsreg2T1_BSMasked_fw_${res}_0Warp.nii.gz \
        --transform ${Subject_directory}/sub-${s}/IITmean_t1_256_deVessel_ANTsreg2T1_WBMasked_${res}_1Warp.nii.gz \
        --transform ${Subject_directory}/sub-${s}/IITmean_t1_256_deVessel_ANTsreg2T1_WBMasked_${res}_0GenericAffine.mat 

        antsApplyTransforms \
        --verbose 1 \
        --dimensionality 3 \
        --float 1 \
        --input-image-type 0 \
        --input ${IIT_directory}/${n}.nii.gz \
        --reference-image ${Subject_directory}/sub-${s}/sub-${s}_ses-01_acq-EP2D_dir-AP_part-mag_dwi_denoised_eddy_dtifit_S0_iso_${res}_reg2T1_Warped.nii.gz \
        --output ${Subject_directory}/sub-${s}/${n}_ANTsreg2Subj_Warped_b0_${res}.nii.gz \
        --interpolation GenericLabel \
        --transform ${Subject_directory}/sub-${s}/IITmean_b0_256_deVessel_ANTsreg2B0_BSMasked_fw_${res}_0Warp.nii.gz \
        --transform ${Subject_directory}/sub-${s}/IITmean_t1_256_deVessel_ANTsreg2T1_WBMasked_${res}_1Warp.nii.gz \
        --transform ${Subject_directory}/sub-${s}/IITmean_t1_256_deVessel_ANTsreg2T1_WBMasked_${res}_0GenericAffine.mat 

        antsApplyTransforms \
        --verbose 1 \
        --dimensionality 3 \
        --float 1 \
        --input-image-type 0 \
        --input ${IIT_directory}/${n}.nii.gz \
        --reference-image ${Subject_directory}/sub-${s}/sub-${s}_ses-01_acq-EP2D_dir-AP_part-mag_dwi_denoised_eddy_dtifit_FA_iso_${res}_reg2T1_Warped.nii.gz \
        --output ${Subject_directory}/sub-${s}/${n}_ANTsreg2Subj_Warped_fa_${res}.nii.gz \
        --interpolation GenericLabel \
        --transform ${Subject_directory}/sub-${s}/IITmean_FA_256_deVessel_ANTsreg2FA_BSMasked_fw_${res}_0Warp.nii.gz \
        --transform ${Subject_directory}/sub-${s}/IITmean_t1_256_deVessel_ANTsreg2T1_WBMasked_${res}_1Warp.nii.gz \
        --transform ${Subject_directory}/sub-${s}/IITmean_t1_256_deVessel_ANTsreg2T1_WBMasked_${res}_0GenericAffine.mat 

        antsApplyTransforms \
        --verbose 1 \
        --dimensionality 3 \
        --float 1 \
        --input-image-type 0 \
        --input ${IIT_directory}/${n}.nii.gz \
        --reference-image ${Subject_directory}/sub-${s}/sub-${s}_ses-01_acq-MPRAGE_run-1_part-mag_T1w_biascorrected_brain_iso_${res}.nii.gz \
        --output ${Subject_directory}/sub-${s}/${n}_ANTsreg2Subj_Warped_mv_${res}.nii.gz \
        --interpolation GenericLabel \
        --transform ${Subject_directory}/sub-${s}/IITmean_t1_256_deVessel_ANTsreg2all_BSMasked_fw_${res}_0Warp.nii.gz \
        --transform ${Subject_directory}/sub-${s}/IITmean_t1_256_deVessel_ANTsreg2T1_WBMasked_${res}_1Warp.nii.gz \
        --transform ${Subject_directory}/sub-${s}/IITmean_t1_256_deVessel_ANTsreg2T1_WBMasked_${res}_0GenericAffine.mat 

        done
    done
done

