(s5p = system.file("sentinel5p/S5P_NRTI_L2__NO2____20180717T120113_20180717T120613_03932_01_010002_20180717T125231.nc", package = "starsdata"))
library(stars)
library(cptcity)
nit.c = read_stars(s5p, sub = "//PRODUCT/SUPPORT_DATA/DETAILED_RESULTS/nitrogendioxide_summed_total_column",
                   curvilinear = c("//PRODUCT/longitude", "//PRODUCT/latitude"), driver = NULL)
plot(nit.c, breaks = "hclust", reset = FALSE, axes = TRUE, as_points = TRUE,
     pch = 16,  logz = TRUE, key.length = 1, col = cpt("arendal_temperature"), downsample = T)
maps::map('world', add = TRUE, col = 'red')


plot(nit.c, breaks = "quantile", reset = FALSE, axes = TRUE, as_points = FALSE,
     border = NA, logz = TRUE, key.length = 1, lty = 0, col = lucky(),
     main = "Sum column NO2 Sentinel 5P")
maps::map('world', add = TRUE, col = 'red')
