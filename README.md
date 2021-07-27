# Where the Wild Things Are

## Aim: Predict where rangers should be

## Links to GEE assets
* AOI (KNP): ee.FeatureCollection('users/jdmwhite/KNP_study_area')
* UD_buf_vhf: ee.Image('users/jdmwhite/UD_buf_vhf')
* UD_buf_GPS: ee.Image('users/geethensingh/UD_buf_GPS')
* UD_buf_mean: ee.Image('users/jdmwhite/UD_buf_mean')
* UD_buf_max: ee.Image('users/jdmwhite/UD_buf_max')
* All covariates: ee.Image('users/jdmwhite/WTWTA_covariates')
* All covariates @ 1000m: ee.Image('users/jdmwhite/WTWTA_covariates_1000')
* Selected covariates @ 1000m: ee.Image('users/jdmwhite/WTWTA_covariates_1000_sel')
* retained_vars = c('CHILI',"H_bed_depth",'urban.coverfraction','corr','uniformity','H_fcc','slope','H_carb_org','H_clay','H_text_class','cti','tpi','SANLC','bare.coverfraction','water.seasonal.coverfraction','bio_annP','evi_winter','H_stone','canopy_height','wp','BurnDate_count','SF','grass.coverfraction','tree.coverfraction','elevation','bio_minT','distance_trans_lines','distance_settlements','osm_water','change_abs','change_norm','wcsat','crops.coverfraction','shrub.coverfraction','variance','simpson','stc','N','transition','water.permanent.coverfraction','recurrence','seasonality','distance_roads','spi','bio_Pdq')
* Sampled points: ee.FeatureCollection('users/jdmwhite/buff_sampled_points')
* Spatial grid with id: ee.FeatureCollection('users/geethensingh/WTWTA_grid75457')

## Links to colab notebooks:

* Static workflow: https://colab.research.google.com/drive/1juNNSGE01DY4fC4-WpnQcA5hvz5K4d0C?usp=sharing
* Static variable preparation: https://colab.research.google.com/drive/1CUUWrG9Z2ll38n6O4pR2LBeHfgskMoOe?usp=sharing
* [![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/Geethen/where_the_wild_things_are.git/HEAD)
