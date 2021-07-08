#### Load libraries

library(virtualspecies); library(raster); library(rgdal)

#### Load in data
# covariate stack
feat <- raster::stack('data/itf_export.tif')
# knp
knp <- readOGR('data/KNP_study_area/KNP_study_area.shp')

# crop and mask to remove NAs outside of knp boundary
feat_crop <- crop(feat, knp)
feat_crop <- mask(feat_crop, knp)

# check the output
plot(feat_crop[[1]])
plot(knp, add = T)

# Run removeCollinearity function at 0.7 cut off
par(mfrow=c(1,1))

pdf('corr_plot1.pdf', width = 12, height = 8)
non_collinear_vars1 <- virtualspecies::removeCollinearity(feat_crop, multicollinearity.cutoff = 0.7, select.variables = T, sample.points = F,plot = TRUE)
dev.off()

# Select variables manually from viewing plot
retained_vars1 <- c('CHILI',"H_bed_depth",'urban.coverfraction','corr','uniformity','H_fcc',
                   'slope','H_carb_org','H_sand','H_clay','H_text_class','cti','tpi',
                   'SANLC','bare.coverfraction','water.seasonal.coverfraction','H_ph',
                   'bio_annP','evi_winter','evi_summer','H_stone','canopy_height','wp',
                   'BurnDate_count','SF','grass.coverfraction','tree.coverfraction',
                   'elevation','bio_minT','distance_trans_lines','distance_settlements',
                   'osm_water','change_abs','change_norm','ormc','wcsat',
                   'crops.coverfraction','shrub.coverfraction','variance','pielou',
                   'simpson','stc','N','transition','water.permanent.coverfraction',
                   'recurrence','seasonality','distance_roads','spi','bio_Pdq')

# Subset image based on retained variables
feat_sub2 <- subset(feat_crop, retained_vars1)

# Iterate until no more correlations are found
pdf('corr_plot2.pdf', width = 12, height = 8)
non_collinear_vars2 <- virtualspecies::removeCollinearity(feat_sub2, multicollinearity.cutoff = 0.7, select.variables = T, sample.points = F,plot = TRUE)
dev.off()

retained_vars2 <- c('CHILI',"H_bed_depth",'urban.coverfraction','corr','uniformity','H_fcc',
                    'slope','H_carb_org','H_clay','H_text_class','cti','tpi',
                    'SANLC','bare.coverfraction','water.seasonal.coverfraction','H_ph',
                    'bio_annP','evi_winter','H_stone','canopy_height','wp',
                    'BurnDate_count','SF','grass.coverfraction','tree.coverfraction',
                    'elevation','bio_minT','distance_trans_lines','distance_settlements',
                    'osm_water','change_abs','change_norm','wcsat',
                    'crops.coverfraction','shrub.coverfraction','variance',
                    'simpson','stc','N','transition','water.permanent.coverfraction',
                    'recurrence','seasonality','distance_roads','spi','bio_Pdq')

feat_sub3 <- subset(feat_sub2, retained_vars2)

pdf('corr_plot3.pdf', width = 12, height = 8)
non_collinear_vars3 <- virtualspecies::removeCollinearity(feat_sub3, multicollinearity.cutoff = 0.7, select.variables = T, sample.points = F,plot = TRUE)
dev.off()

retained_vars3 <- c('CHILI',"H_bed_depth",'urban.coverfraction','corr','uniformity','H_fcc','slope','H_carb_org','H_clay','H_text_class','cti','tpi','SANLC','bare.coverfraction','water.seasonal.coverfraction','bio_annP','evi_winter','H_stone','canopy_height','wp','BurnDate_count','SF','grass.coverfraction','tree.coverfraction','elevation','bio_minT','distance_trans_lines','distance_settlements','osm_water','change_abs','change_norm','wcsat','crops.coverfraction','shrub.coverfraction','variance','simpson','stc','N','transition','water.permanent.coverfraction','recurrence','seasonality','distance_roads','spi','bio_Pdq')

feat_sub4 <- subset(feat_sub3, retained_vars3)

pdf('corr_plot4.pdf', width = 12, height = 8)
non_collinear_vars4 <- virtualspecies::removeCollinearity(feat_sub4, multicollinearity.cutoff = 0.7, select.variables = T, sample.points = F,plot = TRUE)
dev.off()

# Export final raster stack
writeRaster(feat_sub4, 'data/WTWTA_covariates_1000_sel.tif')

