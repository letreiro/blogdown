---
title: Gerando rasters de dados socio-econômicos
author: mauriciovancine
date: "2021-03-23"
slug: []
categories: [spatial,rspatial]
tags: [spatial,rspatial]
subtitle: ""
summary: "Um passo a passo para gerar rasters de dados socio-econômicos para municípios do Brasil"
authors: []
lastmod: r`Sys.time()`
featured: no
image:
  caption: "[Imagem de OpenClipart-Vectors](https://pixabay.com/pt/vectors/minecraft-bloco-de-constru%C3%A7%C3%A3o-bloco-154749/)"
  focal_point: "center"
  preview_only: no
projects: []
---



## Contextualização

Faz um tempo que interajo com o povo da Universidade Federal Rural de Pernambuco (UFRPE) de Recife, mas especificamente do Lab. [ECOFFUN](https://thiagocalvesouza.wixsite.com/ecoffun) do Prof. Thiago Gonçalves-Souza, também conhecido como Toyoyo. 

Mais recentemente um dos seus alunos, o Arthur, que inclusive revisou esse post, comentou que precisava de variáveis socio-econômicas para usar em Modelos de Distribuição de Espécies para modelar doenças no Brasil, um projeto super interessante. Bem, como preparei um script para isso, resolvi escrever um post do passo a passo de como estruturamos.

A ideia aqui será baixar dados sócio-econômicos do [**Sistema IBGE de Recuperação Automática - SIDRA**](https://sidra.ibge.gov.br), fazer a associação para os polígonos dos municípios e depois rasterizar com base em uma variável do WorldClim.

Para fazer esses passos, vamos precisar desses pacotes.


```r
# packages
library(tidyverse)
library(sidrar)
library(geobr)
library(raster)
library(fasterize)
library(tmap)
```

## Dados tabulares

Primeiramente, vamos usar o pacote [*sidrar*](https://cran.r-project.org/web/packages/sidrar/index.html), que é uma interface para o API do SIDRA. Esse pacote possui três funções:

1. `sidrar::search_sidra()`: pesquisa tabelas do SIDRA com determinado(s) termo(s)
1. `sidrar::info_sidra()`: lista as variáveis de uma tabela do SIDRA
1. `sidrar::get_sidra()`: faz o download de uma tabela do SIDRA

O banco de dados do SIDRA é absurdamente enorme. Aqui vou explorar apenas uma tabela, mas existem muitas possibilidades para explorar.

Vamos começar procurando tabelas com o termo "abastecimento".


```r
# search
sidrar::search_sidra("abastecimento")[1:5]
```

```
## [1] "Tabela 160 - Domicílios por condição de ocupação, abastecimento de água, tipo de domicílio, instalação sanitária e número de famílias"                      
## [2] "Tabela 175 - Pessoas moradoras em domicílios particulares permanentes por situação e abastecimento de água"                                                 
## [3] "Tabela 177 - Domicílios por classes de recebimento mensal domiciliar, abastecimento de água, tipo de domicílio, instalação sanitária e número de famílias"  
## [4] "Tabela 179 - Domicílios particulares permanentes por situação e abastecimento de água"                                                                      
## [5] "Tabela 256 - Domicílios particulares permanentes por instalação sanitária, abastecimento de água, localização, tipo de cobertura, tipo de parede e situação"
```

Vou selecionar a tabela "Tabela 3218: Domicílios particulares permanentes, por forma de abastecimento de água, segundo a existência de banheiro ou sanitário e esgotamento sanitário, o destino do lixo e a existência de energia elétrica".


```r
# information
sidrar::info_sidra(x = 3218) %>% names()
```

```
## [1] "table"              "period"             "variable"          
## [4] "classific_category" "geo"
```

```r
# classific category
sidrar::info_sidra(x = 3218)$classific_category %>% names()
```

```
## [1] "c61 = Forma de abastecimento de água (8):"                              
## [2] "c299 = Existência de banheiro ou sanitário e esgotamento sanitário (8):"
## [3] "c67 = Destino do lixo (5):"                                             
## [4] "c309 = Existência de energia elétrica (3):"
```

Agora começam as complicações, pois o API só permite o download de 50000 linhas de dados (foi o que entendi até o momento). Então, tive que ir fazendo download específicos para as diferentes categorias.


```r
# get data
da_agua <- sidrar::get_sidra(x = 3218,
                             variable = 1000096,
                             period = "last",
                             classific = c("c61"),
                             geo = "City")

da_banheiro <- sidrar::get_sidra(x = 3218,
                                 variable = 1000096,
                                 period = "last",
                                 classific = c("c299"),
                                 geo = "City")

da_lixo <- sidrar::get_sidra(x = 3218,
                             variable = 1000096,
                             period = "last",
                             classific = c("c67"),
                             geo = "City")

da_luz <- sidrar::get_sidra(x = 3218,
                            variable = 1000096,
                            period = "last",
                            classific = c("c309"),
                            geo = "City")
```

Podemos olhar esses dados usando a função `dplyr::glimpse()`.


```r
# glimpse
dplyr::glimpse(da_agua)
dplyr::glimpse(da_banheiro)
dplyr::glimpse(da_lixo)
dplyr::glimpse(da_luz)
```

Para facilitar nossa vida com as variáveis, fiz alguns filtros, transformei os dados, selecionei colunas e renomei outras para que a associação com os municípios fosse mais simples. No final, combinei as colunas para simplificar os dados em um único `tibble`.


```r
# filter and selection
da_agua_sel <- da_agua %>% 
  dplyr::filter(`Forma de abastecimento de água` == "Rede geral") %>% 
  dplyr::mutate(code_muni = as.numeric(`Município (Código)`)) %>%
  dplyr::select(code_muni, Valor) %>% 
  dplyr::rename(agua_rede = Valor)

da_banheiro_sel <- da_banheiro %>% 
  dplyr::filter(`Existência de banheiro ou sanitário e esgotamento sanitário` == "Não tinham banheiro nem sanitário") %>% 
  dplyr::mutate(code_muni = as.numeric(`Município (Código)`)) %>%
  dplyr::select(code_muni, Valor) %>%
  dplyr::rename(sem_banheiro = Valor)

da_lixo_sel <- da_lixo %>% 
  dplyr::filter(`Destino do lixo` == "Coletado") %>% 
  dplyr::mutate(code_muni = as.numeric(`Município (Código)`)) %>%
  dplyr::select(code_muni, Valor) %>%
  dplyr::rename(lixo_coletado = Valor)

da_luz_sel <- da_luz %>% 
  dplyr::filter(`Existência de energia elétrica` == "Tinham") %>% 
  dplyr::mutate(code_muni = as.numeric(`Município (Código)`)) %>%
  dplyr::select(code_muni, Valor) %>%
  dplyr::rename(luz = Valor)

da_data <- dplyr::bind_cols(da_agua_sel, 
                            sem_banheiro = da_banheiro_sel$sem_banheiro, 
                            lixo_coletado = da_lixo_sel$lixo_coletado, 
                            luz = da_luz_sel$luz)
dplyr::glimpse(da_data)
```

```
## Rows: 5,565
## Columns: 5
## $ code_muni     <dbl> 1100015, 1100023, 1100031, 1100049, 1100056, 1100064, 11…
## $ agua_rede     <dbl> 24.40, 35.25, 24.00, 76.10, 33.96, 60.70, 12.99, 16.48, …
## $ sem_banheiro  <dbl> 3.51, 0.64, 0.76, 0.89, 0.50, 0.82, 2.72, 2.27, 1.12, 2.…
## $ lixo_coletado <dbl> 56.86, 85.14, 49.77, 78.94, 78.35, 69.11, 37.83, 55.74, …
## $ luz           <dbl> 94.75, 98.31, 97.52, 99.10, 98.62, 98.10, 96.15, 88.56, …
```

## Dados vetoriais

Agora precisamos dos municípios. Vamos usar os dados oficiais do IBGE, baixando os dados para o mesmo ano (2010), usando a função `geobr::read_municipality()` do pacote [*geobr*](https://cran.r-project.org/web/packages/geobr/index.html).


```r
# vetor
mun <- geobr::read_municipality(code_muni = "all", year = 2010, showProgress = FALSE)

# map
tm_shape(mun) +
  tm_polygons()
```

<img src="{{< blogdown/postref >}}index_files/figure-html/unnamed-chunk-7-1.png" width="672" />

## Join

Agora que temos os dois dados (tabular e vetorial), vamos fazer a associação entre eles usando a função `dplyr::left_join()` do pacote [*dplyr*](https://dplyr.tidyverse.org/), usando a coluna "code_muni" como a coluna chave.


```r
# join
mun_da <- dplyr::left_join(x = mun, y = da_data, by = "code_muni")

# data
dplyr::glimpse(mun_da)
```

```
## Rows: 5,567
## Columns: 9
## $ code_muni     <dbl> 1100015, 1100023, 1100031, 1100049, 1100056, 1100064, 11…
## $ name_muni     <chr> "Alta Floresta D'oeste", "Ariquemes", "Cabixi", "Cacoal"…
## $ code_state    <chr> "11", "11", "11", "11", "11", "11", "11", "11", "11", "1…
## $ abbrev_state  <chr> "RO", "RO", "RO", "RO", "RO", "RO", "RO", "RO", "RO", "R…
## $ agua_rede     <dbl> 24.40, 35.25, 24.00, 76.10, 33.96, 60.70, 12.99, 16.48, …
## $ sem_banheiro  <dbl> 3.51, 0.64, 0.76, 0.89, 0.50, 0.82, 2.72, 2.27, 1.12, 2.…
## $ lixo_coletado <dbl> 56.86, 85.14, 49.77, 78.94, 78.35, 69.11, 37.83, 55.74, …
## $ luz           <dbl> 94.75, 98.31, 97.52, 99.10, 98.62, 98.10, 96.15, 88.56, …
## $ geom          <MULTIPOLYGON [°]> MULTIPOLYGON (((-62.2462 -1..., MULTIPOLYGO…
```

## Raster

Agora que temos os limites dos municípios com os dados associados, vamos usar um raster de modelo para rasterizar os polígonos. Para isso, vamos baixar os dados raster do [**WorldClim**](https://www.worldclim.org/), usando a função `raster::getData()` do pacote [*raster*](https://rspatial.org/raster/pkg/index.html).

Também vamos adequar o raster do WorldClim para a extensão e limite do Brasil com as funções `raster::crop()` e `raster::mask()`, respectivamente.


```r
# raster
bio <- raster::getData(name = "worldclim", var = "bio", res = 10)

# extension and limit
bio_br <- bio$bio1 %>% 
  raster::crop(mun_da) %>% 
  raster::mask(mun_da)

# map
tm_shape(bio_br) +
  tm_raster(pal = "Spectral", title = "BIO01") +
  tm_layout(legend.position = c("left", "bottom"))
```

<img src="{{< blogdown/postref >}}index_files/figure-html/unnamed-chunk-9-1.png" width="672" />

## Rasterização

Agora sim, podemos fazer a rasterização dos polígonos dos municípios usando o raster que criamos como modelo, usando a função `fasterize::fasterize()`, também do pacote [*fasterize*](https://cran.r-project.org/web/packages/fasterize/index.html).


```r
# rasterize
mun_agua_raster <- fasterize::fasterize(sf = mun_da, raster = bio_br, field = "agua_rede")

mun_sem_banheiro_raster <- fasterize::fasterize(sf = mun_da, raster = bio_br, field = "sem_banheiro")

mun_lixo_raster <- fasterize::fasterize(sf = mun_da, raster = bio_br, field = "lixo_coletado")

mun_luz_raster <- fasterize::fasterize(sf = mun_da, raster = bio_br, field = "luz")
```

Vamos fazer os mapas para ver os resultados.


```r
# maps
map_agua <- tm_shape(mun_agua_raster) +
  tm_raster(pal = "Blues", title = "Água de rede geral (%)") +
  tm_layout(legend.position = c("left", "bottom"))

map_banheiro <- tm_shape(mun_sem_banheiro_raster) +
  tm_raster(pal = "RdYlGn", title = "Sem banheiro (%)") +
  tm_layout(legend.position = c("left", "bottom"))

map_lixo <- tm_shape(mun_lixo_raster) +
  tm_raster(pal = "Greys", title = "Lixo coletado (%)") +
  tm_layout(legend.position = c("left", "bottom"))

map_luz <- tm_shape(mun_luz_raster) +
  tm_raster(pal = "Oranges", title = "Luz (%)") +
  tm_layout(legend.position = c("left", "bottom"))

tmap_arrange(map_agua, map_banheiro, map_lixo, map_luz)
```

<img src="{{< blogdown/postref >}}index_files/figure-html/unnamed-chunk-11-1.png" width="672" />

## Exportar

E por fim, vamos exportar nossos rasters no formato GeoTiff e comprimidos com a função `raster::writeRaster()`.


```r
# stack
mun_raster <- raster::stack(mun_agua_raster, mun_sem_banheiro_raster, mun_lixo_raster, mun_luz_raster)

# export
raster::writeRaster(x = mun_raster, 
                    filename = "var",
                    suffix = c("agua", "banheiro", "lixo", "luz"),
                    bylayer = TRUE, 
                    options = c("COMPRESS=DEFLATE", "TFW=TRUE"), 
                    format = "GTiff", 
                    progress = "text",
                    overwrite = TRUE)
```
