      * Cherche si un créneau est disponible
      ******************************************************************
       IS_DISPO.
       
      *Test compatiblité du sport demandé avec la salle
       MOVE Wresa_idSalle TO fa_idSalle
       MOVE Wresa_sportPratique TO fa_nomSport
       READ fassoc
       INVALID KEY
         MOVE 1 TO WnotDispo
         
       NOT INVALID KEY
       
      *  Test disponibilité globale de la salle
         IF fs_dispo = 0 THEN
           MOVE 1 TO WnotDispo
         ELSE
       
      *    Vérifie heures d'ouverture & fermetureq
           IF Wresa_h_debut > fs_ouv_h AND Wresa_h_fin < fs_ferm_h THEN
      *      OK: cherche les résa en cours pour la salle
       
             MOVE Wresa_idSalle TO fr_idSalle
             START fresa KEY = fr_idSalle
             INVALID KEY
      *        Si erreur 23 => pas de résa pour la salle: OK
               IF fresa_stat IS NOT EQUAL TO 23 THEN
                 DISPLAY "Problème de lecture: ", fresa_stat
                 MOVE 1 TO WnotDispo
               END-IF
               
             NOT INVALID KEY
        
      *        Des résas, on cherche les créneaux dispos
               MOVE 0 TO WnotDispo
               PERFORM WITH TEST AFTER UNTIL Wresafin2=1
                 READ fresa NEXT
                 AT END
                   MOVE 1 TO Wresafin2
                     
                 NOT AT END
                   IF (fr_dateDebut_a = Wresa_a AND fr_dateDebut_m = Wre
      -sa_m AND fr_dateDebut_j = Wresa_j) THEN
      *                Bon jour
      
                     IF (fr_dateFin_h > Wresa_h_debut AND fr_dateFin_h <
      - Wresa_h_fin) OR (fr_dateDebut_h > Wresa_h_debut AND fr_dateDebut
      -_h < Wresa_h_fin) OR (fr_dateDebut_h < Wresa_h_debut AND fr_dateF
      -in_h > Wresa_h_fin) THEN 
      *                Une résa existe, impossible
      
                       MOVE 1 TO WnotDispo
                       MOVE 1 TO Wresafin2
                       		
                     END-IF
                   END-IF
                   
                 END-READ
               END-PERFORM
             END-START
           ELSE
      *      Hors des horaires d'ouverture
             MOVE 1 TO WnotDispo
           END-IF
         END-IF
       END-READ.
       
      * Recherche toutes les salles disponibles pour les couples de valeurs
      ******************************************************************
       RECHERCHE_SALLES_DISPOS.
       
       MOVE 0 TO Wresafin
       MOVE 1 TO Wpasdesalle
       CLOSE fsalle
       OPEN I-O fsalle
       
       DISPLAY "--- Salles disponibles ---"
       DISPLAY "--------------------------"
       DISPLAY " ID / Nom / Adresse "
       DISPLAY " --- "
       PERFORM WITH TEST AFTER UNTIL Wresafin = 1
         READ fsalle NEXT
         AT END
           MOVE 1 TO Wresafin
           
         NOT AT END
           MOVE fs_id TO Wresa_idSalle
           MOVE 0 TO WnotDispo
           PERFORM IS_DISPO
           
           IF WnotDispo = 0 THEN
             MOVE 0 TO Wpasdesalle
             DISPLAY fs_id, " / ", fs_nom, " / ", fs_addr, " ", fs_ville
           END-IF
       END-PERFORM
       DISPLAY "--------------------------".
       
       
      *Ajoute une réservation
      ******************************************************************
       ADD_RESA.
    
      *MAIN
       MOVE 0 TO Wresaimpossible
       
       DISPLAY 'Donnez les informations de votre reservation'
       
       IF WconnectedAsAdmin = 0 THEN
      * Pas de demande de numéro de club
        MOVE WnumClub TO Wresa_idClub
       ELSE
         DISPLAY 'Numero du club:'
         PERFORM WITH TEST AFTER UNTIL Wresa_idClub IS NUMERIC
           ACCEPT Wresa_idClub
         END-PERFORM
       END-IF
      
      *Club existe ?
       MOVE Wresa_idClub TO fc_id
       READ fclub
       INVALID KEY
         DISPLAY 'Le club n existe pas !'
         MOVE 1 TO Wresaimpossible
         
       NOT INVALID KEY
         DISPLAY 'Date de réservation ?'
         DISPLAY  'Jour:'
         PERFORM WITH TEST AFTER UNTIL Wresa_j IS NUMERIC AND Wresa_j > 
      -0 AND Wresa_j < 32
           ACCEPT Wresa_j
         END-PERFORM
         DISPLAY  'Mois:'
         PERFORM WITH TEST AFTER UNTIL Wresa_m IS NUMERIC AND Wresa_m > 
      -0 AND Wresa_m < 13
           ACCEPT Wresa_m
         END-PERFORM
         DISPLAY  'Année:'
         PERFORM WITH TEST AFTER UNTIL Wresa_a IS NUMERIC AND Wresa_a > 
      -1970 AND Wresa_a < 2038
           ACCEPT Wresa_a
         END-PERFORM
         DISPLAY 'Heure de début:'
         PERFORM WITH TEST AFTER UNTIL Wresa_h_debut IS NUMERIC AND Wres
      -a_h_debut >= 0 AND Wresa_h_debut <= 23
           ACCEPT Wresa_h_debut
         END-PERFORM
         DISPLAY 'Heure de fin:'
         PERFORM WITH TEST AFTER UNTIL Wresa_h_fin IS NUMERIC AND Wresa_
      -h_fin >= 0 AND Wresa_h_fin <= 23 AND Wresa_h_fin > Wresa_h_debut
           ACCEPT Wresa_h_fin
         END-PERFORM
  
  
         PERFORM WITH TEST AFTER UNTIL Wrep1 = 0 OR Wrep1 = 1
           DISPLAY 'Voulez-vous une salle en particulier (0/1)?'
           ACCEPT Wrep1
         END-PERFORM
         
         IF Wrep1 = 0 THEN
         
      *    Recherches des salles par sport
           CLOSE fassoc
           OPEN I-O fassoc

           DISPLAY 'Quel sera le sport pratiqué ?'
           PERFORM WITH TEST AFTER UNTIL fa_nomSport IS ALPHABETIC
             ACCEPT fa_nomSport
           END-PERFORM
           
           START fassoc KEY IS = fa_nomSport
           INVALID KEY
             DISPLAY "Sport inexistant"
             MOVE 1 TO Wresaimpossible
           NOT INVALID KEY
             MOVE fa_nomSport TO Wresa_sportPratique
             DISPLAY "Recherche des salles disponibles pour ce sport..."
             DISPLAY "-------------------------------------------------"
           END-START
           
           IF Wresaimpossible = 0 THEN
      *      On cherche toutes les salles dispos à ce créneau
             PERFORM RECHERCHE_SALLES_DISPOS
             
             IF Wpasdesalle = 1 THEN
      *        Aucune salle de dispo, abandon
               DISPLAY "Pas de salles disponibles..."
               MOVE 1 TO Wresaimpossible
             ELSE
               DISPLAY 'Numero de la salle voulue:'
               PERFORM WITH TEST AFTER UNTIL Wresa_idSalle IS NUMERIC
                 ACCEPT Wresa_idSalle
               END-PERFORM
               MOVE Wresa_idSalle TO fs_id
               
      *        Vérifie si la salle choisie est bien dispo
               READ fsalle
               INVALID KEY
                 MOVE 1 TO Wresaimpossible
                 DISPLAY "La salle n'existe pas !"
                  
               NOT INVALID KEY
      *          Vérifie si le créneau est disponible
                 MOVE 0 TO WnotDispo
                 PERFORM IS_DISPO
                 IF WnotDispo = 1 THEN
                   MOVE 1 TO Wresaimpossible
                   DISPLAY "Salle indisponible"
                 END-IF
               END-READ
             END-IF
           END-IF
           
         ELSE
      *    Sélection directe de la salle
      
      *    Sélection du sport
           DISPLAY 'Quel sera le sport pratiqué ?'
           PERFORM WITH TEST AFTER UNTIL fa_nomSport IS ALPHABETIC
             ACCEPT fa_nomSport
           END-PERFORM
           
           START fassoc KEY IS = fa_nomSport
           INVALID KEY
             DISPLAY "Sport inexistant"
             MOVE 1 TO Wresaimpossible
           NOT INVALID KEY
      *      Sport correct, sélection de la salle
             MOVE fa_nomSport TO Wresa_sportPratique
             DISPLAY 'Numero de la salle:'
             PERFORM WITH TEST AFTER UNTIL Wresa_idSalle IS NUMERIC
               ACCEPT Wresa_idSalle
             END-PERFORM
             MOVE Wresa_idSalle TO fs_id
             
             READ fsalle
             INVALID KEY
               MOVE 1 TO Wresaimpossible
               DISPLAY "La salle n'existe pas !"
                
             NOT INVALID KEY
      *        Vérifie si le créneau est disponible
               MOVE 0 TO WnotDispo
               PERFORM IS_DISPO
               IF WnotDispo = 1 THEN
                 MOVE 1 TO Wresaimpossible
                 DISPLAY "Salle indisponible"
               END-IF
             END-READ
           END-START
           
         END-IF
         
         
         IF Wresaimpossible = 1 THEN
           DISPLAY "Réservation impossible"
         ELSE
      *    Calculs pour la résa
      *    Lecture de la salle demandée
           MOVE Wresa_idSalle TO fs_id
           READ fsalle
           INVALID KEY
             DISPLAY "/!\ Erreur: Lecture salle demandée"
           END-READ
           
      *    Lecture de agglo ville du club
           MOVE fc_ville TO fv_id
           READ fville
           INVALID KEY
             DISPLAY "/!\ Erreur: Lecture agglo club"
           NOT INVALID KEY
             MOVE fv_agglo TO Wresa_clubAgglo
           END-READ
           
      *    Lecture de agglo ville de la salle
           MOVE Wresa_idSalle TO fv_id
           READ fville
           INVALID KEY
             DISPLAY "/!\ Erreur: Lecture agglo ville salle"
           END-READ
           
           IF fc_ville = fs_ville THEN
      *      Club dans la même ville que la salle : 0
             MOVE 0 TO Wresa_montant
           ELSE
             IF Wresa_clubAgglo = 1 AND fv_agglo = 1 THEN
               COMPUTE Wresa_montant = (fs_prix * (Wresa_h_fin - Wresa_h
      -_debut)) * 50 / 100
             ELSE
               COMPUTE Wresa_montant = fs_prix * (Wresa_h_fin - Wresa_h_
      -debut)
             END-IF
           END-IF
         
         
      *    Préparation à l'enregistrement
           MOVE Wresa_a TO fr_dateDebut_a
           MOVE Wresa_m TO fr_dateDebut_m
           MOVE Wresa_j TO fr_dateDebut_j
           MOVE Wresa_a TO fr_dateFin_a
           MOVE Wresa_m TO fr_dateFin_m
           MOVE Wresa_j TO fr_dateFin_j
           MOVE Wresa_h_debut TO fr_dateDebut_h
           MOVE Wresa_h_fin TO fr_dateFin_h
           MOVE Wresa_idSalle TO fr_idSalle
           MOVE Wresa_sportPratique TO fr_sportPratique
           MOVE Wresa_idClub TO fr_idClub
           MOVE Wresa_montant TO fr_montant
         
           
           WRITE Tresa
           INVALID KEY  
             DISPLAY "Erreur d'écriture: ", fresa_stat
           NOT INVALID KEY
             DISPLAY 'Reservation effectuée !'
           END-WRITE
         END-IF
       END-READ.
