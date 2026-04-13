## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(firstlib.tijou)
data("df_velo")

## -----------------------------------------------------------------------------
trajet_filtre <- filtrer_trajet(df_velo, "880")
head(trajet_filtre)

## -----------------------------------------------------------------------------
plot_distribution_semaine(trajet_filtre)

