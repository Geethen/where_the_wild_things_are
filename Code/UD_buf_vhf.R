#### Libraries ----
library(ctmm)

# https://rdrr.io/cran/ctmm/f/vignettes/akde.Rmd
# For looping and using mean UD: https://groups.google.com/g/ctmm-user/c/AAutnyo3Z9o/m/UY-jjdK-AQAJ 
# For creating list of animal models: https://rdrr.io/cran/ctmm/man/overlap.html

# Workflow --> ctmm.guess --> ctmm.select --> fitted.mods[[1]] (extract best model) --> akde --> mean (weights?)
# Things to add that currently aren't there... ctmm.select --> best model --> weights for mean

# start time
start_time <- Sys.time()

#### Load data & convert to telemetry ----
buf_vhf <- as.telemetry('data/KNP_buff/Kruger Buffalo, VHF Herd Tracking, South Africa.csv')

# Explore data
# length of each list
buf_vhf_nrow <- sapply(buf_vhf, nrow)

buf_names <- names(buf_vhf)

##### Explore buf_vhf ----
# for(i in length()){
#   min <- as.Date('2000-01-01', "%Y-%m-%d")
#   max <- as.Date('2007-01-01', "%Y-%m-%d")
#   
#   ggplot(buf_vhf[[i]]) +
#     geom_rug(aes(x = as.Date(timestamp)), length = unit(0.5, 'npc')) +
#     scale_x_date(limits = c(min, max), breaks = c('1 year')) +
#     ggtitle(paste0(i,'; ','nrows = ',nrow(buf_vhf[[i]]))) +
#     theme_bw()
#   
#   ggsave(paste0('output/vhf_timestamps/',i,'.pdf'), width = 7.15, height = 2)
# }

##### Clean buf data ----

# Remove values lower than 30?
rm_indiv <- which(sapply(buf_vhf, nrow) < 30)
buf_vhf <- buf_vhf[-rm_indiv]

# Sampling intervals?
min(diff(buf_vhf$Allison$timestamp))

#### Run on all Buf ----
GUESS <- lapply(buf_vhf, function(b) ctmm.guess(b,interactive=FALSE) )
# using ctmm.fit here for speed, but you should almost always use ctmm.select
FITS <- lapply(seq_along(buf_vhf), function(i) ctmm.fit(buf_vhf[[i]],GUESS[[i]]) )
names(FITS) <- names(buf_vhf)

# Gaussian overlap between these two buffalo
overlap(FITS)

# AKDE overlap between these two buffalo
# create aligned UDs
UDS <- akde(buf_vhf,FITS)
# evaluate overlap
overlap(UDS)
# compute mean
mean_UD <- mean(UDS)

##### Exports ----

# UD plot
png('output/UD_plots/mean_UD_VHF.png', height = 16.2, width = 18, units = 'cm', res = 400)
plot(mean_UD, main = 'mean_UD')
dev.off()

# Extract raster
mean_UD_rast <- ctmm::raster(mean_UD, DF = 'PMF', level.UD = 0.95, level = 0.95)
raster::plot(mean_UD_rast)

# Write raster
raster::writeRaster(mean_UD_rast, filename = 'output/UD_raster/mean_UD_VHF.tiff', overwrite = TRUE)

# How long did this take?
# end time
end_time <- Sys.time()
# time difference
time_taken <- end_time - start_time
# save for later reference
writeLines(c('time taken:', time_taken), 'output/time_taken.txt')
