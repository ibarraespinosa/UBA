# ------------------------------------#
# Precipitacion y temperatura medias  #
#         Verano y invierno           #
#       (very simple analysis)        #
# ------------------------------------#

library(raster)
library(cptcity)

path <- "dados"

# DJF - VERANO: ####

# Open the precipitation file:
pcp_era5 <- brick("dados/r_ERA5_pcp_DJF_1985-2004.nc")
# Print information:
pcp_era5 # This file has 17 layers (years)
# Plot the 1st time/year:
plot(pcp_era5[[1]]*3600)      # *3600 to obtain mm/h
# Calculate the mean:
mean_pcp_era <- mean(pcp_era5*3600)

# Opening CMIP5 data model: HadGEM2-ES\
pcp_historical <- brick(paste0(path, "dados/pr_Amon_HadGEM2-ES_historical_r1i1p1_DJF_1985-2004.nc"))
plot(pcp_historical[[1]]*3600)
mean_pcp_historical <- mean(pcp_historical*3600)
plot(mean_pcp_historical[[1]]*3600,
     main = "HadGEM2-ES mean precipitation [mm/h] \n DJF (1985 - 2004)")

a <- spplot(mean_pcp_era, interpolate = T,
            main = "Observed Precipitation [mm/h] (ERA5) \n DJF (1985 - 2004)",
            at = seq(0, 4, 0.1),
            col.regions = cpt("ncl_precip2_17lev"))
b <- spplot(mean_pcp_historical,
            main = "Simulated precipitation [mm/h] (HadGEM2-ES) \n DJF (1985 - 2004)",
            at = seq(0, 4, 0.1),
            col.regions = cpt("ncl_precip2_17lev"))
gridExtra::grid.arrange(a, b, ncol = 2)

# Temperature ####
t2m_era5 <- brick(paste0(path, "r_ERA5_t2m_DJF_1985-2004.nc"))
t2m_era5
plot(t2m_era5[[1]] - 273.15)      # -273.15 to obtain ºC
mean_t2m_era <- mean(t2m_era5 -273.15)

t2m_historical <- brick(paste0(path, "tas_Amon_HadGEM2-ES_historical_r1i1p1_DJF_1985-2004.nc"))
plot(t2m_historical[[1]] - 273.15)
mean_t2m_historical <- mean(t2m_historical - 273.15)

c <- spplot(mean_t2m_era,
            main = "Observed temperature at 2m [ºC] (ERA5) \n DJF (1985 - 2004)",
            at = seq(-40, 40, 1),
            col.regions = cpt("ncl_temp_diff_18lev"))
d <- spplot(mean_t2m_historical,
            main = "Simulated temperature at 2m [ºC] (HadGEM2-ES) \n DJF (1985 - 2004)",
            at = seq(-40, 40, 1),
            col.regions = cpt("ncl_temp_diff_18lev"))
gridExtra::grid.arrange(c, d, ncol = 2)


# Calculate the bias (how model is different from the observation):
pcp_bias <- (mean_pcp_historical - mean_pcp_era)
t2m_bias <- (mean_t2m_historical - mean_t2m_era)


f <- spplot(pcp_bias,
            main = "Precipitation bias [mm/h] \n DJF (1985 - 2004)",
            at = seq(-3, 3, 0.1),
            col.regions = cpt("ncl_precip_diff_12lev"))
g <- spplot(t2m_bias,
            main = "Temperature bias [ºC] \n DJF (1985 - 2004)",
            at = seq(-15, 15, 1),
            col.regions = cpt("ncl_temp_diff_18lev"))
gridExtra::grid.arrange(f, g, ncol = 2)


gridExtra::grid.arrange(a, b, f,
                        c, d, g,  ncol = 3)


# JJA - invierno: ####
# Try it by your self.

