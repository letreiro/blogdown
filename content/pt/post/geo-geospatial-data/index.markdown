---
title: Formatos de dados geoespaciais
author: mauriciovancine
date: "2021-05-20"
slug: []
categories: [spatial,rspatial]
tags: [spatial,rspatial]
subtitle: ""
summary: "Detalhamento dos formatos de dados geoespaciais (vetor e raster)"
authors: []
lastmod: r`Sys.time()`
featured: no
image:
  caption: "[Essentials of Geographic Information Systems](https://saylordotorg.github.io/text_essentials-of-geographic-information-systems/s05-03-geographic-information-systems.html)"
  focal_point: "left"
  preview_only: no
projects: []
---



## Contextualização


## Vetor

Dados **vetoriais** representam informações geográficas acuradas através de **pontos, linhas e polígonos** (Figura <a href="#fig:fig-vetor-tipos"><strong>??</strong></a>). Cada uma dessas geometrias são indicadas para representar feições e/ou eventos específicos, como veremos adiante.

### Pontos

**Pontos** são geometrias geralmente utilizadas para representar **eventos pontuais unitários**, como ocorrência de espécies, locais de coleta, pontos de GPS ou nascentes de rios. Esses dados são representados por um único vértice, ou seja, um par de coordenadas (longitude - X e latitude - Y), que são plotados na forma de cículos ou outro elemento que represente o evento em questão. Dessa forma, geralmente utilizamos dados tabulares com pelo menos duas colunas contendo essas coordenadas. Além disso, esses dados tabulares podem conter outras colunas com informações quantitativas ou qualitativas como número de espécies, temperatura, precipitação ou ainda categorias como tipo de habitat, que podemos representar nos pontos através de diferentes formatos, tamanhos ou cores desses pontos (Tabela <a href="#tab:tab-vetor-pontos"><strong>??</strong></a> e Figura <a href="#fig:fig-vetor-pontos"><strong>??</strong></a>).

### Linhas

