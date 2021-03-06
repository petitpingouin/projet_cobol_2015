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
         DISPLAY "4- Modification de votre compte"
         DISPLAY "5- Statistiques"
         DISPLAY "----"
         ACCEPT Woption
         EVALUATE Woption
             WHEN 0 PERFORM SHUTDOWN
             WHEN 2 PERFORM MENU_PLANNING
             WHEN 3 PERFORM MENU_GESTION_RESA
             WHEN 4 PERFORM MENU_GESTION_MODIF_CLUB
             WHEN 5 PERFORM MENU_STATISTIQUES
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
         DISPLAY "9- Consultation du planning"
         DISPLAY "10- Recherches"
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
             WHEN 8 PERFORM MENU_STATISTIQUES_ADMIN
             WHEN 9 PERFORM MENU_PLANNING
             WHEN 10 PERFORM MENU_RECHERCHES
         END-EVALUATE
       END-PERFORM.

       MENU_STATISTIQUES.
       PERFORM WITH TEST AFTER UNTIL Woption2=1
         DISPLAY "*********************************************"
         DISPLAY "         Affichage des Statistiques          "
         DISPLAY "*********************************************"
         DISPLAY "Sélectionnez une option :"
         DISPLAY "----"
         DISPLAY "0- Quitter le programme"
         DISPLAY "1- Revenir au menu précédent"
         DISPLAY "2- Facture du mois"
         DISPLAY "----"
         ACCEPT Woption2
         EVALUATE Woption2
             WHEN 0 PERFORM SHUTDOWN
             WHEN 2 PERFORM FACTURE_MOIS
         END-EVALUATE
       END-PERFORM.
       
       MENU_STATISTIQUES_ADMIN.
       PERFORM WITH TEST AFTER UNTIL Woption2=1
         DISPLAY "*********************************************"
         DISPLAY "         Affichage des Statistiques          "
         DISPLAY "*********************************************"
         DISPLAY "Sélectionnez une option :"
         DISPLAY "----"
         DISPLAY "0- Quitter le programme"
         DISPLAY "1- Revenir au menu précédent"
         DISPLAY "----"
         ACCEPT Woption2
         EVALUATE Woption2
             WHEN 0 PERFORM SHUTDOWN
         END-EVALUATE
       END-PERFORM.
       
       MENU_PLANNING.
       PERFORM WITH TEST AFTER UNTIL Woption2=1
         DISPLAY "*********************************************"
         DISPLAY "           Affichage du planning             "
         DISPLAY "*********************************************"
         DISPLAY "Sélectionnez une option :"
         DISPLAY "----"
         DISPLAY "0- Quitter le programme"
         DISPLAY "1- Revenir au menu précédent"
         IF WconnectedAsAdmin = 0 THEN
           DISPLAY "2- Afficher toutes mes réservations"
         ELSE
           DISPLAY "2- Afficher les réservations par club"
         END-IF
         DISPLAY "3- Afficher toutes les réservations"
         DISPLAY "4- Afficher les réservations par salle"
         DISPLAY "----"
         ACCEPT Woption2
         EVALUATE Woption2
             WHEN 0 PERFORM SHUTDOWN
             WHEN 2 PERFORM DISPLAY_RESAS_BY_CLUB
             WHEN 3 PERFORM DISPLAY_RESAS
             WHEN 4 PERFORM DISPLAY_RESAS_BY_SALLE
         END-EVALUATE
       END-PERFORM.
       
       MENU_RECHERCHES.
       PERFORM WITH TEST AFTER UNTIL Woption2=1
         DISPLAY "*********************************************"
         DISPLAY "                 Recherches                  "
         DISPLAY "*********************************************"
         DISPLAY "Sélectionnez une option :"
         DISPLAY "----"
         DISPLAY "0- Quitter le programme"
         DISPLAY "1- Revenir au menu précédent"
         DISPLAY "----"
         ACCEPT Woption2
         EVALUATE Woption2
             WHEN 0 PERFORM SHUTDOWN
             
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
         DISPLAY "3- Supprimer une réservation"
         DISPLAY "----"
         ACCEPT Woption2
         EVALUATE Woption2
             WHEN 0 PERFORM SHUTDOWN
             WHEN 2 PERFORM ADD_RESA
             WHEN 3 PERFORM DELETE_RESA
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
         DISPLAY "3- Supprimer une association"
         DISPLAY "4- Afficher association pour un club"
         DISPLAY "5- Afficher toutes les associations"
         DISPLAY "----"
         ACCEPT Woption2
         EVALUATE Woption2
             WHEN 0 PERFORM SHUTDOWN
             WHEN 2 PERFORM CREATE_ASSOC
             WHEN 3 PERFORM DELETE_ASSOC
             WHEN 4 PERFORM READ_ASSOC_BY_SALLE
             WHEN 5 PERFORM DISPLAY_ASSOC
         END-EVALUATE
       END-PERFORM.

       MENU_ENTRETIEN.
       PERFORM WITH TEST AFTER UNTIL Woption2=1
         DISPLAY "*********************************************"
         DISPLAY "          Gestion des Entretiens             "
         DISPLAY "*********************************************"
         DISPLAY "Sélectionnez une option :"
         DISPLAY "----"
         DISPLAY "0- Quitter le programme"
         DISPLAY "1- Revenir au menu précédent"
         DISPLAY "2- Plannification d'entretiens"
         DISPLAY "3- Suppression d'entretien"
         DISPLAY "4- Affichage des entretiens"
         DISPLAY "----"
         ACCEPT Woption2
         EVALUATE Woption2
             WHEN 0 PERFORM SHUTDOWN
             WHEN 2 PERFORM ADD_RESA
             WHEN 3 PERFORM DELETE_ENTRETIEN
             WHEN 4 PERFORM DISPLAY_ENTRETIENS
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
             WHEN 2 PERFORM MODIFY_CLUB_NOM
             WHEN 3 PERFORM MODIFY_CLUB_ADDR
             WHEN 4 PERFORM MODIFY_CLUB_PSDT
             WHEN 5 PERFORM MODIFY_CLUB_TOWN
             WHEN 6 PERFORM MODIFY_CLUB_SPORT
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
       
