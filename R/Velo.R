#' @title  Filtrer les trajets sans anomalie détectée
#'
#' @description Cette fonction conserve uniquement les lignes pour lesquelles
#' la probabilité de présence d'anomalies est manquante.
#'
#' @param trajet Un data frame contenant les données de trajets.
#'
#' @return Un data frame filtré sans les trajets signalés comme anormaux.
#'
#' @importFrom dplyr filter
#' @export
filtre_anomalie <- function(trajet) {
  trajet |>
    filter(is.na(`Probabilité de présence d'anomalies`))
}

#' @title Compter le nombre total de trajets
#'
#' @description Cette fonction calcule la somme de la variable `Total`.
#'
#' @param trajet Un data frame contenant les données de trajets.
#'
#' @return Un nombre correspondant au total des trajets.
#'
#' @importFrom dplyr pull
#' @export
compter_nombre_trajets <- function(trajet) {
  trajet |>
    pull(Total) |>
    sum()
}

#' @title Compter le nombre de boucles distinctes
#'
#' @description Cette fonction compte le nombre de valeurs distinctes
#' dans la colonne `Numéro de boucle`.
#'
#' @param trajet Un data frame contenant les données de trajets.
#'
#' @return Un entier correspondant au nombre de boucles distinctes.
#'
#' @importFrom dplyr pull n_distinct
#' @export
compter_nombre_boucle <- function(trajet) {
  trajet |>
    pull(`Numéro de boucle`) |>
    n_distinct()
}

#' @title Trouver le trajet ayant le plus grand total
#'
#' @description Cette fonction retourne la ligne correspondant au trajet
#' ayant la valeur maximale de `Total`.
#'
#' @param trajet Un data frame contenant les données de trajets.
#'
#' @return Un data frame contenant la boucle de comptage, le jour
#' et le total du trajet maximal.
#'
#' @importFrom dplyr slice_max select
#' @export
trouver_trajet_max <- function(trajet) {
  trajet |>
    slice_max(Total, n = 1) |>
    select(`Boucle de comptage`, Jour, Total)
}

#' @title Calculer la distribution hebdomadaire des trajets
#'
#' @description Cette fonction calcule le nombre total de trajets
#' par jour de la semaine.
#'
#' @param trajet Un data frame contenant les données de trajets.
#'
#' @return Un data frame avec le jour de la semaine et le nombre
#' total de trajets.
#'
#' @importFrom dplyr count
#' @export
calcul_distribution_semaine <- function(trajet) {
  trajet |>
    count(`Jour de la semaine`, wt = Total, sort = TRUE, name = "trajets")
}

#' @title Représenter la distribution hebdomadaire des trajets
#'
#' @description Cette fonction produit un diagramme en barres du nombre total
#' de trajets par jour de la semaine, après filtrage des anomalies.
#'
#' @param trajet Un data frame contenant les données de trajets.
#'
#' @return Un graphique ggplot2.
#'
#' @importFrom dplyr mutate
#' @importFrom forcats fct_recode
#' @importFrom ggplot2 ggplot aes geom_col
#'
#' @export
plot_distribution_semaine <- function(trajet) {
  trajet_weekday <- trajet |>
    filtre_anomalie() |>
    calcul_distribution_semaine() |>
    mutate(
      jour = fct_recode(
        factor(`Jour de la semaine`),
        "lundi" = "1",
        "mardi" = "2",
        "mercredi" = "3",
        "jeudi" = "4",
        "vendredi" = "5",
        "samedi" = "6",
        "dimanche" = "7"
      )
    )

  ggplot(trajet_weekday) +
    aes(x = jour, y = trajets) +
    geom_col()
}

#' @title Filtrer les trajets selon un ou plusieurs numéros de boucle
#'
#' @description Cette fonction filtre un jeu de données de trajets pour ne conserver
#' que les lignes correspondant aux numéros de boucle sélectionnés.
#'
#' @param trajet Un data frame contenant les données de trajets.
#' @param boucle Un vecteur de caractères contenant les numéros de boucle à conserver.
#'
#' @return Un data frame filtré selon les boucles sélectionnées.
#'
#' @importFrom dplyr filter
#' @importFrom rlang .data
#' @export
filtrer_trajet <- function(trajet, boucle) {
  dplyr::filter(
    trajet,
    as.character(.data[["Num\u00e9ro de boucle"]]) %in% boucle
  )
}
