library(tidyverse)
library(sf)
library(geobr)

po <- geobr::read_municipal_seat()
po

plot(po$geom, pch = 20)

po_sp_cap <- po %>%
  dplyr::filter(name_muni == "São Paulo")
po_sp_cap

po_sp_mun <- po %>%
  dplyr::filter(abbrev_state == "SP",
                !name_muni == "São Paulo")
po_sp_mun

po_sp_mun_dist <- po_sp_mun %>%
  dplyr::mutate(dist_km = as.vector(sf::st_distance(po_sp_cap, po_sp_mun)/1e3))
po_sp_mun_dist
