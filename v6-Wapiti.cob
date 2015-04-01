       IDENTIFICATION DIVISION.
       PROGRAM-ID. projet.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.

       SELECT fville ASSIGN TO "ville.dat"
       ORGANIZATION INDEXED
       ACCESS MODE IS DYNAMIC
      *fville_stat permettra de récupérer le statut du fichier
       FILE STATUS IS fville_stat
       RECORD KEY IS fv_id
       ALTERNATE RECORD KEY IS fv_codePost WITH DUPLICATES.

       SELECT fsalle ASSIGN TO "salle.dat"
       ORGANIZATION INDEXED
       ACCESS MODE IS DYNAMIC
      *fsalle_stat permettra de récupérer le statut du fichier
       FILE STATUS IS fsalle_stat
       RECORD KEY IS fs_id
       ALTERNATE RECORD KEY IS fs_nom WITH DUPLICATES
       ALTERNATE RECORD KEY IS fs_dispo WITH DUPLICATES
       ALTERNATE RECORD KEY IS fs_ville WITH DUPLICATES.

       SELECT fclub ASSIGN TO "club.dat"
       ORGANIZATION INDEXED
       ACCESS MODE IS DYNAMIC
      *fclub_stat permettra de récupérer le statut du fichier
       FILE STATUS IS fclub_stat
       RECORD KEY IS fc_id
       ALTERNATE RECORD KEY IS fc_ville WITH DUPLICATES.

       SELECT fassoc ASSIGN TO "assocsport.dat"
       ORGANIZATION INDEXED
       ACCESS MODE IS DYNAMIC
      *fass_stat permettra de récupérer le statut du fichier
       FILE STATUS IS fass_stat
       RECORD KEY IS fa_cles
       ALTERNATE RECORD KEY IS fa_nomSport WITH DUPLICATES
       ALTERNATE RECORD KEY IS fa_idSalle WITH DUPLICATES.
	   
       SELECT fresa ASSIGN TO "reservation.dat"
       ORGANIZATION INDEXED
       ACCESS MODE IS DYNAMIC
      *fresa_stat permettra de récupérer le statut du fichier
       FILE STATUS IS fresa_stat
       RECORD KEY IS fr_cles
       ALTERNATE RECORD KEY IS fr_dateDebut WITH DUPLICATES
       ALTERNATE RECORD KEY IS fr_idClub WITH DUPLICATES
       ALTERNATE RECORD KEY IS fr_idSalle WITH DUPLICATES.

       SELECT fid ASSIGN TO "id.dat"
       ORGANIZATION SEQUENTIAL
       ACCESS MODE IS SEQUENTIAL
       FILE STATUS IS fid_stat.
	   
       DATA DIVISION.
       FILE SECTION.
       FD fville.
       01 Tville.
              02 fv_id PIC 9(15).
              02 fv_nom PIC A(30).
              02 fv_codePost PIC 9(5).
              02 fv_agglo PIC 9.

       FD fsalle.
       01 Tsalle.
              02 fs_id PIC 9(3).
              02 fs_nom PIC A(30).
              02 fs_dispo PIC 9.
              02 fs_ouv_h PIC 99.
              02 fs_ferm_h PIC 99.
              02 fs_addr PIC X(30).
              02 fs_ville PIC 9(15).
              02 fs_prix PIC 999V99.

       FD fclub.
       01 Tclub.
              02 fc_id PIC 9(4).
              02 fc_nom PIC A(30).
              02 fc_addr PIC X(30).
              02 fc_president PIC A(30).
              02 fc_ville PIC 9(15).
              02 fc_sport PIC A(30).

       FD fassoc.
       01 Tassoc.
              02 fa_cles.
                03 fa_nomSport PIC A(30).
	         03 fa_idSalle PIC 9(3).

       FD fresa.
       01 Tresa.
              02 fr_cles.
                 03 fr_idSalle PIC 9(3).
                 03 fr_dateDebut.
                    04 fr_dateDebut_a PIC 99(4).
                    04 fr_dateDebut_m PIC 99.
                    04 fr_dateDebut_j PIC 9(2).
                    04 fr_dateDebut_h PIC 99.
              02 fr_idClub PIC 9(4).     
              02 fr_dateFin.
                    03 fr_dateFin_a PIC 99(4).
                    03 fr_dateFin_m PIC 99.
                    03 fr_dateFin_j PIC 9(2).
                    03 fr_dateFin_h PIC 99.
              02 fr_sportPratique PIC A(30).
              02 fr_montant PIC 999V99.

       FD fid.
       01 Tid.
              02 fid_type PIC A(10).
              02 fid_idMax PIC 9(15).


       WORKING-STORAGE SECTION.
       77 fville_stat PIC 9(2).
       77 fsalle_stat PIC 9(2).
       77 fclub_stat PIC 9(2).
       77 fass_stat PIC 9(2).
       77 fresa_stat PIC 9(2).
       77 fid_stat PIC 9(2).
       77 Wchoix PIC 9.
       77 Woption PIC 9.
       77 Woption2 PIC 9.
       77 Wmdp PIC X(30).
       77 Wconnected PIC 9.
       77 WconnectedAsAdmin PIC 9.
       77 Wlogin PIC X(30).
       77 WendConnection PIC 9.
       77 Wchoix_jour PIC 9.
       77 WnumClub PIC 9(4).
       77 WclubExists PIC 9.
       77 Wcpt PIC 9(2).
       77 WidCourantSalle PIC 9(3).
       77 WidCourantVille PIC 9(15).
       77 WidCourantClub PIC 9(4).
       77 Wrecherche_jour PIC X(10).
       77 WfileStatus PIC 9.
       77 WendSearch PIC 9.
       77 Wtrouve PIC 9.
       77 Wnontrouve PIC 9.
       77 Wtemp PIC 9(15).
       77 WcrudChoix PIC 9.
       77 WcrudFin PIC 9.
       
      *RESA
       77 Wrep1 PIC 9.
       77 Wferm PIC 9.
       77 Wprixreduit PIC 9.   
       77 Wresafin PIC 9.
       77 Wresafin2 PIC 9.
       77 Wjours PIC A(20).
       77 Wresaimpossible PIC 9.
       77 WnotDispo PIC 9.
       77 Wpasdesalle PIC 9.
       77 Wresa_idClub PIC 9(4).
       77 Wresa_a PIC 99(4).
       77 Wresa_m PIC 99.
       77 Wresa_j PIC 9(2).
       77 Wresa_h_debut PIC 99.
       77 Wresa_h_fin PIC 99.
       77 Wresa_idSalle PIC 9(3).
       77 Wresa_sportPratique PIC A(30).
       77 Wresa_montant PIC 999V99.
       77 Wresa_clubAgglo PIC 9.
       
       
       
       PROCEDURE DIVISION.

      *PROGRAMME PRINCIPAL
      
      * Initialisation des fichiers

      * Fichier club
       OPEN I-O fclub
       IF fclub_stat=35 THEN
          OPEN OUTPUT fclub
          CLOSE fclub
          OPEN I-O fclub
       END-IF
       
      * Fichier ville
       OPEN I-O fville
       IF fville_stat=35 THEN
          OPEN OUTPUT fville
          CLOSE fville
          OPEN I-O fville
       END-IF

      * Fichier salle
       OPEN I-O fsalle
       IF fsalle_stat=35 THEN
          OPEN OUTPUT fsalle
          CLOSE fsalle
          OPEN I-O fsalle
       END-IF

      * Fichier assoc
       OPEN I-O fassoc
       IF fass_stat=35 THEN
          OPEN OUTPUT fassoc
          CLOSE fassoc
          OPEN I-O fassoc
       END-IF

      * Fichier resa
       OPEN I-O fresa
       IF fresa_stat=35 THEN
          OPEN OUTPUT fresa
          CLOSE fresa
          OPEN I-O fresa
       END-IF

      * Fichier id
       OPEN I-O fid
       IF fid_stat=35 THEN
          OPEN OUTPUT fid
          CLOSE fid
          OPEN I-O fid
       END-IF

      * Initialisation des ID si le fichier n'est pas initialisé
       PERFORM GET_FILE_STATUS
       PERFORM INIT_ID

       MOVE 1 TO Wlogin
       PERFORM WITH TEST AFTER UNTIL Wlogin=0
           DISPLAY 'Entrez votre login (admin/club, 0 pour quitter) :'
           ACCEPT Wlogin
           EVALUATE Wlogin
             WHEN 0 MOVE 0 TO Wlogin
             WHEN 'admin'
      * SI L'UTILISATEUR SE TROMPE INDEFINIMENT
      * AJOUTER UNE FONCTIONNALITE POUR SORTIR
               PERFORM WITH TEST AFTER UNTIL Wmdp="1234"
                 DISPLAY 'Entrez votre mdp'
                 ACCEPT Wmdp
               END-PERFORM
               MOVE 1 TO WconnectedAsAdmin
               PERFORM MENU_ADMIN
             WHEN 'club'
               PERFORM CLUB_EXISTS
                 IF WclubExists=1 THEN
                    PERFORM WITH TEST AFTER UNTIL Wmdp="1234"
                        DISPLAY 'Entrez votre mdp'
                        ACCEPT Wmdp
                    END-PERFORM
                    MOVE 0 TO WconnectedAsAdmin
                    PERFORM MENU_USR
                 ELSE
                    DISPLAY "Ce numéro de club n'existe pas."
                 END-IF
            END-EVALUATE
       END-PERFORM

       CLOSE fclub
       CLOSE fville
       CLOSE fsalle
       CLOSE fid
       CLOSE fresa
       CLOSE fassoc
       STOP RUN.

      *PROCEDURES
       SHUTDOWN.
       CLOSE fclub
       CLOSE fville
       CLOSE fsalle
       CLOSE fid
       CLOSE fresa
       CLOSE fassoc
       STOP RUN.
      *Appel du fichier des menus
       COPY menus.
       COPY crud.
       COPY gestionId.
       COPY resa.
      * COPY ph.
