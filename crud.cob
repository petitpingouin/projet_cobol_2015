      *****************************************************************
      * CREATIONS
      *****************************************************************
      *Création d'une ville
       CREATE_TOWN.
        
       CLOSE fville
       OPEN I-O fville

       PERFORM GET_ID_VILLE
       MOVE WidCourantVille TO fv_id

       DISPLAY "Identifiant : ",fv_id

       DISPLAY'Donnez un nom'
       ACCEPT fv_nom
       
       DISPLAY'Donnez un code postal'
       PERFORM WITH TEST AFTER UNTIL fv_codePost IS NUMERIC
         ACCEPT fv_codePost
       END-PERFORM
       
       DISPLAY "Cette ville fait-elle partie de l'agglomération?"
       PERFORM WITH TEST AFTER UNTIL fv_agglo = 1 OR fv_agglo = 0
         ACCEPT fv_agglo
       END-PERFORM
       
       WRITE Tville
       INVALID KEY
         DISPLAY "/!\ Erreur"
       NOT INVALID KEY
         DISPLAY "La ville a été créé.".


      *Création d'une salle
       CREATE_ROOM.
       PERFORM GET_ID_SALLE
       MOVE WidCourantSalle TO fs_id

       DISPLAY "Identifiant : ",fs_id

       DISPLAY'Donnez un nom'
       PERFORM WITH TEST AFTER UNTIL fs_nom IS ALPHABETIC
         ACCEPT fs_nom
       END-PERFORM

       DISPLAY "Donnez l'heure d'ouverture :"
       PERFORM WITH TEST AFTER UNTIL fs_ouv_h IS NUMERIC AND fs_ouv_h >=
      - 0 AND fs_ouv_h <= 23
         ACCEPT fs_ouv_h
       END-PERFORM
       
       DISPLAY "Donnez l'heure de fermeture :"
       PERFORM WITH TEST AFTER UNTIL fs_ferm_h IS NUMERIC AND fs_ferm_h 
      ->= 0 AND fs_ferm_h <= 23 AND fs_ferm_h > fs_ouv_h
         ACCEPT fs_ferm_h
       END-PERFORM
        
       DISPLAY "Chercher l'ID de la ville du club ? (0/1)"
       
       MOVE 5 TO WcrudChoix
       PERFORM WITH TEST AFTER UNTIL WcrudChoix = 0 OR WcrudChoix = 1
         ACCEPT WcrudChoix
       END-PERFORM
       IF WcrudChoix = 1 THEN
      *  On affiche les ID des villes
         CLOSE fville
         OPEN I-O fville
         DISPLAY "--------  Villes ---------"
         DISPLAY "--------------------------"
         DISPLAY " ID / Nom "
         DISPLAY " --- "
         MOVE 0 TO WcrudFin
         PERFORM WITH TEST AFTER UNTIL WcrudFin = 1
           READ fville NEXT
             AT END
               MOVE 1 TO WcrudFin
             NOT AT END
               DISPLAY fv_id, " / ", fv_nom
           END-READ
         END-PERFORM
         DISPLAY "--------------------------"
        
         MOVE 1 TO WcrudChoix
         PERFORM WITH TEST AFTER UNTIL WcrudChoix = 0
           DISPLAY "Entrez l'ID de la ville correspondante:"
           PERFORM WITH TEST AFTER UNTIL fs_ville IS NUMERIC
             ACCEPT fs_ville
           END-PERFORM
           
      *    La ville existe-t-elle?
           MOVE fs_ville TO fv_id
           READ fville KEY IS fv_id
           INVALID KEY
             DISPLAY "La salle n'existe pas"
           NOT INVALID KEY
             MOVE 0 TO WcrudChoix
           END-READ
         END-PERFORM
         
       ELSE
      *  Sélection directe de la ville
         MOVE 1 TO WcrudChoix
         PERFORM WITH TEST AFTER UNTIL WcrudChoix = 0
           DISPLAY "Entrez l'ID de la ville correspondante:"
           PERFORM WITH TEST AFTER UNTIL fs_ville IS NUMERIC
             ACCEPT fs_ville
           END-PERFORM
           
      *    La ville existe-t-elle?
           MOVE fs_ville TO fv_id
           READ fville KEY IS fv_id
           INVALID KEY
             DISPLAY "La salle n'existe pas"
           NOT INVALID KEY
             MOVE 0 TO WcrudChoix
           END-READ
         END-PERFORM
       END-IF
       
       DISPLAY "Entrez l'adresse de la salle"
       ACCEPT fs_addr
      
       DISPLAY "Entrez le prix de location pour une heure"
       PERFORM WITH TEST AFTER UNTIL fs_prix IS NUMERIC
         ACCEPT fs_prix
       END-PERFORM
       
       DISPLAY "Disponibilité ? (0: indisponible, 1: disponible)"
       PERFORM WITH TEST AFTER UNTIL fs_dispo = 1 OR fs_dispo = 0
         ACCEPT fs_dispo
       END-PERFORM
       
       WRITE Tsalle
       INVALID KEY
         DISPLAY "/!\ Erreur"
       NOT INVALID KEY
         DISPLAY "La salle a été créée.".
      
      *Création d'un club
       CREATE_CLUB.

       PERFORM GET_ID_CLUB
       MOVE WidCourantClub TO fc_id

       DISPLAY "Identifiant : ",fc_id

       DISPLAY'Donnez un nom'
       PERFORM WITH TEST AFTER UNTIL fc_nom IS ALPHABETIC
         ACCEPT fc_nom
       END-PERFORM
       
       DISPLAY'Donnez une adresse'
       ACCEPT fc_addr
       
       DISPLAY'Donnez le nom du président'
       PERFORM WITH TEST AFTER UNTIL fc_president IS ALPHABETIC
         ACCEPT fc_president
       END-PERFORM
       
       DISPLAY "Chercher l'ID de la ville du club ? (0/1)"
       
       MOVE 5 TO WcrudChoix
       PERFORM WITH TEST AFTER UNTIL WcrudChoix = 0 OR WcrudChoix = 1
         ACCEPT WcrudChoix
       END-PERFORM
       IF WcrudChoix = 1 THEN
      *  On affiche les ID des villes
         CLOSE fville
         OPEN I-O fville
         DISPLAY "--------  Villes ---------"
         DISPLAY "--------------------------"
         DISPLAY " ID / Nom "
         DISPLAY " --- "
         MOVE 0 TO WcrudFin
         PERFORM WITH TEST AFTER UNTIL WcrudFin = 1
           READ fville NEXT
             AT END
               MOVE 1 TO WcrudFin
             NOT AT END
               DISPLAY fv_id, " / ", fv_nom
           END-READ
         END-PERFORM
         DISPLAY "--------------------------"
       END-IF
        
      *Sélection directe de la ville
       MOVE 1 TO WcrudChoix
       PERFORM WITH TEST AFTER UNTIL WcrudChoix = 0
         DISPLAY "Entrez l'ID de la ville correspondante:"
         PERFORM WITH TEST AFTER UNTIL fc_ville IS NUMERIC
           ACCEPT fc_ville
         END-PERFORM
         
      *  La ville existe-t-elle?
         MOVE fc_ville TO fv_id
         READ fville KEY IS fv_id
         INVALID KEY
           DISPLAY "La salle n'existe pas"
         NOT INVALID KEY
           MOVE 0 TO WcrudChoix
         END-READ
       END-PERFORM
       
       
       DISPLAY'Donnez le sport proposé par le club'
       PERFORM WITH TEST AFTER UNTIL fc_sport IS ALPHABETIC
         ACCEPT fc_sport
       END-PERFORM
       
       WRITE Tclub
       INVALID KEY
         DISPLAY "/!\ Erreur"
       NOT INVALID KEY
         DISPLAY "Le club a été créé".
       
       
      *Création d'une association sport/salle
       CREATE_ASSOC.
       
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
        
         MOVE 1 TO WcrudChoix
         PERFORM WITH TEST AFTER UNTIL WcrudChoix = 0
           DISPLAY "Entrez l'ID de la salle correspondante:"
           PERFORM WITH TEST AFTER UNTIL fa_idSalle IS NUMERIC
             ACCEPT fa_idSalle
           END-PERFORM
           
      *    La salle existe-t-elle?
           MOVE fa_idSalle TO fs_id
           READ fsalle KEY IS fs_id
           INVALID KEY
             DISPLAY "La salle n'existe pas"
           NOT INVALID KEY
             MOVE 0 TO WcrudChoix
             DISPLAY "Sport à associer: "
             PERFORM WITH TEST AFTER UNTIL fa_nomSport IS ALPHABETIC
               ACCEPT fa_nomSport
             END-PERFORM
              
             WRITE Tassoc
             INVALID KEY
               DISPLAY "/!\ Erreur"
             NOT INVALID KEY
               DISPLAY "Association ajoutée"
           END-READ
         END-PERFORM
         
       ELSE
      *  Sélection directe de la salle
         MOVE 1 TO WcrudChoix
         PERFORM WITH TEST AFTER UNTIL WcrudChoix = 0
           DISPLAY "Entrez l'ID de la salle correspondante:"
           PERFORM WITH TEST AFTER UNTIL fs_id IS NUMERIC
             ACCEPT fs_id
           END-PERFORM
           
      *    La salle existe-t-elle?
           MOVE fs_id TO fs_id
           READ fsalle
           INVALID KEY
             DISPLAY "La salle n'existe pas"
           NOT INVALID KEY
             MOVE 0 TO WcrudChoix
             DISPLAY "Sport à associer: "
             PERFORM WITH TEST AFTER UNTIL fa_nomSport IS ALPHABETIC
               ACCEPT fa_nomSport
             END-PERFORM
              
             WRITE Tassoc
             INVALID KEY
               DISPLAY "/!\ Erreur"
             NOT INVALID KEY
               DISPLAY "Association ajoutée"
           END-READ
         END-PERFORM
       END-IF.
        
      *****************************************************************
      * LECTURES
      *****************************************************************
      *LECTURE D'UNE VILLE
       READ_TOWN.

       DISPLAY "Entrez l'ID de la ville à lire"
       PERFORM WITH TEST AFTER UNTIL fv_id IS NUMERIC
         ACCEPT fv_id
       END-PERFORM
       READ fville KEY IS fv_id
          INVALID KEY
            DISPLAY "Il n'existe pas de ville portant ce numéro"
          NOT INVALID KEY
            DISPLAY "Nom de la ville : ",fv_nom
            DISPLAY "Code postal de la ville : ",fv_codePost.

      *LECTURE D'UNE SALLE
       READ_ROOM.

       DISPLAY "Entrez l'ID de la salle à lire"
       PERFORM WITH TEST AFTER UNTIL fs_id IS NUMERIC
         ACCEPT fs_id
       END-PERFORM
       READ fsalle KEY IS fs_id
          INVALID KEY
            DISPLAY "Il n'existe pas de salle portant ce numéro"
          NOT INVALID KEY
            DISPLAY "Nom de la salle : ",fs_nom
            DISPLAY "Disponibilité de la salle : ",fs_dispo
            DISPLAY "H ouverture salle :",fs_ouv_h
            DISPLAY "H de fermeture salle :",fs_ferm_h
            DISPLAY "Adresse de la salle : ",fs_addr
            DISPLAY "Ville de la salle : ",fs_ville
            DISPLAY "Prix de la salle : ",fs_prix
       END-READ.

      *LECTURE D'UN CLUB
       READ_CLUB.

       DISPLAY "Entrez l'ID du club à lire"
       PERFORM WITH TEST AFTER UNTIL fc_id IS NUMERIC
         ACCEPT fc_id
       END-PERFORM
       READ fville KEY IS fc_id
          INVALID KEY
            DISPLAY "Il n'existe pas de club portant ce numéro"
          NOT INVALID KEY
            DISPLAY "Nom du club : ",fc_nom
            DISPLAY "Adresse du club : ",fc_addr
            DISPLAY "Nom du président : ",fc_president
            DISPLAY "Ville de la salle : ",fc_ville
            DISPLAY "Sport proposé par le club : ",fc_sport.
       
      *LECTURE DES ASSOCIATIONS PAR SALLE
       READ_ASSOC_BY_SALLE.
       
       CLOSE fassoc
       OPEN I-O fassoc

       DISPLAY "Entrez l'ID de la salle"
       PERFORM WITH TEST AFTER UNTIL fa_idSalle IS NUMERIC
         ACCEPT fa_idSalle
       END-PERFORM
       START fassoc KEY IS = fa_idSalle
       INVALID KEY
         DISPLAY "Salle inexistante"
       NOT INVALID KEY
         MOVE 0 TO WendSearch
         PERFORM WITH TEST AFTER UNTIL WendSearch = 1
           READ fassoc NEXT
           AT END
             MOVE 1 TO WendSearch
           NOT AT END
             DISPLAY fa_idSalle," / ", fa_nomSport
           END-READ
          END-PERFORM
       END-START.

      ****************************************************************
      * AFFICHAGES
      ****************************************************************
      *Affichage des villes
       DISPLAY_VILLES.
       
       CLOSE fville
       OPEN I-O fville
       DISPLAY "**********************************************"
       MOVE 0 TO WendSearch
       PERFORM WITH TEST AFTER UNTIL WendSearch = 1
         READ fville NEXT
         AT END
           MOVE 1 TO WendSearch
         NOT AT END
           DISPLAY "**** Id:",fv_id," ****"
           DISPLAY "Nom de la ville : ",fv_nom
           DISPLAY "Code postal de la ville : ",fv_codePost
           DISPLAY "Agglo ?: ",fv_agglo
           DISPLAY "----------------"
         END-READ
       END-PERFORM.
       
      *Affichage des clubs
       DISPLAY_CLUBS.
       
       CLOSE fclub
       OPEN I-O fclub
       DISPLAY "**********************************************"
       MOVE 0 TO WendSearch
       PERFORM WITH TEST AFTER UNTIL WendSearch = 1
         READ fclub NEXT
         AT END
           MOVE 1 TO WendSearch
         NOT AT END
           DISPLAY "**** Id:",fc_id," ****"
           DISPLAY "Nom du club : ",fc_nom
           DISPLAY "Adresse du club : ",fc_addr
           DISPLAY "Nom du président : ",fc_president
           DISPLAY "Ville de la salle : ",fc_ville
           DISPLAY "Sport proposé par le club : ",fc_sport
           DISPLAY "----------------"
       END-PERFORM.
       
      *Affichage des salles
       DISPLAY_SALLES.

       CLOSE fsalle
       OPEN I-O fsalle

       DISPLAY "**********************************************"
       MOVE 0 TO WendSearch
       PERFORM WITH TEST AFTER UNTIL WendSearch = 1
         READ fsalle NEXT
           AT END
             MOVE 1 TO WendSearch
           NOT AT END
             DISPLAY "**** Id:",fs_id," ****"
             DISPLAY "Nom de la salle : ",fs_nom
             DISPLAY "Disponibilité de la salle : ",fs_dispo
             DISPLAY "H ouverture salle :",fs_ouv_h
             DISPLAY "H de fermeture salle :",fs_ferm_h
             DISPLAY "Adresse de la salle : ",fs_addr
             DISPLAY "Ville de la salle : ",fs_ville
             DISPLAY "Prix de la salle : ",fs_prix
             DISPLAY "----------------"
       END-PERFORM.
       
      *Affichage des associations
       DISPLAY_ASSOC.
       
       CLOSE fassoc
       OPEN I-O fassoc
       DISPLAY "**********************************************"
       DISPLAY "ID Salle / Sport"
       DISPLAY "--------------"
       MOVE 0 TO WendSearch
       PERFORM WITH TEST AFTER UNTIL WendSearch = 1
         READ fassoc NEXT
         AT END
           MOVE 1 TO WendSearch
         NOT AT END
           DISPLAY fa_idSalle," / ", fa_nomSport
         END-READ
       END-PERFORM.
      
      *Affichage de toutes les réservations
       DISPLAY_RESAS.
       
       CLOSE fresa
       OPEN I-O fresa
       DISPLAY "**********************************************"
       MOVE 0 TO WendSearch
       PERFORM WITH TEST AFTER UNTIL WendSearch = 1
         READ fresa NEXT
         AT END
           MOVE 1 TO WendSearch
         NOT AT END
      *    N'affiche que si admin ou résa du club
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

      ****************************************************************
      * MODIFICATIONS
      ****************************************************************

      * Modifications propres à la ville
      * Modification du nom d'une ville
       MODIFY_TOWN_NOM.

       DISPLAY "Entrez l'ID de la ville à modifier"
       PERFORM WITH TEST AFTER UNTIL fv_id IS NUMERIC
         ACCEPT fv_id
       END-PERFORM
       READ fville KEY IS fv_id
          INVALID KEY
            DISPLAY "Il n'existe pas de ville portant ce numéro"
          NOT INVALID KEY
            DISPLAY "Entrez le nouveau nom de la ville"
            ACCEPT fv_nom
            REWRITE Tville
              INVALID KEY
                 DISPLAY "La ville a été modifiée avec succès."
               NOT INVALID KEY
                 DISPLAY "Erreur de réécriture.".

      * Modification du code postal de la ville
       MODIFY_TOWN_CODE.

       DISPLAY "Entrez l'ID de la ville à modifier"
       PERFORM WITH TEST AFTER UNTIL fv_id IS NUMERIC
         ACCEPT fv_id
       END-PERFORM
       READ fville KEY IS fv_id
          INVALID KEY
            DISPLAY "Il n'existe pas de ville portant ce numéro"
          NOT INVALID KEY
            DISPLAY "Entrez le nouveau code postal de la ville"
            PERFORM WITH TEST AFTER UNTIL fv_codePost IS NUMERIC
              ACCEPT fv_codePost
            END-PERFORM
            REWRITE Tville
              INVALID KEY
                 DISPLAY "La ville a été modifiée avec succès."
               NOT INVALID KEY
                 DISPLAY "Erreur de réécriture.".

      * Modification de l'agglomération de la ville
       MODIFY_TOWN_AGGLO.

       DISPLAY "Entrez l'ID de la ville à modifier"
       PERFORM WITH TEST AFTER UNTIL fv_id IS NUMERIC
         ACCEPT fv_id
       END-PERFORM
       READ fville KEY IS fv_id
          INVALID KEY
            DISPLAY "Il n'existe pas de ville portant ce numéro"
          NOT INVALID KEY
            DISPLAY "La ville fait-elle partie de l'agglomération ?"
            PERFORM WITH TEST AFTER UNTIL fv_agglo=0 OR fv_agglo=1
              ACCEPT fv_agglo
            END-PERFORM
            REWRITE Tville
              INVALID KEY
                 DISPLAY "Erreur de réécriture."
               NOT INVALID KEY
                 DISPLAY "La ville a été modifiée avec succès.".

      * Modifications propres à une salle
      
      * Modification du nom de la salle
       MODIFY_ROOM_NOM.

       DISPLAY "Entrez l'ID de la salle"
       PERFORM WITH TEST AFTER UNTIL fs_id IS NUMERIC
         ACCEPT fs_id
       END-PERFORM
       READ fsalle KEY IS fs_id
          INVALID KEY
            DISPLAY "Il n'existe pas de salle portant ce numéro"
          NOT INVALID KEY
            DISPLAY "Entrez le nouveau nom de la salle"
            PERFORM WITH TEST AFTER UNTIL fs_nom IS ALPHABETIC
              ACCEPT fs_nom
            END-PERFORM
            REWRITE Tsalle
               INVALID KEY
                 DISPLAY "Erreur de réécriture."
               NOT INVALID KEY
                 DISPLAY "La salle a été modifiée avec succès.".

      * Modification de la disponibilité de la salle
       MODIFY_ROOM_DISPO.

       DISPLAY "Entrez l'ID de la salle"
       PERFORM WITH TEST AFTER UNTIL fs_id IS NUMERIC
         ACCEPT fs_id
       END-PERFORM
       READ fsalle KEY IS fs_id
          INVALID KEY
            DISPLAY "Il n'existe pas de salle portant ce numéro"
          NOT INVALID KEY
            DISPLAY "Entrez la disponibilité de la salle"
            PERFORM WITH TEST AFTER UNTIL fs_dispo = 0 OR fs_dispo = 1
              ACCEPT fs_dispo
            END-PERFORM
            REWRITE Tsalle
               INVALID KEY
                 DISPLAY "Erreur de réécriture."
               NOT INVALID KEY
                 DISPLAY "La salle a été modifiée avec succès.".


      * Modification de l'heure d'ouverture de la salle
       MODIFY_ROOM_OUV.
       DISPLAY "Entrez l'ID de la salle"
       PERFORM WITH TEST AFTER UNTIL fs_id IS NUMERIC
         ACCEPT fs_id
       END-PERFORM
       READ fsalle KEY IS fs_id
          INVALID KEY
            DISPLAY "Il n'existe pas de salle portant ce numéro"
          NOT INVALID KEY
            DISPLAY "Entrez l'heure d'ouverture de la salle (hh) :"
            PERFORM WITH TEST AFTER UNTIL fs_ouv_h IS NUMERIC AND fs_ouv
      -_h >= 0 AND fs_ouv_h <= 23
              ACCEPT fs_ouv_h
            END-PERFORM
            REWRITE Tsalle
               INVALID KEY
                 DISPLAY "Erreur de réécriture."
               NOT INVALID KEY
                 DISPLAY "La salle a été modifiée avec succès.".

      * Modification de l'heure de fermeture de la salle
       MODIFY_ROOM_FERM.
       DISPLAY "Entrez l'ID de la salle"
       PERFORM WITH TEST AFTER UNTIL fs_id IS NUMERIC
         ACCEPT fs_id
       END-PERFORM
       READ fsalle KEY IS fs_id
          INVALID KEY
            DISPLAY "Il n'existe pas de salle portant ce numéro"
          NOT INVALID KEY
            DISPLAY "Entrez l'heure de fermeture de la salle (hh)"
            PERFORM WITH TEST AFTER UNTIL fs_ferm_h IS NUMERIC AND fs_fe
      -rm_h >= 0 AND fs_ferm_h <= 23 AND fs_ferm_h > fs_ouv_h
              ACCEPT fs_ferm_h
            END-PERFORM
            REWRITE Tsalle
               INVALID KEY
                 DISPLAY "Erreur de réécriture."
               NOT INVALID KEY
                 DISPLAY "La salle a été modifiée avec succès.".

      * Modification de l'adresse de la salle
       MODIFY_ROOM_ADDR.
       DISPLAY "Entrez l'ID de la salle"
       PERFORM WITH TEST AFTER UNTIL fs_id IS NUMERIC
         ACCEPT fs_id
       END-PERFORM
       READ fsalle KEY IS fs_id
          INVALID KEY
            DISPLAY "Il n'existe pas de salle portant ce numéro"
          NOT INVALID KEY
            DISPLAY "Entrez la nouvelle adresse de la salle"
            PERFORM WITH TEST AFTER UNTIL fs_addr IS ALPHABETIC
              ACCEPT fs_addr
            END-PERFORM
            REWRITE Tsalle
               INVALID KEY
                 DISPLAY "Erreur de réécriture."
               NOT INVALID KEY
                 DISPLAY "La salle a été modifiée avec succès.".

      * Modification de la ville de la salle
       MODIFY_ROOM_VILLE.
       DISPLAY "Entrez l'ID de la salle"
       PERFORM WITH TEST AFTER UNTIL fs_id IS NUMERIC
         ACCEPT fs_id
       END-PERFORM
       
       READ fsalle KEY IS fs_id
          INVALID KEY
            DISPLAY "Il n'existe pas de salle portant ce numéro"
          NOT INVALID KEY
            
            DISPLAY "Chercher l'ID de la ville ? (0/1)"
       
            MOVE 5 TO WcrudChoix
            PERFORM WITH TEST AFTER UNTIL WcrudChoix=0 OR WcrudChoix = 1
              ACCEPT WcrudChoix
            END-PERFORM
            IF WcrudChoix = 1 THEN
      *       On affiche les ID des villes
              CLOSE fville
              OPEN I-O fville
              DISPLAY "--------  Villes ---------"
              DISPLAY "--------------------------"
              DISPLAY " ID / Nom "
              DISPLAY " --- "
              MOVE 0 TO WcrudFin
              PERFORM WITH TEST AFTER UNTIL WcrudFin = 1
                READ fville NEXT
                  AT END
                    MOVE 1 TO WcrudFin
                  NOT AT END
                    DISPLAY fv_id, " / ", fv_nom
                END-READ
              END-PERFORM
              DISPLAY "--------------------------"
             
              MOVE 1 TO WcrudChoix
              PERFORM WITH TEST AFTER UNTIL WcrudChoix = 0
                DISPLAY "Entrez l'ID de la ville correspondante:"
                PERFORM WITH TEST AFTER UNTIL fs_ville IS NUMERIC
                  ACCEPT fs_ville
                END-PERFORM
               
      *         La ville existe-t-elle?
                MOVE fs_ville TO fv_id
                READ fville KEY IS fv_id
                INVALID KEY
                  DISPLAY "La salle n'existe pas"
                NOT INVALID KEY
                  MOVE 0 TO WcrudChoix
                END-READ
              END-PERFORM
              
            ELSE
      *       Sélection directe de la ville
              MOVE 1 TO WcrudChoix
              PERFORM WITH TEST AFTER UNTIL WcrudChoix = 0
                DISPLAY "Entrez l'ID de la ville correspondante:"
                PERFORM WITH TEST AFTER UNTIL fs_ville IS NUMERIC
                  ACCEPT fs_ville
                END-PERFORM
               
      *         La ville existe-t-elle?
                MOVE fs_ville TO fv_id
                READ fville KEY IS fv_id
                INVALID KEY
                  DISPLAY "La salle n'existe pas"
                NOT INVALID KEY
                  MOVE 0 TO WcrudChoix
                END-READ
              END-PERFORM
            END-IF
                        
            REWRITE Tsalle
               INVALID KEY
                 DISPLAY "Erreur de réécriture."
               NOT INVALID KEY
                 DISPLAY "La salle a été modifiée avec succès."
        END-READ.

      * Modification du prix de la salle
       MODIFY_ROOM_PRIX.
       DISPLAY "Entrez l'ID de la salle"
       PERFORM WITH TEST AFTER UNTIL fs_id IS NUMERIC
         ACCEPT fs_id
       END-PERFORM
       READ fsalle KEY IS fs_id
          INVALID KEY
            DISPLAY "Il n'existe pas de salle portant ce numéro"
          NOT INVALID KEY
            DISPLAY "Entrez le nouveau prix de location de la salle"
            PERFORM WITH TEST AFTER UNTIL fs_prix IS NUMERIC
              ACCEPT fs_prix
             END-PERFORM
            REWRITE Tsalle
               INVALID KEY
                 DISPLAY "Erreur de réécriture."
               NOT INVALID KEY
                 DISPLAY "La salle a été modifiée avec succès.".

      * Modifications propres au club
      *MODIFICATION DU NOM CLUB
       MODIFY_CLUB_NOM.
       
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
            DISPLAY "Entrez le nouveau nom du club"
            PERFORM WITH TEST AFTER UNTIL fc_nom IS ALPHABETIC
              ACCEPT fc_nom
            END-PERFORM
            REWRITE Tclub
              INVALID KEY
                 DISPLAY "Erreur de réécriture."
               NOT INVALID KEY
                 DISPLAY "Le club a été modifiée avec succès.".

      *MODIFICATION DE L'ADRESSE DU CLUB
       MODIFY_CLUB_ADDR.

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
            DISPLAY "Entrez la nouvelle adresse du club"
            PERFORM WITH TEST AFTER UNTIL fc_addr IS ALPHABETIC
              ACCEPT fc_addr
            END-PERFORM
            REWRITE Tclub
              INVALID KEY
                 DISPLAY "Erreur de réécriture."
               NOT INVALID KEY
                 DISPLAY "Le club a été modifiée avec succès.".

      *MODIFICATION DU PRESIDENT DU CLUB
       MODIFY_CLUB_PSDT.

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
            DISPLAY "Entrez le nom du nouveau président du club"
            PERFORM WITH TEST AFTER UNTIL fc_president IS ALPHABETIC
              ACCEPT fc_president
            END-PERFORM
            REWRITE Tclub
              INVALID KEY
                 DISPLAY "Erreur de réécriture."
               NOT INVALID KEY
                 DISPLAY "Le club a été modifiée avec succès.".

      *MODIFICATION DE LA VILLE DU CLUB
       MODIFY_CLUB_TOWN.

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
            
            DISPLAY "Chercher l'ID de la ville ? (0/1)"
       
            MOVE 5 TO WcrudChoix
            PERFORM WITH TEST AFTER UNTIL WcrudChoix=0 OR WcrudChoix = 1
              ACCEPT WcrudChoix
            END-PERFORM
            IF WcrudChoix = 1 THEN
      *       On affiche les ID des villes
              CLOSE fville
              OPEN I-O fville
              DISPLAY "--------  Villes ---------"
              DISPLAY "--------------------------"
              DISPLAY " ID / Nom "
              DISPLAY " --- "
              MOVE 0 TO WcrudFin
              PERFORM WITH TEST AFTER UNTIL WcrudFin = 1
                READ fville NEXT
                  AT END
                    MOVE 1 TO WcrudFin
                  NOT AT END
                    DISPLAY fv_id, " / ", fv_nom
                END-READ
              END-PERFORM
              DISPLAY "--------------------------"
             
              MOVE 1 TO WcrudChoix
              PERFORM WITH TEST AFTER UNTIL WcrudChoix = 0
                DISPLAY "Entrez l'ID de la ville correspondante:"
                PERFORM WITH TEST AFTER UNTIL fc_ville IS NUMERIC
                  ACCEPT fc_ville
                END-PERFORM
               
      *         La ville existe-t-elle?
                MOVE fc_ville TO fv_id
                READ fville KEY IS fv_id
                INVALID KEY
                  DISPLAY "La salle n'existe pas"
                NOT INVALID KEY
                  MOVE 0 TO WcrudChoix
                END-READ
              END-PERFORM
              
            ELSE
      *       Sélection directe de la ville
              MOVE 1 TO WcrudChoix
              PERFORM WITH TEST AFTER UNTIL WcrudChoix = 0
                DISPLAY "Entrez l'ID de la ville correspondante:"
                PERFORM WITH TEST AFTER UNTIL fc_ville IS NUMERIC
                  ACCEPT fc_ville
                END-PERFORM
               
      *         La ville existe-t-elle?
                MOVE fc_ville TO fv_id
                READ fville KEY IS fv_id
                INVALID KEY
                  DISPLAY "La salle n'existe pas"
                NOT INVALID KEY
                  MOVE 0 TO WcrudChoix
                END-READ
              END-PERFORM
            END-IF
          
            REWRITE Tclub
              INVALID KEY
                 DISPLAY "Erreur de réécriture."
               NOT INVALID KEY
                 DISPLAY "Le club a été modifiée avec succès.".

      *MODIFICATION DU SPORT DU CLUB
       MODIFY_CLUB_SPORT.

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
            DISPLAY "Entrez le nouveau sport du club"
            PERFORM WITH TEST AFTER UNTIL fc_sport IS ALPHABETIC
             ACCEPT fc_sport
            END-PERFORM
            REWRITE Tclub
              INVALID KEY
                 DISPLAY "Erreur de réécriture."
               NOT INVALID KEY
                 DISPLAY "Le club a été modifiée avec succès.".

      ****************************************************************
      * SUPPRESSIONS
      ****************************************************************
      
      *SUPPRESSION D'UNE VILLE
       DELETE_VILLE.

       DISPLAY "Entrez l'ID de la ville à supprimer"
       PERFORM WITH TEST AFTER UNTIL fv_id IS NUMERIC
         ACCEPT fv_id
       END-PERFORm
       DELETE fville RECORD
          INVALID KEY
            DISPLAY "Il n'existe pas de ville portant ce numéro"
          NOT INVALID KEY
            DISPLAY "La ville a bien été supprimée.".

      *SUPPRESSION D'UNE SALLE
       DELETE_SALLE.

       DISPLAY "Entrez l'ID de la salle à supprimer"
       PERFORM WITH TEST AFTER UNTIL fs_id IS NUMERIC
         ACCEPT fs_id
       END-PERFORM
       DELETE fsalle RECORD
          INVALID KEY
            DISPLAY "Il n'existe pas de salle portant ce numéro"
          NOT INVALID KEY
            DISPLAY "La salle a bien été supprimée.".

      *SUPPRESSION D'UN CLUB
       DELETE_CLUB.

       DISPLAY "Entrez l'ID du club à supprimer"
       PERFORM WITH TEST AFTER UNTIL fc_id IS NUMERIC
         ACCEPT fc_id
       END-PERFORM
       DELETE fclub RECORD
          INVALID KEY
            DISPLAY "Il n'existe pas de club portant ce numéro"
          NOT INVALID KEY
            DISPLAY "Le club a bien été supprimée.".

      *SUPPRESSION D'UNE RESERVATION
       DELETE_RESA.

       DISPLAY "Entrez l'ID de la salle concernée par la réservation"
       ACCEPT fr_idSalle
       DISPLAY "Entrez l'année de la réservation (aaaa)"
       ACCEPT fr_dateDebut_a
       DISPLAY "Entrez le mois de la réservation (mm)"
       ACCEPT fr_dateDebut_m
       DISPLAY "Entrez le jour de la réservation (jj)"
       ACCEPT fr_dateDebut_j
       DISPLAY "Entrez l'heure de la réservation (hh)"
       ACCEPT fr_dateDebut_h
       READ fresa KEY IS fr_cles
          INVALID KEY
            DISPLAY "Il n'existe pas de réservation correspondante"
          NOT INVALID KEY
            IF WconnectedAsAdmin=1 THEN
              DELETE fclub RECORD
                 NOT INVALID KEY
                      DISPLAY "La réservation a bien été supprimée."
            ELSE
              IF fr_idClub=WnumClub THEN
                DELETE fclub RECORD
                   NOT INVALID KEY
                      DISPLAY "La réservation a bien été supprimée."
              ELSE
                 DISPLAY "Vous ne pouvez pas supprimer cette résa."
              END-IF
            END-IF.

      *SUPPRESSION D'UNE ASSOCIATION
       DELETE_ASSOC.

       DISPLAY "Entrez l'id de la salle:"
       PERFORM WITH TEST AFTER UNTIL fa_idSalle IS NUMERIC
         ACCEPT fa_idSalle
       END-PERFORM
       DISPLAY "Entrez le sport à supprimer:"
       PERFORM WITH TEST AFTER UNTIL fa_nomSport IS ALPHABETIC
         ACCEPT fa_nomSport
       END-PERFORM
       
       DELETE fassoc RECORD
          INVALID KEY
            DISPLAY "Association inexsistante"
          NOT INVALID KEY
            DISPLAY "L'association a bien été supprimée.".

      *Club exists ?
       CLUB_EXISTS.

       DISPLAY "Entrez le numéro de votre club :"
       ACCEPT WnumClub
       MOVE WnumClub TO fc_id
       READ fclub KEY IS fc_id
          INVALID KEY
            MOVE 0 TO WclubExists
          NOT INVALID KEY
            MOVE 1 TO WclubExists.
