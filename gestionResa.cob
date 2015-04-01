      * Affichage des résas par salle
      *****************************************************************
       DISPLAY_RESAS_BY_SALLE.
       
       CLOSE fresa
       OPEN I-O fresa
       
       DISPLAY 'Id de la salle'
       DISPLAY "Chercher l'ID de la salle ? (0/1)"
       
       MOVE 5 TO WcrudChoix
       PERFORM WITH TEST AFTER UNTIL WcrudChoix = 0 OR WcrudChoix = 1
         ACCEPT WcrudChoix
       END-PERFORM
       
       IF WcrudChoix = 1 THEN
      *  On affiche les ID des salles
         CLOSE fsalle
         OPEN I-O fsalle
         DISPLAY "--------  Salles ---------"
         DISPLAY "--------------------------"
         DISPLAY " ID / Nom / Ville / Adresse "
         DISPLAY " --- "
         MOVE 0 TO WcrudFin
         PERFORM WITH TEST AFTER UNTIL WcrudFin = 1
           READ fsalle NEXT
           AT END
             MOVE 1 TO WcrudFin
           NOT AT END
             MOVE fs_ville TO fv_id
             READ fville
             INVALID KEY
               DISPLAY "/!\ Erreur dans la matrice (ville pour salle)"
             NOT INVALID KEY
               DISPLAY fs_id," / ",fs_nom," / ",fv_nom," / ",fs_addr
             END-READ
           END-READ
         END-PERFORM
         DISPLAY "--------------------------"
        
       END-IF
       
      *Sélection directe de la salle
       MOVE 1 TO WcrudChoix
       PERFORM WITH TEST AFTER UNTIL WcrudChoix = 0
         DISPLAY "Entrez l'ID de la salle correspondante:"
         PERFORM WITH TEST AFTER UNTIL fs_id IS NUMERIC
           ACCEPT fs_id
         END-PERFORM
         
      *  La salle existe-t-elle?
         READ fsalle
         INVALID KEY
           DISPLAY "La salle n'existe pas"
         NOT INVALID KEY
           MOVE 0 TO WcrudChoix
         END-READ
       END-PERFORM.
       
       DISPLAY "**********************************************"
       
       MOVE fs_id TO fr_idSalle
       START fresa KEY IS = fr_idSalle
       INVALID KEY
         DISPLAY "Pas de réservations pour cette salle"
       NOT INVALID KEY
         MOVE 0 TO WendSearch
         PERFORM WITH TEST AFTER UNTIL WendSearch = 1
         READ fresa NEXT
         AT END
           MOVE 1 TO WendSearch
         NOT AT END
           DISPLAY "Id Salle:", fr_idSalle
           DISPLAY "Club: ", fr_idClub
           DISPLAY "Sport: ", fr_sportPratique
           DISPLAY "Date: ",fr_dateDebut_j,"/",fr_dateDebut_m,"/",fr_dat
      -eDebut_j
           DISPLAY "De ", fr_dateDebut_h, " à ", fr_dateFin_h
           IF WconnectedAsAdmin = 1 THEN
             DISPLAY "Montant: ", fr_montant
           END-IF
           DISPLAY "----------------"
         END-READ
       END-PERFORM.
       
       
      * Affichage des réservations pour un club
      ****************************************************************
       DISPLAY_RESAS_BY_CLUB.
       
       IF WconnectedAsAdmin = 0 THEN
         MOVE WnumClub TO fc_id
       ELSE
         DISPLAY "Entrez l'ID du club"
         PERFORM WITH TEST AFTER UNTIL fc_id IS NUMERIC
           ACCEPT fc_id
         END-PERFORM
       END-IF
       
       READ fclub KEY IS fc_id
       INVALID KEY
         DISPLAY "Il n'existe pas de club portant ce numéro"
       NOT INVALID KEY
         MOVE fc_id TO WnumClub
         CLOSE fresa
         OPEN I-O fresa
         DISPLAY "**********************************************"
         MOVE 0 TO WendSearch
         PERFORM WITH TEST AFTER UNTIL WendSearch = 1
           READ fresa NEXT
           AT END
             MOVE 1 TO WendSearch
           NOT AT END
      *      N'affiche que si admin ou résa du club
             IF WnumClub = fr_idClub THEN 
               DISPLAY "Id Salle:", fr_idSalle
               DISPLAY "Club: ", fr_idClub
               DISPLAY "Sport: ", fr_sportPratique
               DISPLAY "Date: ",fr_dateDebut_j,"/",fr_dateDebut_m,"/",fr
      -_dateDebut_j
               DISPLAY "De ", fr_dateDebut_h, " à ", fr_dateFin_h
               IF WconnectedAsAdmin = 1 THEN
                 DISPLAY "Montant: ", fr_montant
               END-IF
               DISPLAY "----------------"
             END-IF
           END-READ
         END-PERFORM
       END-READ.
        
