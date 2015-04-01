      *Création d'un électeur
       MENU_USR.
       PERFORM WITH TEST AFTER UNTIL Woption=1
         DISPLAY "*********************************************"
         DISPLAY "      BIENVENUE DANS LE MENU UTILISATEUR     "
         DISPLAY "*********************************************"
         DISPLAY "Sélectionnez une option :"
         DISPLAY "----"
         DISPLAY "0- Quitter le programme"
         DISPLAY "1- Déconnexion"
         DISPLAY "2- Consultation du planning"
         DISPLAY "3- Gestion des réservations"
         DISPLAY "4- Gestion de compte"
         DISPLAY "5- Statistiques"
         DISPLAY "----"
         ACCEPT Woption
         EVALUATE Woption
             WHEN 0 PERFORM SHUTDOWN
             WHEN 3 PERFORM MENU_GESTION_RESA
             WHEN 4 PERFORM MENU_GESTION_MODIF_CLUB
         END-EVALUATE
       END-PERFORM.

       MENU_GESTION_RESA_USER.
       PERFORM WITH TEST AFTER UNTIL Woption2=1
         DISPLAY "*********************************************"
         DISPLAY "           Gestion des réservations          "
         DISPLAY "*********************************************"
         DISPLAY "Sélectionnez une option :"
         DISPLAY "----"
         DISPLAY "0- Quitter le programme"
         DISPLAY "1- Revenir au menu précédent"
         DISPLAY "2- Afficher vos réservations"
         DISPLAY "3- Créer une réservation"
         DISPLAY "3- Modifier une réservation"
         DISPLAY "4- Supprimer une réservation"
         DISPLAY "5- Rechercher une réservation"
         DISPLAY "6- Revenir au menu précédent"
         DISPLAY "----"
         ACCEPT Woption2
         EVALUATE Woption2
             WHEN 0 STOP RUN
      *       WHEN 2 PERFORM SHOW_RESAS
         END-EVALUATE
       END-PERFORM.

       MENU_ADMIN.
       PERFORM WITH TEST AFTER UNTIL Woption=1
         DISPLAY "*********************************************"
         DISPLAY "    BIENVENUE DANS LE MENU ADMINISTRATEUR    "
         DISPLAY "*********************************************"
         DISPLAY "Sélectionnez une option :"
         DISPLAY "----"
         DISPLAY "0- Quitter le programme"
         DISPLAY "1- Déconnexion"
         DISPLAY "2- Gestion des réservations"
         DISPLAY "3- Gestion des villes"
         DISPLAY "4- Gestion des salles"
         DISPLAY "5- Gestion des clubs"
         DISPLAY "6- Gestion des associations"
         DISPLAY "7- Entretiens"
         DISPLAY "8- Statistiques"
         DISPLAY "----"
         ACCEPT Woption
         EVALUATE Woption
             WHEN 0 PERFORM SHUTDOWN
             WHEN 2 PERFORM MENU_GESTION_RESA
             WHEN 3 PERFORM MENU_GESTION_VILLE
             WHEN 4 PERFORM MENU_GESTION_SALLE
             WHEN 5 PERFORM MENU_GESTION_CLUB
             WHEN 6 PERFORM MENU_GESTION_ASSOC
             WHEN 7 PERFORM MENU_ENTRETIEN
         END-EVALUATE
       END-PERFORM.

       MENU_GESTION_RESA.
       PERFORM WITH TEST AFTER UNTIL Woption2=1
         DISPLAY "*********************************************"
         DISPLAY "           Gestion des réservations          "
         DISPLAY "*********************************************"
         DISPLAY "Sélectionnez une option :"
         DISPLAY "----"
         DISPLAY "0- Quitter le programme"
         DISPLAY "1- Revenir au menu précédent"
         DISPLAY "2- Créer une réservation"
         DISPLAY "3- Modifier une réservation"
         DISPLAY "4- Supprimer une réservation"
         DISPLAY "5- Rechercher une réservation"
         DISPLAY "6- Afficher toutes les réservations"
         DISPLAY "----"
         ACCEPT Woption2
         EVALUATE Woption2
             WHEN 0 PERFORM SHUTDOWN
             WHEN 2 PERFORM ADD_RESA
             WHEN 4 PERFORM DELETE_RESA
             WHEN 6 PERFORM DISPLAY_RESAS
         END-EVALUATE
       END-PERFORM.

       MENU_GESTION_VILLE.
       PERFORM WITH TEST AFTER UNTIL Woption2=1
         DISPLAY "*********************************************"
         DISPLAY "              Gestion des villes             "
         DISPLAY "*********************************************"
         DISPLAY "Sélectionnez une option :"
         DISPLAY "----"
         DISPLAY "0- Quitter le programme"
         DISPLAY "1- Revenir au menu précédent"
         DISPLAY "2- Créer une ville"
         DISPLAY "3- Modifier une ville"
         DISPLAY "4- Supprimer une ville"
         DISPLAY "5- Rechercher une ville"
         DISPLAY "6- Afficher toutes les villes"
         DISPLAY "----"
         ACCEPT Woption2
         EVALUATE Woption2
             WHEN 0 PERFORM SHUTDOWN
             WHEN 2 PERFORM CREATE_TOWN
             WHEN 3 PERFORM MENU_GESTION_MODIF_VILLE
             WHEN 4 PERFORM DELETE_VILLE
             WHEN 5 PERFORM READ_TOWN
             WHEN 6 PERFORM DISPLAY_VILLES
         END-EVALUATE
       END-PERFORM.

       MENU_GESTION_SALLE.
       PERFORM WITH TEST AFTER UNTIL Woption2=1
         DISPLAY "*********************************************"
         DISPLAY "              Gestion des salles             "
         DISPLAY "*********************************************"
         DISPLAY "Sélectionnez une option :"
         DISPLAY "----"
         DISPLAY "0- Quitter le programme"
         DISPLAY "1- Revenir au menu précédent"
         DISPLAY "2- Créer une salle"
         DISPLAY "3- Modifier une salle"
         DISPLAY "4- Supprimer une salle"
         DISPLAY "5- Rechercher une salle"
         DISPLAY "6- Afficher toutes les salles"
         DISPLAY "----"
         ACCEPT Woption2
         EVALUATE Woption2
             WHEN 0 PERFORM SHUTDOWN
             WHEN 2 PERFORM CREATE_ROOM
             WHEN 3 PERFORM MENU_GESTION_MODIF_SALLE
             WHEN 4 PERFORM DELETE_SALLE
             WHEN 5 PERFORM READ_ROOM
             WHEN 6 PERFORM DISPLAY_SALLES
         END-EVALUATE
       END-PERFORM.

       MENU_GESTION_CLUB.
       PERFORM WITH TEST AFTER UNTIL Woption2=1
         DISPLAY "*********************************************"
         DISPLAY "              Gestion des clubs              "
         DISPLAY "*********************************************"
         DISPLAY "Sélectionnez une option :"
         DISPLAY "----"
         DISPLAY "0- Quitter le programme"
         DISPLAY "1- Revenir au menu précédent"
         DISPLAY "2- Créer un club"
         DISPLAY "3- Modifier un club"
         DISPLAY "4- Supprimer un club"
         DISPLAY "5- Rechercher un club"
         DISPLAY "6- Afficher tous les clubs"
         DISPLAY "----"
         ACCEPT Woption2
         EVALUATE Woption2
             WHEN 0 PERFORM SHUTDOWN
             WHEN 2 PERFORM CREATE_CLUB
             WHEN 3 PERFORM MENU_GESTION_MODIF_CLUB
             WHEN 4 PERFORM DELETE_CLUB
             WHEN 5 PERFORM READ_CLUB
             WHEN 6 PERFORM DISPLAY_CLUBS
         END-EVALUATE
       END-PERFORM.

       MENU_GESTION_ASSOC.
       PERFORM WITH TEST AFTER UNTIL Woption2=1
         DISPLAY "*********************************************"
         DISPLAY "     Gestion des assocations sport/salle     "
         DISPLAY "*********************************************"
         DISPLAY "Sélectionnez une option :"
         DISPLAY "----"
         DISPLAY "0- Quitter le programme"
         DISPLAY "1- Revenir au menu précédent"
         DISPLAY "2- Créer une association"
         DISPLAY "4- Supprimer une réservation"
         DISPLAY "5- Afficher association pour un club"
         DISPLAY "6- Afficher toutes les associations"
         DISPLAY "----"
         ACCEPT Woption2
         EVALUATE Woption2
             WHEN 0 PERFORM SHUTDOWN
             WHEN 2 PERFORM CREATE_ASSOC
             WHEN 4 PERFORM DELETE_ASSOC
             WHEN 5 PERFORM READ_ASSOC_BY_SALLE
             WHEN 6 PERFORM DISPLAY_ASSOC
         END-EVALUATE
       END-PERFORM.

       MENU_ENTRETIEN.
       PERFORM WITH TEST AFTER UNTIL Woption2=1
         DISPLAY "*********************************************"
         DISPLAY "           Planning de l'entretien           "
         DISPLAY "*********************************************"
         DISPLAY "Sélectionnez une option :"
         DISPLAY "----"
         DISPLAY "0- Quitter le programme"
         DISPLAY "1- Revenir au menu précédent"
         DISPLAY "2- Plannification d'entretiens"
         DISPLAY "3- Suppression d'entretien"
         DISPLAY "4- Modification d'entretien"
         DISPLAY "----"
         ACCEPT Woption2
         EVALUATE Woption2
             WHEN 0 PERFORM SHUTDOWN
         END-EVALUATE
       END-PERFORM.

       MENU_GESTION_MODIF_CLUB.
       PERFORM WITH TEST AFTER UNTIL Woption2=1
         DISPLAY "*********************************************"
         DISPLAY "             Modification du club            "
         DISPLAY "*********************************************"
         DISPLAY "Quelle information désirez-vous modifier ? :"
         DISPLAY "----"
         DISPLAY "0- Quitter le programme"
         DISPLAY "1- Revenir au menu précédent"
         DISPLAY "2- Nom du club"
         DISPLAY "3- Adresse"
         DISPLAY "4- Président"
         DISPLAY "5- Ville"
         DISPLAY "6- Sport proposé"
         DISPLAY "----"
         ACCEPT Woption2
         EVALUATE Woption2
             WHEN 0 PERFORM SHUTDOWN
         END-EVALUATE
       END-PERFORM.

       MENU_GESTION_MODIF_VILLE.
       PERFORM WITH TEST AFTER UNTIL Woption2=1
         DISPLAY "*********************************************"
         DISPLAY "           Modification de la ville          "
         DISPLAY "*********************************************"
         DISPLAY "Quelle information désirez-vous modifier ? :"
         DISPLAY "----"
         DISPLAY "0- Quitter le programme"
         DISPLAY "1- Revenir au menu précédent"
         DISPLAY "2- Nom de la ville"
         DISPLAY "3- Code postal"
         DISPLAY "4- Agglomération"
         DISPLAY "----"
         ACCEPT Woption2
         EVALUATE Woption2
             WHEN 0 PERFORM SHUTDOWN
             WHEN 2 PERFORM MODIFY_TOWN_NOM
             WHEN 3 PERFORM MODIFY_TOWN_CODE
             WHEN 4 PERFORM MODIFY_TOWN_AGGLO
         END-EVALUATE
       END-PERFORM.

       MENU_GESTION_MODIF_SALLE.
       PERFORM WITH TEST AFTER UNTIL Woption2=1
         DISPLAY "*********************************************"
         DISPLAY "           Modification de la salle          "
         DISPLAY "*********************************************"
         DISPLAY "Quelle information désirez-vous modifier ? :"
         DISPLAY "----"
         DISPLAY "0- Quitter le programme"
         DISPLAY "1- Revenir au menu précédent"
         DISPLAY "2- Nom de la salle"
         DISPLAY "3- Disponibilité"
         DISPLAY "4- Heure d'ouverture"
         DISPLAY "5- Heure de fermeture"
         DISPLAY "6- Adresse"
         DISPLAY "7- Ville"
         DISPLAY "8- Prix de location"
         DISPLAY "----"
         ACCEPT Woption2
         EVALUATE Woption2
             WHEN 0 PERFORM SHUTDOWN
             WHEN 2 PERFORM MODIFY_ROOM_NOM
             WHEN 3 PERFORM MODIFY_ROOM_DISPO
             WHEN 4 PERFORM MODIFY_ROOM_OUV
             WHEN 5 PERFORM MODIFY_ROOM_FERM
             WHEN 6 PERFORM MODIFY_ROOM_ADDR
             WHEN 7 PERFORM MODIFY_ROOM_VILLE
             WHEN 8 PERFORM MODIFY_ROOM_PRIX
         END-EVALUATE
       END-PERFORM.
