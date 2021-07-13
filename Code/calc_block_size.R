library(blockCV)
library(raster)
library(sf)

# import raster data
img <- raster::stack("D:/My_projects/Rhinos_KNP/data/WTWTA_45covs_1000.tif")
img
pts<- read_sf("D:/My_projects/Rhinos_KNP/data/sampled_pts/1km_pts.shp")

img[is.na(img[])] <- 0 

sac <- spatialAutoRange(rasterLayer = img,
                        speciesData = pts,
                        doParallel = TRUE,
                        showPlots = TRUE)


summary(sac)
#st_write(sac, "D:/My_projects/Rhinos_KNP/data/sampled_pts/spatial_blocks.shp")
