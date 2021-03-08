---
title: "Dados geoespaicias no R"
author: mauriciovancine
date: "2021-06-20"
slug: []
categories: [r, spatial, tutorial]
tags: [r, rstats, rspatial]
subtitle: ""
summary: "Um guia para começar a usar dados geoespaciais no R"
authors: []
lastmod: r`Sys.time()`
featured: no
image: 
  caption: "[R logo](https://www.r-project.org/logo/)"
  focal_point: "center"
  preview_only: no
projects: []
---



## Contextualização


### *sf*: principal pacote no R para dados vetoriais

Atualmente o principal pacote para trabalhar com dados vetoriais no R é o [*sf*](https://r-spatial.github.io/sf/), que implementou o *Simple Feature* no R (Pebesma 2018). Entretanto, outro pacote pode ser tão versátil quanto o *sf*, no caso o [*terra*](https://rspatial.org/terra/index.html), ainda em desenvolvimento.

O pacote *sf* facilitou muito a forma de trabalhar com vetores no R, sendo que as principais vantagens desse pacote são (Lovelace, Nowosad & Muenchow 2019):

-   rápida importação e exportação de dados
-   aprimorado desempenho de plotagem
-   objetos *sf* podem ser tratados como dataframes na maioria das operações
-   funções *sf* podem ser combinadas usando o operador `%>%` e funcionam no formato tidyverse
-   funções *sf* são consistentes e intuitivas (quase sempre começam com prefixo `st_`)

Os tipos de geometrias apresentadas são representadas por diferentes classes: `POINT`, `LINESTRING` e `POLYGON` para apenas uma feição de cada tipo de geometria; `MULTIPOINT`, `MULTILINESTRING` e `MULTIPOLYGON` para várias feições de cada tipo de geometria e; `GEOMETRYCOLLECTION` para várias feições e tipos de geometrias (Figura <a href="#fig:fig-vetor-sf-classes">1</a>).

<div class="figure" style="text-align: center">
<img src="img/sf-classes.png" alt="Tipos de classes suportadas pelo pacote *sf*. Fonte: Lovelace, Nowosad &amp; Muenchow (2019)." width="50%" />
<p class="caption">Figura 1: Tipos de classes suportadas pelo pacote *sf*. Fonte: Lovelace, Nowosad & Muenchow (2019).</p>
</div>

O pacote *sf* define um sistema de três classes hierárquicas (Tabela <a href="#tab:tab-vetor-sf-estruturas"><strong>??</strong></a>):

-   Classe *sfg* - uma geometria única
-   Classe *sfc* - uma coluna de geometria, que é um conjunto de geometrias *sfg* e informações Sistema de Referência de Coordenadas (do inglês *Coordinate Reference Systems- CRS*)
-   Classe *sf* - uma camada, que é uma coluna de geometria *sfc* dentro de um dataframe com atributos não espaciais


Table: Tabela 1: Estruturas de dados espaciais no pacote sf. Fonte: [Dorman (2021)](https://michaeldorman.github.io/R-Spatial-Workshop-at-CBS-2021/main.html).

|Classes |Hierarquia          |Informação              |
|:-------|:-------------------|:-----------------------|
|`sfg`   |Geometria           |Tipo e coordenadas      |
|`sfc`   |Coluna de geometria |Conjundo de `sfg` + CRS |
|*sf*    |Camada              |`sfc` + atributos       |

Ao olharmos as informações de um objeto da classe *sf*, podemos notar diversas informações que descrevem o mesmo:

-   *resumo do vetor*: indica o número de feições (linhas) e campos (colunas)
-   *tipo da geometria*: umas das sete classes listadas anteriormente (Figura <a href="#fig:fig-vetor-sf-classes">1</a>)
-   *dimensão*: número de dimensões, geralmente duas (XY)
-   *bbox (bordas)*: coordenadas mínimas e máximas da longitude e latitude
-   *informação do CRS*: `epsg` ou `proj4string` indicando o CRS
-   *tibble*: tabela de atributos, com destaque para a coluna `geom` ou `geometry` que representa cada feição ou geometria


```r
countries110
```

```
## class       : SpatialPolygonsDataFrame 
## features    : 177 
## extent      : -180, 180, -90, 83.64513  (xmin, xmax, ymin, ymax)
## crs         : +proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0 
## variables   : 63
## names       : scalerank,      featurecla, labelrank,  sovereignt, sov_a3, adm0_dif, level,              type,       admin, adm0_a3, geou_dif,     geounit, gu_a3, su_dif,     subunit, ... 
## min values  :         1, Admin-0 country,         2, Afghanistan,    AFG,        0,     2,           Country, Afghanistan,     AFG,        0, Afghanistan,   AFG,      0, Afghanistan, ... 
## max values  :         3, Admin-0 country,         7,    Zimbabwe,    ZWE,        1,     2, Sovereign country,    Zimbabwe,     ZWE,        0,    Zimbabwe,   ZWE,      1,    Zimbabwe, ...
```

Podemos fazer um mapa simples utilizando a função `plot()` desse objeto. Para facilitar, escolheremos apenas a primeira coluna `[1]` (Figura <a href="#fig:fig-vetor-mundo">2</a>).

> IMPORTANTE: faremos mapas mais elaborados na seção xx desse capítulo.


```r
plot(countries110[1], col = viridis::viridis(100), main = "Mapa do mundo")
```

```
## Warning in wkt(obj): CRS object has no comment
```

<div class="figure" style="text-align: center">
<img src="{{< blogdown/postref >}}index_files/figure-html/fig-vetor-mundo-1.png" alt="Mapa vetorial do mundo." width="100%" />
<p class="caption">Figura 2: Mapa vetorial do mundo.</p>
</div>

### *raster*: principal pacote no R para dados raster

Atualmente, o principal pacote para trabalhar com dados raster é o [*raster*](https://rspatial.org/raster/index.html) (Hijmans 2020), apesar de existir outros dois em desenvolvimento e já sendo aplicados, como o [*terra*](https://rspatial.org/terra/index.html) e o [*stars*](https://r-spatial.github.io/stars/). O pacote *raster* fornece uma ampla gama de funções para criar, importar, exportar, manipular e processar dados raster no R. O objeto raster pode assumir três classes no R: `RasterLayer`, `RasterStack` e `RasterBrick`.

A classe `RasterLayer` representa apenas uma camada raster. Para criar um raster no R podemos utilizar a função `raster::raster()`. Observando essa classe, podemos notar as seguintes informações:

-   *class*: classe raster do objeto raster
-   *dimensions*: número de linhas, colunas e células
-   *resolution*: largura e altura da célula
-   *extent*: coordenadas mínimas e máximas da longitude e latitude
-   *crs*: Sistema de Referência de Coordenadas (*CRS*)
-   *source*: fonte dos dados (memória ou disco)
-   *names*: nome das camadas
-   *values*: valores máximos e mínimos das células


```r
raster_layer <- raster::raster(nrows = 5, ncols = 5, 
                               res = .5,
                               xmn = -61.5, xmx = -59, ymn = -14.5, ymx = -12,
                               vals = sample(1:25, 25, rep = TRUE))
raster_layer
```

```
## class      : RasterLayer 
## dimensions : 5, 5, 25  (nrow, ncol, ncell)
## resolution : 0.5, 0.5  (x, y)
## extent     : -61.5, -59, -14.5, -12  (xmin, xmax, ymin, ymax)
## crs        : +proj=longlat +datum=WGS84 +no_defs 
## source     : memory
## names      : layer 
## values     : 1, 22  (min, max)
```

Um mapa simples do objeto raster pode ser obtido utilizando a função `plot()`, do próprio pacote *raster* (Figura <a href="#fig:fig-raster-layer">3</a>).


```r
plot(raster_layer, col = viridis::viridis(n = 25))
```

<div class="figure" style="text-align: center">
<img src="{{< blogdown/postref >}}index_files/figure-html/fig-raster-layer-1.png" alt="Mapa simples de um `RasterLayer`." width="672" />
<p class="caption">Figura 3: Mapa simples de um `RasterLayer`.</p>
</div>

Além da classe `RasterLayer`, há mais duas classes que trabalham com múltiplas camadas: `RasterBrick` e `RasterStack`. Elas diferem em relação ao número de formatos de arquivo suportados, tipo de representação interna e velocidade de processamento.

A classe `RasterBrick` geralmente corresponde a importação de um único arquivo de imagem de satélite multiespectral (multicamadas) ou a um único objeto com várias camadas na memória. A função `raster::brick()` cria um objeto `RasterBrick`.


```r
raster_layer1 <- raster_layer
raster_layer2 <- raster_layer * raster_layer
raster_layer3 <- sqrt(raster_layer)
raster_layer4 <- log10(raster_layer)

raster_brick <- raster::brick(raster_layer1, raster_layer2, raster_layer3, raster_layer4)
raster_brick
```

```
## class      : RasterBrick 
## dimensions : 5, 5, 25, 4  (nrow, ncol, ncell, nlayers)
## resolution : 0.5, 0.5  (x, y)
## extent     : -61.5, -59, -14.5, -12  (xmin, xmax, ymin, ymax)
## crs        : +proj=longlat +datum=WGS84 +no_defs 
## source     : memory
## names      :    layer.1,    layer.2,    layer.3,    layer.4 
## min values :          1,          1,          1,          0 
## max values :  22.000000, 484.000000,   4.690416,   1.342423
```

Ao utilizarmos a função `plot()` do pacote *raster*, podemos visualizar todos os raster contidos no objeto `RasterBrick` (Figura <a href="#fig:fig-raster-brick">4</a>).


```r
plot(raster_brick, col = viridis::viridis(n = 25))
```

<div class="figure" style="text-align: center">
<img src="{{< blogdown/postref >}}index_files/figure-html/fig-raster-brick-1.png" alt="Mapas simples de um raster RasterBrick." width="672" />
<p class="caption">Figura 4: Mapas simples de um raster RasterBrick.</p>
</div>

Já a classe `RasterStack` permite conectar vários objetos raster armazenados em arquivos diferentes ou vários objetos na memória. Um `RasterStack` é uma lista de objetos `RasterLayer` com a mesma extensão, resolução e CRS. Uma maneira de criá-lo é com a junção de vários objetos espaciais já existentes no ambiente do R ou listar vários arquivos raster em um diretório armazenado no disco. A função `raster::stack()` cria um objeto `RasterStack`.

Outra diferença é que o tempo de processamento para objetos `RasterBrick` geralmente é menor do que para objetos `RasterStack`. A decisão sobre qual classe `Raster` deve ser usada depende principalmente do caráter dos dados de entrada.


```r
raster_layer1 <- raster_layer
raster_layer2 <- raster_layer * raster_layer
raster_layer3 <- sqrt(raster_layer)
raster_layer4 <- log10(raster_layer)

raster_stack <- raster::stack(raster_layer1, raster_layer2, raster_layer3, raster_layer4)
raster_stack
```

```
## class      : RasterStack 
## dimensions : 5, 5, 25, 4  (nrow, ncol, ncell, nlayers)
## resolution : 0.5, 0.5  (x, y)
## extent     : -61.5, -59, -14.5, -12  (xmin, xmax, ymin, ymax)
## crs        : +proj=longlat +datum=WGS84 +no_defs 
## names      :    layer.1,    layer.2,    layer.3,    layer.4 
## min values :          1,          1,          1,          0 
## max values :  22.000000, 484.000000,   4.690416,   1.342423
```

Da mesma forma, ao utilizar a função `plot()` do pacote *raster*, podemos visualizar todos os raster contidos no objeto `RasterStack` (Figura <a href="#fig:fig-raster-stack">5</a>).


```r
plot(raster_stack, col = viridis::viridis(n = 25))
```

<div class="figure" style="text-align: center">
<img src="{{< blogdown/postref >}}index_files/figure-html/fig-raster-stack-1.png" alt="Mapas simples de um raster RasterStack." width="672" />
<p class="caption">Figura 5: Mapas simples de um raster RasterStack.</p>
</div>
