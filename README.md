# Optimal Brainstem Registration Pipeline

A comprehensive neuroimaging processing pipeline for optimizing brainstem structure registration using multi-modal MRI data (T1-weighted and diffusion-weighted imaging). This repository implements methods for high-precision registration of small brainstem nuclei including the substantia nigra, red nucleus, and dorsal raphe.

## Overview

Accurate registration of brainstem structures is challenging due to their small size, low contrast, and susceptibility to imaging artifacts. This pipeline evaluates multiple registration strategies to identify optimal parameters for brainstem nuclei localization, comparing:

- **Single-modality vs. multi-modal registration** (T1w, DWI-B0, DWI-FA, or combined)
- **Whole-brain vs. region-focused registration** (with brainstem/thalamus masking)
- **Isotropic resolutions** (1.0 mm³ vs. 0.7 mm³)

The pipeline uses the IIT Human Brain Atlas template and implements a hierarchical registration approach with both whole-brain and brainstem-focused refinement stages.

## Scientific Background

Brainstem nuclei play critical roles in motor control, arousal, and mood regulation. Precise localization of structures like:
- **Substantia Nigra (SN)**: Dopaminergic neurons involved in motor control
- **Red Nucleus (RN)**: Motor coordination and integration
- **Dorsal Raphe (DR)**: Serotonergic modulation

is essential for research in Parkinson's disease, depression, sleep disorders, and deep brain stimulation targeting. Traditional whole-brain registration often fails to accurately align these small, low-contrast structures, motivating specialized registration strategies.

## Features

- **Multi-stage DWI preprocessing** with TOPUP distortion correction, denoising, and eddy current correction
- **Bias field correction and brain extraction** for T1-weighted images
- **Multi-resolution registration** testing at 1mm³ and 0.7mm³ isotropic resolutions
- **Hierarchical registration framework**:
  - Initial whole-brain affine and deformable registration
  - Brainstem-focused refinement with region-specific masking
- **Multi-modal registration optimization** combining T1w, B0, and FA contrasts
- **Automated ROI transformation** from template to subject space
- **Comparison of registration strategies** for optimal brainstem alignment

## Repository Structure

```
BrainstemReg/
├── dwi_preprocessing.sh       # DWI preprocessing pipeline (TOPUP, eddy, DTI fitting)
├── resample.sh                # Image resampling and initial DWI-to-T1 registration
├── transformOptimization.sh   # Core multi-stage registration optimization
└── roiTransform.sh           # Apply optimized transforms to brainstem ROIs
```

## Dependencies

### Required Software

- **FSL** (≥6.0): TOPUP, eddy, dtifit, fslmaths
  - CUDA-enabled eddy for GPU acceleration (eddy_cuda10.2)
- **ANTs** (≥2.3): antsRegistration, antsApplyTransforms, antsRegistrationSyNQuick.sh
- **ANTs utilities**: N4BiasFieldCorrection, ImageMath, ResampleImage
- **FreeSurfer** (≥7.0): mri_synthstrip (deep learning brain extraction)
- **MRtrix3**: dwidenoise (for DWI denoising)

### Data Requirements

1. **Subject data** (BIDS-compliant directory structure):
   - T1-weighted MPRAGE images (`*_T1w.nii.gz`)
   - Diffusion-weighted images (`*_dwi.nii.gz`) with `.bval` and `.bvec` files
   - Reverse phase-encode images for TOPUP distortion correction
   - FreeSurfer segmentation-derived brainstem/thalamus masks

2. **Template data** (IIT Human Brain Atlas):
   - `IITmean_t1_256_deVessel.nii.gz`: T1w template
   - `IITmean_b0_256_deVessel.nii.gz`: B0 template
   - `IITmean_FA_256_deVessel.nii.gz`: FA template
   - Brainstem nucleus ROIs: `RN_l.nii.gz`, `RN_r.nii.gz`, `SN_l.nii.gz`, `SN_r.nii.gz`, `DR.nii.gz`

3. **Configuration files**:
   - `topup.acqparams`: Acquisition parameters for TOPUP
   - `topup.config`: TOPUP configuration file
   - `eddy.indices`: Index file for eddy correction

### Environment Variables

Set these variables before running the scripts:

```bash
export Subject_directory=/path/to/subjects
export IIT_directory=/path/to/IIT_template
```

## Citation

If you use this pipeline in your research, please cite:

[Optimal brainstem registration methods](https://www.frontiersin.org/journals/neuroscience/articles/10.3389/fnins.2026.1711863)

## Data Availability

### Source Data

The data that supports the findings of this study are available from the corresponding author upon reasonable request and following execution of an institutional Data/Material Transfer Agreement.

### Derivative Data

Derivative data generated from this pipeline can be found at: [https://doi.org/10.17605/OSF.IO/TBDGF](https://doi.org/10.17605/OSF.IO/TBDGF)

## Contact

For questions, issues, or collaboration inquiries, please:
- Open an issue on GitHub
- Contact: [Contact information to be added]

## Acknowledgments

- IIT Human Brain Atlas team for the template and ROI definitions
- ANTs development team for the registration framework
- FSL team for diffusion processing tools
- FreeSurfer team for anatomical segmentation tools

---

**Last Updated**: 2026-02-09