      *--PH--
      *Affiche les réservations du club
       SHOW_RESAS.
       
       DISPLAY "Entrez le jour:"
      * PERFORM WITH TEST AFTER UNTIL  IS NUMERIC
         ACCEPT fs_id
      * END-PERFORM
