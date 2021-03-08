---
title: Introdução ao uso de dados geoespaciais no R
summary: A disciplina oferece os principais conceitos teórico-práticos do uso de dados geoespaciais no R aplicados à Ecologia
date: 2020-10-09
lastmod: 2021-03-05
linktitle:
menu:
  example:
    name: 
    weight: 1
toc: true
type: docs
weight: 
---

## Descrição

### Programa de Pós-Graduação em Ecologia, Evolução e Biodiversidade

**Docente responsável**  
Prof. Milton Cezar Ribeiro

**Docente convidado**  
Prof. Maurício Humberto Vancine

**Período**  
19/10/2020 - 30/10/2020

**Créditos**  
60 horas (4 créditos)

**Vagas**  
10 + 5 especiais

**Resumo**  

A disciplina oferecerá os principais conceitos teórico-práticos do uso de dados geoespaciais com o R aplicados à Ecologia. A parte prática será desenvolvida através de ferramentas na linguagem R. Serão abordados os seguintes temas: (1) controle de versão, Git e GitHub, (2) introdução e funcionamento da linguagem R e do RStudio, (3) estrutura e manejo de dados na linguagem R, (4) funcionamento do *tidyverse*, (5) estrutura e fonte de dados geoespaciais, (6) manejo dados geoespaciais (vetor), (7) manejo dados geoespaciais (raster) e, (8) produção de mapas. A carga horária total será de 60 horas, onde nos cinco dias iniciais serão ministrados 6 horas teóricas-práticas, num total de 30 horas. As 30 horas restantes serão direcionadas à realização de exercícios práticos, que serão aplicados remotamente como forma de avaliação para compor a nota final da disciplina. Após a realização da disciplina, espera-se que os alunos adquiram conceitos gerais da estrutura, manipulação e visualização de dados geoespaciais, assim como domínio das técnicas e métodos para alcançar autonomia e produzir soluções para suas próprias questões relativas à geocomputação utilizando a linguagem R.

---

### Informações aos participantes

**Datas e horários**  
Teórico-prático: 19/10 – 23/10 [09 h - 12 h | 14 h - 17 h] (30 horas)

Exercícios-atividades assistidas remotamente: 26/10 – 30/10 (30 horas)

