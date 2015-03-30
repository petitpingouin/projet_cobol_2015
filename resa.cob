      * Cherche si un créneau est disponible
      ******************************************************************
       IS_DISPO.
       
       MOVE fr_dateDebut_h TO WHdebut
       MOVE fr_dateFin_h TO WHfin.
       
      *Test compatiblité du sport demandé avec la salle
       MOVE fr_idSalle TO fa_idSalle
       MOVE fr_sportPratique TO fa_nomSport
       READ fassoc
       INVALID KEY
         MOVE 1 TO Wresaimpossible
         DISPLAY "Le sport demande n'est pas compatible avec la salle"
         
       NOT INVALID KEY
      *  Test disponibilité globale de la salle
         IF fs_dispo = 0 THEN
           MOVE 1 TO Wresaimpossible
           DISPLAY "La salle est indisponible"
         ELSE
      *    Vérifie heures d'ouverture & fermeture
           IF WHdebut > fs_ouv_h AND WHfin < fs_ferm_h THEN
      *      OK: cherche les résa en cours
             START fresa KEY IS = fr_idSalle
             INVALID KEY
               MOVE 0 TO Wresaimpossible
             NOT INVALID KEY
      *        Des résas, on cherche les créneaux dispos
               MOVE 0 TO Wresaimpossible
               PERFORM WITH TEST AFTER UNTIL Wresaimpossible=1
                 READ fresa NEXT
                 NOT AT END
                   IF (fr_dateFin_h > WHdebut AND fr_dateFin_h < WHfin) 
      -OR (fr_dateDebut_h > WHdebut AND fr_dateDebut_h < WHfin) OR (fr_d
      -ateDebut_h < WHdebut AND fr_dateFin_h > WHfin) THEN 
                     MOVE 1 TO Wresaimpossible 		
                   END-IF
                 END-READ
               END-PERFORM
             END-START
             IF Wresaimpossible = 1 THEN
               DISPLAY "Créneau occupé"
               MOVE 1 TO Wresaimpossible
             END-IF
           ELSE
      *      Hors des horaires d'ouverture
             MOVE 1 TO Wresaimpossible
             DISPLAY "Vous ne pouvez réserver à cette heure-ci"
           END-IF
         END-IF
       END-READ.
       
      * Recherche une salle
      ******************************************************************
       RECHERCHE_Salle.
       
       MOVE 0 TO Wfin 
       PERFORM WITH TEST AFTER UNTIL Wfin = 1  
        READ fsalle NEXT
        AT END MOVE 1 TO Wfin
         DISPLAY 'aucune salle possible !'
        NOT AT END
         PERFORM IS_DISPO
       END-PERFORM   
       DISPLAY "Entrez l'ID de la salle choisie"
       ACCEPT fs_id
       CLOSE fsalle.  
       
       
      *Ajoute une réservation
      ******************************************************************
       ADD_RESA.
       
      *OUVERTURES
       OPEN INPUT fsalle
       OPEN I-O fresa
    
      *MAIN
       DISPLAY 'Donnez les informations de votre reservation'
       DISPLAY 'Numero du club:'
       PERFORM WITH TEST AFTER UNTIL fr_idClub IS NUMERIC
         DISPLAY "Incorrect"
         ACCEPT fr_idClub
       END-PERFORM
      
      *Club existe ?
       MOVE fr_idClub TO fc_id
       OPEN INPUT fclub
       READ fclub
       INVALID KEY
         DISPLAY 'le club n existe pas !'
         
       NOT INVALID KEY
         DISPLAY 'Date de réservation ?'
         DISPLAY  'Jour:'
         PERFORM WITH TEST AFTER UNTIL fr_dateDebut_j IS NUMERIC
           ACCEPT fr_dateDebut_j
         END-PERFORM
         DISPLAY  'Mois:'
         PERFORM WITH TEST AFTER UNTIL fr_dateDebut_m IS NUMERIC
           ACCEPT fr_dateDebut_m
         END-PERFORM
         DISPLAY  'Année:'
          PERFORM WITH TEST AFTER UNTIL fr_dateDebut_a IS NUMERIC
           ACCEPT fr_dateDebut_a
         END-PERFORM
         DISPLAY 'Heure de début:'
         PERFORM WITH TEST AFTER UNTIL fr_dateDebut_h IS NUMERIC
           ACCEPT fr_dateDebut_h
         END-PERFORM
         DISPLAY 'Heure de fin:'
         PERFORM WITH TEST AFTER UNTIL fr_dateFin_h IS NUMERIC
           ACCEPT fr_dateFin_h
         END-PERFORM
         
         DISPLAY 'Quel sera le sport pratiqué ?'
         PERFORM WITH TEST AFTER UNTIL fr_sportPratique IS ALPHABETIC
           ACCEPT fr_sportPratique
         END-PERFORM
         
         PERFORM WITH TEST AFTER UNTIL Wrep1 = 0 OR Wrep1 = 1
           DISPLAY 'Voulez-vous une salle en particulier (0/1)?'  
           ACCEPT Wrep1
           IF Wrep1 = 0 THEN
             DISPLAY "HOP ON CHERCHE"
      *      PERFORM RECHERCHE_Salle
           ELSE
             DISPLAY 'Numero de la salle:'
             PERFORM WITH TEST AFTER UNTIL fr_idSalle IS NUMERIC
               ACCEPT fr_idSalle
             END-PERFORM
             MOVE fr_idSalle TO fs_id
             READ fsalle
             INVALID KEY
               DISPLAY "La salle n'existe pas !"
             
             NOT INVALID KEY
      *        Vérifie si le créneau est disponible
               PERFORM IS_DISPO
             END-READ
           END-IF
         END-PERFORM
       END-READ
         
       IF Wresaimpossible = 1 THEN
         DISPLAY "Réservation impossible"
       ELSE       
         OPEN I-O fresa
         WRITE Tresa
         INVALID KEY  
           DISPLAY "Erreur d'écriture"
         NOT INVALID KEY
           DISPLAY 'Reservation effectuée !'
         END-WRITE
       END-IF
       
      *FERMUTURES
       CLOSE fclub
       CLOSE fsalle
       CLOSE fresa.
