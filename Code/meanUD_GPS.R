library(ctmm)
library(parallel)

data(buffalo)

# fit models for first two buffalo
GUESS <- mclapply(buffalo[1:6], function(b) ctmm.guess(b,interactive=FALSE))
FITS <- mclapply(1:6, function(i) ctmm.fit(buffalo[[i]],GUESS[[i]]) )
names(FITS) <- names(buffalo[1:6])

UDS <- akde(buffalo[1:6],FITS)
meanUD = mean(UDS, weights= NULL)
plot(meanUD)

writeRaster(meanUD,"D:/My_projects/Rhinos_KNP/knp_buffalo/meanUD","GTiff",DF="PMF", overwrite=T)