**Plano de ensino**   
[pdf](https://github.com/mauriciovancine/disciplina-analise-geoespacial-r/blob/master/00_plano_ensino/plano_ensino_analise_geoespacial_r.pdf)

**Contato**  
Para mais informações ou dúvidas, envie e-mail para Maurício Vancine (mauricio.vancine@gmail.com)

---

### Instruções aos participantes

**Hardware**  
Será necessário que todos usem seus notebooks

**Softwares**<br>
R, RStudio e git  

1. Instalar a versão mais recente do [R (4.0.x)](https://www.r-project.org) e [RStudio (1.4.x)](https://www.rstudio.com)
- [Vídeo de instalação do R e do RStudio](https://youtu.be/l1bWvZMNMCM)  
- [Curso da linguagem R](https://www.youtube.com/playlist?list=PLucm8g_ezqNq0RMHvzZ8M32xhopFhmsr6)

2. Instalar o [git (2.30.x)](https://git-scm.com/downloads)  
- [Vídeo de instalação do git](https://youtu.be/QSfHNEiBd2k)  

#### Linux (Ubuntu e Linux Mint)

```
# r
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9
gpg --keyserver keyserver.ubuntu.com --recv-key E298A3A825C0D65DFD57CBB651716619E084DAB9
gpg -a --export E298A3A825C0D65DFD57CBB651716619E084DAB9 | sudo apt-key add -
sudo add-apt-repository "deb https://cloud.r-project.org/bin/linux/ubuntu focal-cran40/"
sudo apt update
sudo apt install -y r-base r-base-core r-recommended r-base-dev

# r spatial
sudo add-apt-repository ppa:ubuntugis/ubuntugis-unstable
sudo apt update
sudo apt install -y libudunits2-dev libgdal-dev libgeos-dev libproj-dev

# rstudio
wget -c https://download1.rstudio.org/desktop/bionic/amd64/rstudio-1.4.1106-amd64.deb
sudo dpkg -i rstudio-1.4.1106-amd64.deb
sudo apt install -fy
rm rstudio-1.4.1106-amd64.deb

# git
sudo add-apt-repository ppa:git-core/ppa 
sudo apt update
sudo apt install -y git
```

**Instalar pacotes no R**  
Com o R e o RStudio instalados, baixe esse [script](https://github.com/mauriciovancine/disciplina-analise-geoespacial-r/blob/master/02_scripts/00_script_install_packages.R) (scripts são roteiros que possuem comandos, como um rascunho)

Abra o script (**00_script_install_r_packages.R**) no software RStudio e rode cada linha de comando para instalar os pacotes, necessário estar conectado à internet

Para rodar as linhas, basta colocar o cursor na linha de código a ser executada e pressionar: `Ctrl + Enter`

---

## Material

### Site
- [link](https://mauriciovancine.github.io/disciplina-analise-geoespacial-r/)

### Slides

- [0 Apresentações](https://mauriciovancine.github.io/disciplina-analise-geoespacial-r/01_aulas/00_pres_intro_geocomp_r.html)
- [1 Controle de versão, Git e GitHub](https://mauriciovancine.github.io/disciplina-analise-geoespacial-r/01_aulas/01_pres_intro_geocomp_r.html)
- [2 Funcionamento da linguagem R](https://mauriciovancine.github.io/disciplina-analise-geoespacial-r/01_aulas/02_pres_intro_geocomp_r.html)
- [3 Estrutura e manipulação de dados](https://mauriciovancine.github.io/disciplina-analise-geoespacial-r/01_aulas/03_pres_intro_geocomp_r.html)
- [4 Introdução ao tidyverse](https://mauriciovancine.github.io/disciplina-analise-geoespacial-r/01_aulas/04_pres_intro_geocomp_r.html)
- [5 Estrutura e fonte de dados geoespaciais](https://mauriciovancine.github.io/disciplina-analise-geoespacial-r/01_aulas/05_pres_intro_geocomp_r.html)
- [6 Estrutura e manipulação de dados vetoriais](https://mauriciovancine.github.io/disciplina-analise-geoespacial-r/01_aulas/06_pres_intro_geocomp_r.html)
- [7 Estrutura e manipulação de dados matriciais](https://mauriciovancine.github.io/disciplina-analise-geoespacial-r/01_aulas/07_pres_intro_geocomp_r.html)
- [8 Visualização de dados geoespaciais](https://mauriciovancine.github.io/disciplina-analise-geoespacial-r/01_aulas/05_pres_intro_geocomp_r.html)](https://mauriciovancine.github.io/disciplina-analise-geoespacial-r/01_aulas/08_pres_intro_geocomp_r.html)

### Scripts

- [0 Instalar pacotes](https://github.com/mauriciovancine/disciplina-analise-geoespacial-r/blob/master/02_scripts/00_script_install_packages.R)
- [3 Estrutura e manipulação de dados](https://github.com/mauriciovancine/disciplina-analise-geoespacial-r/blob/master/02_scripts/03_script_intro_geocomp_r.R)
- [4 Introdução ao tidyverse](https://github.com/mauriciovancine/disciplina-analise-geoespacial-r/blob/master/02_scripts/04_script_intro_geocomp_r.R)
- [6 Estrutura e manipulação de dados vetoriais](https://github.com/mauriciovancine/disciplina-analise-geoespacial-r/blob/master/02_scripts/06_script_intro_geocomp_r.R)
- [7 Estrutura e manipulação de dados matriciais](https://github.com/mauriciovancine/disciplina-analise-geoespacial-r/blob/master/02_scripts/07_script_intro_geocomp_r.R)
- [8 Visualização de dados geoespaciais](https://github.com/mauriciovancine/disciplina-analise-geoespacial-r/blob/master/02_scripts/08_script_intro_geocomp_r.R)

---