**Linhas** representam **geometrias lineares** como estradas, rios, trajetos, divisões ou distâncias. Geralmente as linhas são criadas em softwares de Sistema de Informações Geográficas (SIG) como o [QGIS](https://qgis.org/), e depois importadas para o R. As linhas são representadas por no mínimo dois vértices conectados, i.e., dois pares de coordenadas, gerando uma geometria aberta, possuindo como característica o **comprimento**. Da mesma forma que os pontos, as linhas podem possuir informações tabulares, sendo quantitativas como comprimento dessa feição, ou ainda informações qualitativas como o nome de estradas ou vazão de rios, que podem ser utilizadas para alterar o formato, tamanho ou cor dessas linhas (Tabela <a href="#tab:tab-vetor-linhas"><strong>??</strong></a> e Figura <a href="#fig:fig-vetor-linhas"><strong>??</strong></a>).

### Polígonos

Por fim, **polígonos** representam **geometrias fechadas**, como fragmentos de vegetação, lagos ou limites geográficos, sendo mais voltado para representar feições de um mapa de uso e cobertura da terra ou limites geográficos naturais, políticos, administrativos ou regulares. Os polígonos também são criados geralmente em softwares específicos de SIG e depois importados para o R, ou podemos usar funções para criar *buffers* ou malhas de quadrículas ou hexágonos. Os polígonos são representados por no mínimo três vértices conectados, sendo que o primeiro vértice possui coordenadas idênticas ao último, de modo que essa ligação gere uma feição fechada, com características como **perímetro** e/ou **área**. Da mesma forma que os pontos e linhas, colunas podem ser associadas aos polígonos para representar informações quantitativas como perímetro e área dessa polígono, ou ainda informações qualitativas como a classe de cobertura da terra ou o nome do limite geográfico, que podem ser utilizados para alterar formatos, tamanho ou cores desses polígonos (Tabela <a href="#tab:tab-vetor-poligonos"><strong>??</strong></a> e Figura <a href="#fig:fig-vetor-poligonos"><strong>??</strong></a>).

Além disso, geralmente utilizamos **polígono regulares** (buffers, quadrículas ou hexágonos) para **resumir informações** de biodiversidade ou de variáveis preditoras, que podem ser utilizadas como unidades amostrais em análises espaciais ou estatísticas, principalmente nas áreas de Ecologia Espacial, Ecologia da Paisagem, Biogeografia e Macroecologia (Tabela <a href="#tab:tab-vetor-poligonos-regulares"><strong>??</strong></a> e Figura <a href="#fig:fig-vetor-poligonos-regulares"><strong>??</strong></a>).

### Tabela de atributos

Para os dados vetoriais é necessário ainda destacar um elemento fundamental: a **tabela de atributos**. A tabela de atributos é uma tabela que inclui dados **geográficos** e **dados alfanuméricos**. Os **dados geográficos** são representados por cada feição geolocalizada espacialmente (ponto, linha ou polígono), e os **dados alfanuméricos** são todos os demais dados associados a cada uma dessas feições, representado na forma de colunas (Figuras <a href="#fig:fig-vetor-pontos"><strong>??</strong></a>, <a href="#fig:fig-vetor-linhas"><strong>??</strong></a>, <a href="#fig:fig-vetor-poligonos"><strong>??</strong></a> e <a href="#fig:fig-vetor-poligonos-regulares"><strong>??</strong></a>).

Dessa forma, a **tabela de atributos** reúne informações sobre cada feição e pode ser utilizada para realizar de filtros ou agregações dos dados de cada feição. É nessa tabela que podemos ainda concatenar novas informações (colunas) de operações com as feições (linhas da tabela de atributos) como cálculo de comprimento, perímetro, área ou ainda outras operações com as colunas. Também podemos associar outros dados não espaciais aos dados da tabela de atributos com a junção por uma coluna identificadora.

## Raster

Os dados no formato **raster** consistem em uma **matriz** (com linhas e colunas) representando **células igualmente espaçadas** (pixels; Figura <a href="#fig:fig-raster">1</a>). Esse formato de dado torna a álgebra e o processamento de mapas muito mais eficiente e rápido do que o processamento de dados vetoriais. As células dos dados raster possuem **duas informações**: 1. identificação das células (IDs das células) para especificar sua posição na matriz (Figura <a href="#fig:fig-raster">1</a> A) e; 2. valores das células (Figura <a href="#fig:fig-raster">1</a> B), que geralmente são coloridos para facilitar a interpretação da variação dos valores no espaço (Figura <a href="#fig:fig-raster">1</a> C). Além disso, valores ausentes ou não amostrados são representados por `NA`, ou seja, *not available* (Figura <a href="#fig:fig-raster">1</a> B e C).

<div class="figure" style="text-align: center">
<img src="{{< blogdown/postref >}}index_files/figure-html/fig-raster-1.png" alt="Raster: (A) IDs das células, (B) valores das células, (C) células coloridas. Adaptado de: Lovelace, Nowosad &amp; Muenchow (2019)." width="672" />
<p class="caption">Figura 1: Raster: (A) IDs das células, (B) valores das células, (C) células coloridas. Adaptado de: Lovelace, Nowosad & Muenchow (2019).</p>
</div>

### Tipos de raster

A **célula ou pixel** de um raster pode conter apenas um **único valor**, que pode ser **contínuo** ou **categórico** (Figura <a href="#fig:fig-raster-cont-cat">2</a>). O formato raster geralmente representa **fenômenos contínuos**, como elevação, precipitação, temperatura, ou dados espectrais de imagens de satélite, mas também pode representar **categorias** como tipos de florestas ou cobertura da terra (Figura <a href="#fig:fig-raster-cont-cat">2</a>).

<div class="figure" style="text-align: center">
<img src="{{< blogdown/postref >}}index_files/figure-html/fig-raster-cont-cat-1.png" alt="Raster: (A) mapa contínuo, (B) mapa categórico. Adaptado de: Lovelace, Nowosad &amp; Muenchow (2019)." width="672" />
<p class="caption">Figura 2: Raster: (A) mapa contínuo, (B) mapa categórico. Adaptado de: Lovelace, Nowosad & Muenchow (2019).</p>
</div>
