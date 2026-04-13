test_that("filtre_anomalie conserve seulement des NA dans la colonne anomalie", {
  trajet <- data.frame(
    `Probabilité de présence d'anomalies` = c(NA, 0.4, NA, 0.8),
    Total = c(10, 20, 30, 40),
    check.names = FALSE
  )

  res <- filtre_anomalie(trajet)

  expect_true(all(is.na(res$`Probabilité de présence d'anomalies`)))
})


test_that("Compter le nombre de trajet", {
  trajet <- data.frame(
    Total = c(10, 5, 5, 2)
  )

  res <- compter_nombre_trajets(trajet)

  expect_equal(res, 22)
})


test_that("Compter le nombre de boucle",{
  trajet <- data.frame(
    `Numéro de boucle`= c(880, 885, 990),
    check.names = FALSE
  )

  res <- compter_nombre_boucle(trajet)
  expect_equal(res, 3)
})


test_that("trouver_trajet_max retourne le trajet avec le total maximal", {
  trajet <- data.frame(
    `Boucle de comptage` = c("A", "B", "C"),
    Jour = c("Lundi", "Mardi", "Mercredi"),
    Total = c(10, 25, 18),
    check.names = FALSE
  )

  res <- trouver_trajet_max(trajet)

  attendu <- data.frame(
    `Boucle de comptage` = "B",
    Jour = "Mardi",
    Total = 25,
    check.names = FALSE
  )

  expect_equal(res, attendu)
})

test_that("calcul_distribution_semaine calcule le total des trajets par jour", {
  trajet <- data.frame(
    `Jour de la semaine` = c("Lundi", "Mardi", "Lundi", "Mercredi"),
    Total = c(10, 5, 3, 8),
    check.names = FALSE
  )

  res <- calcul_distribution_semaine(trajet)

  attendu <- data.frame(
    `Jour de la semaine` = c("Lundi", "Mercredi", "Mardi"),
    trajets = c(13, 8, 5),
    check.names = FALSE
  )

  expect_equal(res, attendu)
})



test_that("plot_distribution_semaine retourne un graphique ggplot", {
  trajet <- data.frame(
    `Probabilité de présence d'anomalies` = c(NA, NA, 0.8, NA),
    `Jour de la semaine` = c("1", "2", "1", "3"),
    Total = c(10, 5, 20, 8),
    check.names = FALSE
  )

  res <- plot_distribution_semaine(trajet)

  expect_s3_class(res, "ggplot")
  expect_equal(length(res$layers), 1)
})


test_that("filtrer_trajet renvoie le jeu de données complet si boucle est NULL", {
  trajet <- data.frame(
    `Numéro de boucle` = c("12", "15", "18"),
    Total = c(100, 200, 300),
    check.names = FALSE
  )

  res <- filtrer_trajet(trajet, NULL)

  expect_equal(res, trajet)
})


test_that("filtrer_trajet conserve seulement les boucles demandées", {
  trajet <- data.frame(
    `Numéro de boucle` = c("12", "15", "18"),
    Total = c(100, 200, 300),
    check.names = FALSE
  )

  res <- filtrer_trajet(trajet, c("12", "18"))

  attendu <- data.frame(
    `Numéro de boucle` = c("12", "18"),
    Total = c(100, 300),
    check.names = FALSE
  )

  expect_equal(res, attendu)
})
