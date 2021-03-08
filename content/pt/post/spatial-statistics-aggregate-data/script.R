# packages
library(tidyverse)
library(sf)
library(geobr)
library(tmap)

# brasil
br <- geobr::read_municipality(year = 2018)
br

states <- geobr::read_state(year = 2018)
states

tm_shape(br) +
  tm_fill() +
  tm_shape(states) +
  tm_borders()

# pib
download.file(url = "https://ftp.ibge.gov.br/Pib_Municipios/2018/base/base_de_dados_2010_2018_xls.zip",
              destfile = "base_de_dados_2010_2018_xls.zip", mode = "wb")

pib_2018 <- readxl::read_excel("base_de_dados_2010_2018_xls/PIB dos Municípios - base de dados 2010-2018.xls")
pib_2018

# join
br_join <- dplyr::left_join(br, pib_2018, by = c("code_muni" = "Código do Município"))
br_join

# map
br_join %>% 
  dplyr::filter(Ano == 2017) %>% 
  tm_shape() +
  tm_fill(title = "PIB Per capta", col = "pib_percapta", 
          pal = rev(wesanderson::wes_palette("Zissou1", n = 10, type = "continuous")), 
          n = 10, style = "quantile", alpha = .9)  +
  tm_shape(states, col = "black") +
  tm_borders() +
  tm_text(text = "abbrev_state", )

