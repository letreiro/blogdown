---
title: Fonte de dados geoespaciais
author: mauriciovancine
date: "2021-07-20"
slug: []
categories: [spatial,rspatial]
tags: [spatial,rspatial]
subtitle: ""
summary: "Uma listagem de fonte de dados geoespaciais"
authors: []
lastmod: r`Sys.time()`
featured: no
image:
  caption: "[Imagem de Andrew Neel](https://unsplash.com/photos/1-29wyvvLJA)"
  focal_point: "center"
  preview_only: no
projects: []
---



## Contextualização


## Fonte de dados geoespaciais

Existe diversas fontes de dados geográficos em diferentes bases de dados disponíveis gratuitamente. Geralmente essas bases de dados são disponibilizadas separadamente em apenas dados vetoriais e dados raster. Para **dados vetoriais**, grande parte dos dados disponibilizados são utilizados em mapas como limites políticos, limites de biomas ou distribuição de espécies para **polígonos**; estradas e rios para **dados lineares**, ou ainda pontos de ocorrência de espécies ou comunidades, ou medidas tomadas em campo sobre condições naturais como clima ou relevo, como **pontos**. Entretanto, é sempre recomendado o uso de **bases oficiais**, principalmente em relação a dados vetoriais de **limites políticos**. Para tanto, é fundamental buscar as **bases oficiais de cada país**, entrentanto, há bases que podem ser utilizadas globalmente, como veremos.

Sobre as **bases de dados raster**, há uma infinidade de dados para diferentes objetivos, mas grande parte deles são relativos à condições ambientais, representando uma variável de interesse de forma contínua no espaço, como temperatura, precipitação, elevação, etc.

