#! /bin/bash

for s in {01..20}; do
    for res in "07mm3" "1mm3"; do

    antsRegistrationSyNQuick.sh \
    -d 3 \
    -p f \
    -j 1 \
    -e 13 \
    -n 20 \
    -t a \
    -f ${Subject_directory}/sub-${s}/sub-${s}_ses-01_acq-MPRAGE_run-1_part-mag_T1w_biascorrected_brain_iso_${res}.nii.gz \
    -m ${IIT_directory}/IITmean_t1_256_deVessel.nii.gz \
    -o ${Subject_directory}/sub-${s}/IITmean_t1_256_deVessel_initial_matrix_for_sub-${s}_${res}_
    
    antsRegistration \
    --verbose 1 \
    --random-seed 13 \
    --dimensionality 3 \
    --float 1 \
    --collapse-output-transforms 1 \
    --output [ ${Subject_directory}/sub-${s}/IITmean_t1_256_deVessel_ANTsreg2T1_WBMasked_${res}_,${Subject_directory}/sub-${s}/IITmean_t1_256_deVessel_ANTsreg2T1_WBMasked_${res}_Warped.nii.gz,${Subject_directory}/sub-${s}/IITmean_t1_256_deVessel_ANTsreg2T1_WBMasked_${res}_InverseWarped.nii.gz ] \
    --interpolation LanczosWindowedSinc \
    --use-histogram-matching 1 \
    --winsorize-image-intensities [ 0.005,0.995 ] \
    -x [ ${Subject_directory}/sub-${s}/sub-${s}_ses-01_acq-MPRAGE_run-1_part-mag_T1w_WBmask_iso_${res}.nii.gz, NULL ] \
    --initial-moving-transform ${Subject_directory}/sub-${s}/IITmean_t1_256_deVessel_initial_matrix_for_sub-${s}_${res}_0GenericAffine.mat \
    --transform Rigid[ 0.1 ] \
    --metric MI[ ${Subject_directory}/sub-${s}/sub-${s}_ses-01_acq-MPRAGE_run-1_part-mag_T1w_biascorrected_brain_iso_${res}.nii.gz,${IIT_directory}/IITmean_t1_256_deVessel.nii.gz,1,32,Regular,0.25 ] \
    --convergence [ 1000x500x250x100,1e-6,10 ] \
    --shrink-factors 12x8x4x2 \
    --smoothing-sigmas 4x3x2x1vox \
    -x [ ${Subject_directory}/sub-${s}/sub-${s}_ses-01_acq-MPRAGE_run-1_part-mag_T1w_WBmask_iso_${res}.nii.gz, NULL ] \
    --transform Affine[ 0.1 ] \
    --metric MI[ ${Subject_directory}/sub-${s}/sub-${s}_ses-01_acq-MPRAGE_run-1_part-mag_T1w_biascorrected_brain_iso_${res}.nii.gz,${IIT_directory}/IITmean_t1_256_deVessel.nii.gz,1,32,Regular,0.25 ] \
    --convergence [ 1000x500x250x100,1e-6,10 ] \
    --shrink-factors 12x8x4x2 \
    --smoothing-sigmas 4x3x2x1vox \
    -x [ ${Subject_directory}/sub-${s}/sub-${s}_ses-01_acq-MPRAGE_run-1_part-mag_T1w_WBmask_iso_${res}.nii.gz, NULL ] \
    --transform SyN[ 0.1,3,0 ] \
    --metric CC[ ${Subject_directory}/sub-${s}/sub-${s}_ses-01_acq-MPRAGE_run-1_part-mag_T1w_biascorrected_brain_iso_${res}.nii.gz,${IIT_directory}/IITmean_t1_256_deVessel.nii.gz,1,4 ] \
    --convergence [ 100x100x70x50x20,1e-6,10 ] \
    --shrink-factors 10x6x4x2x1 \
    --smoothing-sigmas 5x3x2x1x0vox 

    antsApplyTransforms \
	--verbose 1 \
	--dimensionality 3 \
	--float 1 \
	--input-image-type 0 \
	--input ${IIT_directory}/IITmean_b0_256_deVessel.nii.gz \
	--reference-image ${Subject_directory}/sub-${s}/sub-${s}_ses-01_acq-MPRAGE_run-1_part-mag_T1w_biascorrected_brain_iso_${res}.nii.gz \
	--output ${Subject_directory}/sub-${s}/IITmean_b0_256_deVessel_ANTsreg2T1_WBMasked_${res}_Warped.nii.gz \
	--interpolation LanczosWindowedSinc \
    --transform ${Subject_directory}/sub-${s}/IITmean_t1_256_deVessel_ANTsreg2T1_WBMasked_${res}_1Warp.nii.gz \
	--transform ${Subject_directory}/sub-${s}/IITmean_t1_256_deVessel_ANTsreg2T1_WBMasked_${res}_0GenericAffine.mat 
    
    antsApplyTransforms \
	--verbose 1 \
	--dimensionality 3 \
	--float 1 \
	--input-image-type 0 \
	--input ${IIT_directory}/IITmean_FA_256_deVessel.nii.gz \
	--reference-image ${Subject_directory}/sub-${s}/sub-${s}_ses-01_acq-MPRAGE_run-1_part-mag_T1w_biascorrected_brain_iso_${res}.nii.gz \
	--output ${Subject_directory}/sub-${s}/IITmean_FA_256_deVessel_ANTsreg2T1_WBMasked_${res}_Warped.nii.gz \
	--interpolation LanczosWindowedSinc \
    --transform ${Subject_directory}/sub-${s}/IITmean_t1_256_deVessel_ANTsreg2T1_WBMasked_${res}_1Warp.nii.gz \
	--transform ${Subject_directory}/sub-${s}/IITmean_t1_256_deVessel_ANTsreg2T1_WBMasked_${res}_0GenericAffine.mat 

    antsRegistration \
    --verbose 1 \
    --random-seed 13 \
    --dimensionality 3 \
    --float 1 \
    --collapse-output-transforms 1 \
    --output [ ${Subject_directory}/sub-${s}/IITmean_t1_256_deVessel_ANTsreg2T1_BSMasked_fw_${res}_,${Subject_directory}/sub-${s}/IITmean_t1_256_deVessel_ANTsreg2T1_BSMasked_fw_${res}_Warped.nii.gz,${Subject_directory}/sub-${s}/IITmean_t1_256_deVessel_ANTsreg2T1_BSMasked_fw_${res}_InverseWarped.nii.gz ] \
    -x [ ${Subject_directory}/sub-${s}/sub-${s}_FS_ThalBSmask_fslreoriented_iso_${res}_dil.nii.gz, NULL ] \
    --transform SyN[ 0.1,3,0 ] \
    --metric CC[ ${Subject_directory}/sub-${s}/sub-${s}_ses-01_acq-MPRAGE_run-1_part-mag_T1w_biascorrected_brain_iso_${res}.nii.gz,${Subject_directory}/sub-${s}/IITmean_t1_256_deVessel_ANTsreg2T1_WBMasked_${res}_Warped.nii.gz,1,4 ] \
    --convergence [ 50x20,1e-6,10 ] \
    --shrink-factors 2x1 \
    --smoothing-sigmas 2x0vox

    antsRegistration \
    --verbose 1 \
    --random-seed 13 \
    --dimensionality 3 \
    --float 1 \
    --collapse-output-transforms 1 \
    --output [ ${Subject_directory}/sub-${s}/IITmean_b0_256_deVessel_ANTsreg2B0_BSMasked_fw_${res}_,${Subject_directory}/sub-${s}/IITmean_b0_256_deVessel_ANTsreg2B0_BSMasked_fw_${res}_Warped.nii.gz,${Subject_directory}/sub-${s}/IITmean_b0_256_deVessel_ANTsreg2B0_BSMasked_fw_${res}_InverseWarped.nii.gz ] \
    -x [ ${Subject_directory}/sub-${s}/sub-${s}_FS_ThalBSmask_fslreoriented_iso_${res}_dil.nii.gz, NULL ] \
    --transform SyN[ 0.1,3,0 ] \
    --metric CC[ ${Subject_directory}/sub-${s}/sub-${s}_ses-01_acq-EP2D_dir-AP_part-mag_dwi_denoised_eddy_dtifit_S0_iso_${res}_reg2T1_Warped.nii.gz,${Subject_directory}/sub-${s}/IITmean_b0_256_deVessel_ANTsreg2T1_WBMasked_${res}_Warped.nii.gz,1,4 ] \
    --convergence [ 50x20,1e-6,10 ] \
    --shrink-factors 2x1 \
    --smoothing-sigmas 2x0vox

    antsRegistration \
    --verbose 1 \
    --random-seed 13 \
    --dimensionality 3 \
    --float 1 \
    --collapse-output-transforms 1 \
    --output [ ${Subject_directory}/sub-${s}/IITmean_FA_256_deVessel_ANTsreg2FA_BSMasked_fw_${res}_,${Subject_directory}/sub-${s}/IITmean_FA_256_deVessel_ANTsreg2FA_BSMasked_fw_${res}_Warped.nii.gz,${Subject_directory}/sub-${s}/IITmean_FA_256_deVessel_ANTsreg2FA_BSMasked_fw_${res}_InverseWarped.nii.gz ] \
    -x [ ${Subject_directory}/sub-${s}/sub-${s}_FS_ThalBSmask_fslreoriented_iso_${res}_dil.nii.gz, NULL ] \
    --transform SyN[ 0.1,3,0 ] \
    --metric CC[ ${Subject_directory}/sub-${s}/sub-${s}_ses-01_acq-EP2D_dir-AP_part-mag_dwi_denoised_eddy_dtifit_FA_iso_${res}_reg2T1_Warped.nii.gz,${Subject_directory}/sub-${s}/IITmean_FA_256_deVessel_ANTsreg2T1_WBMasked_${res}_Warped.nii.gz,1,4 ] \
    --convergence [ 50x20,1e-6,10 ] \
    --shrink-factors 2x1 \
    --smoothing-sigmas 2x0vox

    antsRegistration \
    --verbose 1 \
    --random-seed 13 \
    --dimensionality 3 \
    --float 1 \
    --collapse-output-transforms 1 \
    --output [ ${Subject_directory}/sub-${s}/IITmean_t1_256_deVessel_ANTsreg2all_BSMasked_fw_${res}_,${Subject_directory}/sub-${s}/IITmean_t1_256_deVessel_ANTsreg2all_BSMasked_fw_${res}_Warped.nii.gz,${Subject_directory}/sub-${s}/IITmean_t1_256_deVessel_ANTsreg2all_BSMasked_fw_${res}_InverseWarped.nii.gz ] \
    -x [ ${Subject_directory}/sub-${s}/sub-${s}_FS_ThalBSmask_fslreoriented_iso_${res}_dil.nii.gz, NULL ] \
    --transform SyN[ 0.1,3,0 ] \
    --metric CC[ ${Subject_directory}/sub-${s}/sub-${s}_ses-01_acq-MPRAGE_run-1_part-mag_T1w_biascorrected_brain_iso_${res}.nii.gz,${Subject_directory}/sub-${s}/IITmean_t1_256_deVessel_ANTsreg2T1_WBMasked_${res}_Warped.nii.gz,1,4 ] \
    --metric CC[ ${Subject_directory}/sub-${s}/sub-${s}_ses-01_acq-EP2D_dir-AP_part-mag_dwi_denoised_eddy_dtifit_S0_iso_${res}_reg2T1_Warped.nii.gz,${Subject_directory}/sub-${s}/IITmean_b0_256_deVessel_ANTsreg2T1_WBMasked_${res}_Warped.nii.gz,1,4 ] \
    --metric CC[ ${Subject_directory}/sub-${s}/sub-${s}_ses-01_acq-EP2D_dir-AP_part-mag_dwi_denoised_eddy_dtifit_FA_iso_${res}_reg2T1_Warped.nii.gz,${Subject_directory}/sub-${s}/IITmean_FA_256_deVessel_ANTsreg2T1_WBMasked_${res}_Warped.nii.gz,1,4 ] \
    --convergence [ 50x20,1e-6,10 ] \
    --shrink-factors 2x1 \
    --smoothing-sigmas 2x0vox

    done
done