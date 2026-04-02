Le :: signifie :

  tu appelles directement une fonction d’un package
sans charger le package avec library(usethis)

Donc :

  ❌ pas besoin de faire library(usethis)
✅ R va chercher la fonction directement dans le package installé



création packages > creat_package()
ajout fonction > use_r() ou data use_data() use_data_raw()
ajout documentation > balises @ + document()
gestion dépendances > use_packages()
Vérifiaction > session > restart R > devtools::check()

devtools::load_all() qd on repars d'une session neuve
le code est protégé si on change la fonction glue glue <_ fonction(x){10} > qui renvoie 10 mais la package garde en sécurité la fonction hello qui appelel a l 'interieur la fonction glue mais du coup pas modifié ici

::: > fonction à l'interieur du package que le devloppeur n'ai acces > on enleve la balise export > on r
redocumenet on charge

dans import on met glue et ensuite le sfonction utilisé,@importFrom  dplyr filter mutate rename
si on veut tout mettre mais plus lourd > @import ggplot2


README > fichier d'info supplémentaire pour que l'utilisateur s'y retrouve mieux
usethis::use_readme_rmd() et ensuite le fichier est préremplit et on doit le remplir q=comme il se le doit
devtools::build_readme() > compilation > readme.md > version lisible pour git

news > il s'est passé ça sur mon package depusi la dernière mise a jour s
licence > quel droit a ceux qui réutilise le package
code_of_conduct > regelemnt du developpement du package

# Création package

