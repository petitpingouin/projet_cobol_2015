      *Initialisation fichier ID
       INIT_ID.
       PERFORM GET_FILE_STATUS
       IF WinitFile=0 THEN

         MOVE 'salle' TO fid_type
         MOVE '1' TO fid_idMax
         WRITE Tid

         MOVE 'ville' TO fid_type
         MOVE '1' TO fid_idMax
         WRITE Tid

         MOVE 'club' TO fid_type
         MOVE '1' TO fid_idMax
         WRITE Tid

         MOVE 'file_status' TO fid_type
         MOVE '1' to fid_idMax
         WRITE Tid

       END-IF

       MOVE 1 TO WinitFile
       
       PERFORM GET_ID_SALLE
       DISPLAY "ID salle :",WidCourantSalle.

      *Récupération de l'id courant de salle et incrémentation
       GET_ID_SALLE.
       READ fid
         NOT AT END
           IF fid_type='salle' THEN
              MOVE fid_idMax TO WidCourantSalle
              ADD fid_idMax 1 TO fid_idMax
              WRITE Tid
           END-IF.

      *Récupération de l'id courant de ville et incrémentation
       GET_ID_VILLE.
       READ fid
         NOT AT END
           IF fid_type='ville' THEN
              MOVE fid_idMax TO WidCourantVille
              ADD fid_idMax 1 TO fid_idMax
              WRITE Tid
           END-IF.
       
      *Récupération de l'id courant de club
       GET_ID_CLUB.
       READ fid
         NOT AT END
           IF fid_type='club' THEN
              MOVE fid_idMax TO WidCourantClub
              ADD fid_idMax 1 TO fid_idMax
              WRITE Tid
           END-IF.

       GET_FILE_STATUS.
       PERFORM WITH TEST AFTER UNTIL WinitFile=1 OR WfileStatus=0
         READ fid
           AT END
             MOVE 0 TO WfileStatus
             MOVE 0 TO WinitFile
           NOT AT END
             IF fid_type='file_status' THEN
                MOVE 1 TO WinitFile
             END-IF
       END-PERFORM.