Há uma compilação de dados geográficos vetoriais e raster feita por Marcus Vinícius Alves de Carvalho e Angelica Carvalho Di Maio, chamada [GeoLISTA](http://www.clickgeo.com.br/wp-content/uploads/2018/05/GeoLISTA.pdf). Entretanto, como as bases de dados tendem à ser muito dinâmicas, é possível que muitas bases tenham surgido e desaparecido desde a listagem realizada.

Além das bases de dados, há pacotes específicos no R que fazem o download de dados vetoriais e rasters, facilitando a aquisição e reprodutibilidade. Para conferir uma listagem completa de pacotes para diversas análises espaciais, veja [CRAN Task View: Analysis of Spatial Data](https://cran.r-project.org/web/views/Spatial.html).

### Vetor

Dentre as bases vetoriais, destacamos as seguintes na Tabela <a href="#tab:tab-vetor-bases">1</a>:


Table: Table 1: Principais bases de dados vetoriais para o Brasil e o Mundo.

|Bases de dados                                                                                     |Descrição                                                     |
|:--------------------------------------------------------------------------------------------------|:-------------------------------------------------------------|
|[IBGE](https://www.ibge.gov.br/geociencias/downloads-geociencias.html)                             |Limites territoriais e censitários do Brasil                  |
|[FBDS](http://geo.fbds.org.br/)                                                                    |Uso da terra, APP e hidrografia - Mata Atlântica e Cerrado    |
|[GeoBank](http://geosgb.cprm.gov.br/)                                                              |Dados geológicos do Brasil                                    |
|[Pastagem.org](http://maps.lapig.iesa.ufg.br)                                                      |Dados de pastagens e gado para o Brasil                       |
|[CanaSat](http://www.dsr.inpe.br/laf/canasat/)                                                     |Dados de cana-de-açúcar para o Brasil                         |
|[CSR Maps](http://maps.csr.ufmg.br)                                                                |Diversos dados vetoriais e raster para o Brasil               |
|[Ecoregions](https://ecoregions2017.appspot.com/)                                                  |Dados de biorregiões e biomas do mundo                        |
|[UN Biodiversity Lab](https://www.unbiodiversitylab.org/)                                          |Diversas bases de dados para o mundo                          |
|[Biodiversity Hotspots](https://zenodo.org/record/3261807#.YA8lpPv0nOY)                            |Dados dos limites dos Hotspots de Biodiversidade              |
|[IUCN Red List of Threatened Species](https://www.iucnredlist.org/resources/spatial-data-download) |Dados dos limites das distribuições das espécies para o mundo |
|[Map of Life (MOL)](https://mol.org/)                                                              |Dados da distribuição de espécies e outros dados para o mundo |
|[Key Biodiversity Areas](http://www.keybiodiversityareas.org/kba-data/request)                     |Dados dos limites das Key Biodiversity Areas                  |
|[HydroSHEDS](https://www.hydrosheds.org/)                                                          |Informações hidrológicas do mundo                             |
|[Global Roads Inventory Project (GRIP)](https://www.globio.info/download-grip-dataset)             |Dados de estradas do mundo todo                               |
|[Database of Global Administrative Areas (GADM)](https://gadm.org/)                                |Limites de áreas administrativas do mundo                     |
|[Natural Earth](https://www.naturaleatoriorthdata.com/)                                            |Diversos limites para o mundo                                 |
|[Protected Planet](https://www.protectedplanet.net)                                                |Limites de áreas protegidas para o mundo                      |
|[Global Biological Information Facility (GBIF)](http://www.gbif.org)                               |Dados de ocorrências de espécies para o mundo                 |
|[Species Link](http://www.splink.cria.org.br)                                                      |Dados de ocorrências de espécies para o Brasil                |
|[Global Invasive Species Information Network (GISIN)](http://www.gisin.org)                        |Dados de ocorrências de espécies invasoras para o Mundo       |

### Raster

Dentre as bases raster, destacamos as seguintes na Tabela <a href="#tab:tab-raster-bases">2</a>:


Table: Table 2: Principais bases de dados raster para o Brasil e o Mundo.

|Bases de dados                                                                     |Descrição                                                                                      |
|:----------------------------------------------------------------------------------|:----------------------------------------------------------------------------------------------|
|[MapBiomas](https://mapbiomas.org/)                                                |Uso e cobertura da terra para o Brasil, Panamazonia Legal e Chaco, de 1985 a 2019              |
|[Bahlu](ftp://madeira.dea.ufv.br/bdados/bhalu/)                                    |Distribuições históricas de terras agrícolas e pastagens para todo o Brasil de 1940 a 2012     |
|[USGS](https://www.usgs.gov/)                                                      |Dados de diversos satélites livres para o mundo                                                |
|[SRTM](http://srtm.csi.cgiar.org/)                                                 |Dados de elevação para o mundo                                                                 |
|[Geoservice Maps](https://geoservice.dlr.de/web/maps)                              |Dados de elevação e florestas para o mundo                                                     |
|[Global Forest Watch](https://www.globalforestwatch.org/)                          |Dados de florestas para o mundo                                                                |
|[GlobCover](http://due.esrin.esa.int/page_globcover.php)                           |Dados de uso e cobertura da terra para todo o planeta                                          |
|[Landcover](https://www.earthenv.org/landcover)                                    |Dados de uso e cobertura da terra para todo o planeta                                          |
|[Global Human Footprint](https://wcshumanfootprint.org/)                           |Dados de pegada ecológica para o mundo                                                         |
|[GHSL - Global Human Settlement Layer](https://ghsl.jrc.ec.europa.eu/download.php) |Dados e ferramentas abertos e gratuitos para avaliar a presença humana no planeta              |
|[Land-Use Harmonization (LUH2)](https://luh.umd.edu/)                              |Dados atuais e previsões de uso da terra                                                       |
|[ESA Climate Change Initiative](https://climate.esa.int/en/odp/#/dashboard)        |Arquivos globais de observação da Terra nos últimos 30 anos da Agência Espacial Europeia (ESA) |
|[WorldClim](https://www.worldclim.org/)                                            |Dados climáticos para o mundo                                                                  |
|[CHELSA](https://chelsa-climate.org/)                                              |Dados climáticos para o mundo                                                                  |
|[EarthEnv](https://www.earthenv.org/)                                              |Dados de cobertura da terra, nuvens, relevo e hidrografia                                      |
|[SoilGrids](https://soilgrids.org/)                                                |Dados de solo para o mundo                                                                     |
|[Global Wetlands](https://www2.cifor.org/global-wetlands/)                         |Dados de áreas úmidas para o mundo                                                             |
|[Global Surface Water Explorer](https://global-surface-water.appspot.com/#)        |Dados de águas superficiais para o mundo                                                       |
|[MARSPEC](http://www.marspec.org/)                                                 |Dados de condições do oceano para o mundo                                                      |
|[Bio-ORACLE](http://www.oracle.ugent.be/)                                          |Dados de condições do oceano para o mundo                                                      |

### Pacotes do R

Dentre os pacotes no R para download de dados geográficos, destacamos os seguintes na Tabela <a href="#tab:tab-packages-bases">3</a>:


Table: Table 3: Principais pacotes no R para download de dados vetoriais e raster.

|Pacotes                                                                           |Descrição                                                                            |
|:---------------------------------------------------------------------------------|:------------------------------------------------------------------------------------|
|[geobr](https://cran.r-project.org/web/packages/geobr/index.html)                 |Carrega Shapefiles de Conjuntos de Dados Espaciais Oficiais do Brasil                |
|[rnaturalearth](https://cran.r-project.org/web/packages/rnaturalearth/index.html) |Dados do mapa mundial da Natural Earth                                               |
|[rworldmap](https://cran.r-project.org/web/packages/rworldmap/index.html)         |Mapeando Dados Globais                                                               |
|[spData](https://cran.r-project.org/web/packages/spData/index.html)               |Conjuntos de dados para análise espacial                                             |
|[OpenStreetMap](https://cran.r-project.org/web/packages/OpenStreetMap/index.html) |Acesso para abrir imagens raster de mapas de ruas                                    |
|[osmdata](https://cran.r-project.org/web/packages/osmdata/index.html)             |Baixe e importe dados do OpenStreetMap                                               |
|[geonames](https://cran.r-project.org/web/packages/geonames/index.html)           |Interface para o serviço da Web de consulta espacial 'Geonames'                      |
|[rgbif](https://cran.r-project.org/web/packages/rgbif/index.html)                 |Interface para o Global 'Biodiversity' Information Facility API                      |
|[maptools](https://cran.r-project.org/web/packages/maptools/index.html)           |Ferramentas para lidar com objetos espaciais                                         |
|[marmap](https://cran.r-project.org/web/packages/marmap/index.html)               |Importar, traçar e analisar dados batimétricos e topográficos                        |
|[oce](https://cran.r-project.org/web/packages/oce/index.html)                     |Fonte e processamento de dados oceanográficos                                        |
|[envirem](https://cran.r-project.org/web/packages/envirem/index.html)             |Geração de Variáveis ENVIREM                                                         |
|[sdmpredictors](https://cran.r-project.org/web/packages/sdmpredictors/index.html) |Conjuntos de dados preditor de modelagem de distribuição de espécies                 |
|[metScanR](https://cran.r-project.org/web/packages/metScanR/index.html)           |Encontre, Mapeie e Colete Dados e Metadados Ambientais                               |
|[ClimDown](https://cran.r-project.org/web/packages/ClimDown/index.html)           |Biblioteca de redução de escala do clima para a produção diária do modelo climático  |
|[rWBclimate](https://cran.r-project.org/web/packages/rWBclimate/index.html)       |Acessa dados climáticos do Banco Mundial                                             |
|[rnoaa](https://cran.r-project.org/web/packages/rnoaa/index.html)                 |Dados meteorológicos 'NOAA' de R                                                     |
|[RNCEP](https://cran.r-project.org/web/packages/RNCEP/index.html)                 |Obtenha, organize e visualize dados meteorológicos NCEP                              |
|[smapr](https://cran.r-project.org/web/packages/smapr/index.html)                 |Aquisição e processamento de dados ativos-passivos (SMAP) de umidade do solo da NASA |
