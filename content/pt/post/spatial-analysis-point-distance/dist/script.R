library(tidyverse)
library(sf)
library(geobr)

po <- geobr::read_municipal_seat()
po
plot(po$geom, pch = 20)

# capitais
name_cap <- c("Porto Velho", "Rio Branco", "Manaus", "Boa Vista", "Belém", "Macapá",
              "Palmas", "São Luís", "Teresina", "Fortaleza", "Natal", "João Pessoa",
              "Recife", "Maceió", "Aracaju", "Salvador", "Belo Horizonte", "Vitória",
              "Rio De Janeiro", "São Paulo", "Curitiba", "Florianópolis", "Porto Alegre",
              "Campo Grande", "Cuiabá", "Goiânia", "Brasília")

# estados
name_est_mun <- tibble(
  capitais = c("Porto Velho", "Rio Branco", "Manaus", "Boa Vista", "Belém", "Macapá",
                  "Palmas", "São Luís", "Teresina", "Fortaleza", "Natal", "João Pessoa",
                  "Recife", "Maceió", "Aracaju", "Salvador", "Belo Horizonte", "Vitória",
                  "Rio De Janeiro", "São Paulo", "Curitiba", "Florianópolis", "Porto Alegre",
                  "Campo Grande", "Cuiabá", "Goiânia", "Brasília"),
  estados = c("RO", "AC", "AM", "RR", "PA", "AP", "TO", "MA", "PI", "CE", "RN", "PB", "PE", 
              "AL", "SE", "BA", "MG", "ES", "RJ", "SP", "PR", "SC", "RS", "MS", "MT", "GO", "DF"))
name_est_mun

po_mun_dist <- NULL

# dist
for(i in 1:nrow(name_est_mun)){

  # information
  print(name_est_mun$estados[i])

  # select capital
  po_cap <- po %>%
      dplyr::filter(abbrev_state == name_est_mun$estados[i],
                    name_muni == name_est_mun$capitais[i])

  # select municipality
  po_mun <- po %>%
    dplyr::filter(abbrev_state == name_est_mun$estados[i])

  # distance
  po_mun_dist_i <- po_mun %>%
      dplyr::mutate(dist_km_mau = as.vector(sf::st_distance(po_cap, po_mun)/1e3))

  # combine
  po_mun_dist <- rbind(po_mun_dist, po_mun_dist_i)

}

