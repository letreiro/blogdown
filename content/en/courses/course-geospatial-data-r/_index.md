---
title: Introduction to the use of geospatial data in R
summary: Learn the main theoretical and practical concepts of the use of geospatial data with R applied to Ecology
date: 2020-10-19
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

## Description

### Graduate Program in Ecology, Evolution and Biodiversity

**Responsible teacher**  
Prof. Milton Cezar Ribeiro

**Invited teacher**  
Prof. Maurício Humberto Vancine

**Period**  
10/19/2020 - 10/30/2020

**Credits**  
60 hours (4 credits)

**Students**  
10 + 5 specials

**Resume**  

The course will offer the main introductory theoretical-practical concepts of geospatial data applied to Ecology. The practical part will be developed through tools in the R language. The following topics will be addressed: (1) version control, Git and GitHub, (2) introduction and operation of the R language and RStudio IDE, (3) structure and management of data in R language, (4) functioning of *tidyverse*, (5) structure and source of geospatial data, (6) handling of geospatial data (vector), (7) handling of geospatial data (raster), and (8) production of maps. The total workload will be 60 hours, where in the first five days there will be taught 6 theoretical-practical hours, for a total of 30 hours. The remaining 30 hours will be directed to practical exercises, which will be applied remotely as a form of assessment to compose the final grade of the discipline. After completing the course, students are expected to acquire general concepts of the structure, manipulation and visualization of geospatial data, as well as mastery of techniques and methods to achieve autonomy and produce solutions for their own issues related to geocomputation using the R language.

---

### Information to participants

**Dates and times**  
Theoretical-practical: 19/10 - 23/10 [09 h - 12 h | 2 pm - 5 pm] (30 hours)  
Remotely assisted exercises-activities: 10/26 - 10/30 (30 hours)

**Teaching plan**  
[pdf](https://github.com/mauriciovancine/disciplina-analise-geoespacial-r/blob/master/00_plano_ensino/plano_ensino_analise_geoespacial_r.pdf)

**Contact**  
For more information or questions, send an email to Maurício Vancine (mauricio.vancine@gmail.com)

---

### Instructions to participants

**Hardware**  
Everyone will need to use their notebooks

**Softwares**  
R, RStudio and git  

1. Install the latest version of [R (4.0.x)](https://www.r-project.org) e [RStudio (1.4.x)](https://www.rstudio.com)
- [R and RStudio installation video](https://youtu.be/l1bWvZMNMCM)  
- [R language course](https://www.youtube.com/playlist?list=PLucm8g_ezqNq0RMHvzZ8M32xhopFhmsr6)

2. Install [git (2.30)](https://git-scm.com/downloads)
- [git installation video](https://youtu.be/QSfHNEiBd2k)  

#### Linux (Ubuntu and Linux Mint)

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

**Install packages on R**  
With R and RStudio installed, download this [script](https://github.com/mauriciovancine/disciplina-analise-geoespacial-r/blob/master/02_scripts/00_script_install_packages.R) (scripts are scripts that have commands, as a draft)

Open the script (**00_script_install_r_packages.R**) in RStudio software and run each command line to install the packages, you must be connected to the internet

To rotate the lines, just place the cursor on the line of code to be executed and press: `Ctrl + Enter`

---

## Material

### Site
- [link](https://mauriciovancine.github.io/disciplina-analise-geoespacial-r/)

### Slides

- [0 Introductions](https://mauriciovancine.github.io/disciplina-analise-geoespacial-r/01_aulas/00_pres_intro_geocomp_r.html)
- [1 Version control, Git and GitHub](https://mauriciovancine.github.io/disciplina-analise-geoespacial-r/01_aulas/01_pres_intro_geocomp_r.html)
- [2 R language](https://mauriciovancine.github.io/disciplina-analise-geoespacial-r/01_aulas/02_pres_intro_geocomp_r.html)
- [3 Data structure and manipulation](https://mauriciovancine.github.io/disciplina-analise-geoespacial-r/01_aulas/03_pres_intro_geocomp_r.html)
- [4 Introduction to tidyverse](https://mauriciovancine.github.io/disciplina-analise-geoespacial-r/01_aulas/04_pres_intro_geocomp_r.html)
- [5 Geospatial data source and structure](https://mauriciovancine.github.io/disciplina-analise-geoespacial-r/01_aulas/05_pres_intro_geocomp_r.html)
- [6 Structure and manipulation of vector data](https://mauriciovancine.github.io/disciplina-analise-geoespacial-r/01_aulas/06_pres_intro_geocomp_r.html)
- [7 Structure and manipulation of raster data](https://mauriciovancine.github.io/disciplina-analise-geoespacial-r/01_aulas/07_pres_intro_geocomp_r.html)
- [8 Geospatial data visualization](https://mauriciovancine.github.io/disciplina-analise-geoespacial-r/01_aulas/08_pres_intro_geocomp_r.html)

### Scripts

- [Install packages](https://github.com/mauriciovancine/disciplina-analise-geoespacial-r/blob/master/02_scripts/00_script_install_packages.R)
- [3 Data structure and manipulation](https://github.com/mauriciovancine/disciplina-analise-geoespacial-r/blob/master/02_scripts/03_script_intro_geocomp_r.R)
- [4 Introduction to tidyverse](https://github.com/mauriciovancine/disciplina-analise-geoespacial-r/blob/master/02_scripts/04_script_intro_geocomp_r.R)
- [6 Structure and manipulation of vector data](https://github.com/mauriciovancine/disciplina-analise-geoespacial-r/blob/master/02_scripts/06_script_intro_geocomp_r.R)
- [7 Structure and manipulation of raster data](https://github.com/mauriciovancine/disciplina-analise-geoespacial-r/blob/master/02_scripts/07_script_intro_geocomp_r.R)
- [8 Geospatial data visualization](https://github.com/mauriciovancine/disciplina-analise-geoespacial-r/blob/master/02_scripts/08_script_intro_geocomp_r.R)

---
