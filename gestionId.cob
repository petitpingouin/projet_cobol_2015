      *Initialisation fichier ID
       INIT_ID.
       CLOSE fid
       OPEN EXTEND fid

       IF WfileStatus=0 THEN

         MOVE 'file_stat' TO fid_type
         MOVE 1 to fid_idMax
         WRITE Tid

         MOVE 'salle' TO fid_type
         MOVE 1 TO fid_idMax
         WRITE Tid

         MOVE 'ville' TO fid_type
         MOVE 1 TO fid_idMax
         WRITE Tid

         MOVE 'club' TO fid_type
         MOVE 1 TO fid_idMax
         WRITE Tid

       END-IF.

      *Récupération de l'id courant de salle et incrémentation
       GET_ID_SALLE.
       MOVE 0 TO Wtrouve
       CLOSE fid
       OPEN I-O fid
       PERFORM WITH TEST AFTER UNTIL Wtrouve = 1
         READ fid NEXT
           AT END
             MOVE 1 TO Wtrouve
             DISPLAY "Erreur dans l'attribution d'un ID à cette salle"
             DISPLAY "Contactez un développeur."
           NOT AT END
             IF fid_type='salle' THEN
                MOVE fid_idMax TO WidCourantSalle
                ADD 1 TO Wtemp
                MOVE Wtemp TO fid_idMax
                REWRITE Tid
                MOVE 1 TO Wtrouve
             END-IF
       END-PERFORM.

      *Récupération de l'id courant de ville et incrémentation
       GET_ID_VILLE.
       MOVE 0 TO Wtrouve
       CLOSE fid
       OPEN I-O fid
       PERFORM WITH TEST AFTER UNTIL Wtrouve = 1
         READ fid NEXT
           AT END
             MOVE 1 TO Wtrouve
           NOT AT END
             IF fid_type='ville' THEN
                MOVE fid_idMax TO WidCourantVille
                ADD 1 TO Wtemp
                MOVE Wtemp TO fid_idMax
                REWRITE Tid
                DISPLAY "incrémentation ville"
                MOVE 1 TO Wtrouve
             END-IF
       END-PERFORM.
       
      *Récupération de l'id courant de club
       GET_ID_CLUB.
       MOVE 0 TO Wtrouve
       CLOSE fid
       OPEN I-O fid
       PERFORM WITH TEST AFTER UNTIL Wtrouve = 1
         READ fid NEXT
           AT END
             MOVE 1 TO Wtrouve
             DISPLAY "Erreur dans l'attribution d'un ID à ce club"
             DISPLAY "Contactez un développeur."
           NOT AT END
             IF fid_type='club' THEN
                MOVE fid_idMax TO WidCourantClub
                ADD 1 TO Wtemp
                MOVE Wtemp TO fid_idMax
                REWRITE Tid
                MOVE 1 TO Wtrouve
             END-IF
       END-PERFORM.

      * Récupération de l'état du fichier d'initialisation
       GET_FILE_STATUS.
       MOVE 0 TO Wtrouve
       MOVE 0 TO WfileStatus
       CLOSE fid
       OPEN I-O fid
       PERFORM WITH TEST AFTER UNTIL Wtrouve = 1
         READ fid NEXT
           AT END
             MOVE 1 TO Wtrouve
           NOT AT END
             IF fid_type='file_stat' THEN
                MOVE fid_idMax TO WfileStatus
                MOVE 1 TO Wtrouve
             END-IF
       END-PERFORM
       DISPLAY "statut : ",WfileStatus.
