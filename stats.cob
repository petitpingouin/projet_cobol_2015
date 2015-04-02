      * Affiche le montant à payer pour le mois donné
      *****************************************************************
       FACTURE_MOIS.
       
       DISPLAY "Indiquez l'année:"
       PERFORM WITH TEST AFTER UNTIL Wresa_a > 1970 OR Wresa_a < 2038
         ACCEPT Wresa_a
       END-PERFORM
       DISPLAY "Indiquez le mois:"
       PERFORM WITH TEST AFTER UNTIL Wresa_m >= 1 OR Wresa_m <= 12
         ACCEPT Wresa_m
       END-PERFORM
       
       CLOSE fresa
       OPEN I-O fresa
       
       MOVE 0 TO Wresa_montant
       MOVE 0 TO Wresafin
       PERFORM WITH TEST AFTER UNTIL Wresafin = 1
         READ fresa NEXT
         AT END
           MOVE 1 TO Wresafin
         NOT AT END
           IF fr_dateDebut_a = Wresa_a AND fr_dateDebut_m = Wresa_m THEN
             COMPUTE Wresa_montant = fr_montant + Wresa_montant
           END-IF
         END-READ
       END-PERFORM
       
       DISPLAY "**************************************************"
       DISPLAY " Facture pour le mois ",Wresa_m,"/",Wresa_a
       DISPLAY "--------------------------------------------------"
       DISPLAY "Somme à payer: ", Wresa_montant
       DISPLAY " "
       DISPLAY "**************************************************".
       
