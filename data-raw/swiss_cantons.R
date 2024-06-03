# data source:
# https://www.bfs.admin.ch/bfs/de/home/dienstleistungen/geostat/geodaten-bundesstatistik/administrative-grenzen/generalisierte-gemeindegrenzen.assetdetail.30487000.html

library(sf)

# detail level G2, Kantone (i.e. cantons), data for 2024
# the shp file requires the corresponding .cpg, .dbf, .prj, and .shx files, so those need to be in the same location
swiss_cantons <- read_sf("data-raw/cantons/g2k24.shp")

usethis::use_data(swiss_cantons, overwrite = TRUE, compress = "xz")
