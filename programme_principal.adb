with Arbre_Genealogique;
with Registre;
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Alea;

procedure menu1 is

    -- Pour avoir un entier aléatoire pour l'age
    package Alea_age is new Alea (1,80);
    use Alea_age;

    package Alea_nom is new Alea (0,5);
    use Alea_nom;

    package Alea_prenom is new Alea (0,8);
    use Alea_prenom;

    package Alea_ville is new Alea (0,7);
    use Alea_ville;

    -- Instancier le package registre

    package Registre_identite is new Registre(Integer);
    use Registre_identite;


    -- Instancier la procedure d'affichage
    procedure Afficher_identifiant(N: in Integer) is
    begin
        Put (N,1);
    end;

    -- Instancier le procédure d'affichage du registre
    procedure Afficher_registre is new Registre_identite.Afficher_registre(Afficher_identifiant);


    -- Instancier le paquetage Arbre_Généalogique pour avoir un Arbre d'identifiants
    -- d'entiers
    package AG is
            new Arbre_Genealogique (Integer , Afficher_identifiant);
    use AG;

    -- Instancier la procedure d'affichage
    procedure Afficher_entier(N: in Integer) is
    begin
        Put (N,1);
    end;

    registre : T_Registre;
    Abr : T_AG;
    racine, identifiant, identifiant_pere, identifiant_mere : Integer;
    choix, n, generation,reponse,nombre_aleatoire : Integer;
    info : Unbounded_String;

    -- La procédure de remplissage aléatoire du regitre
    procedure remplir_registre(Registre : in out T_Registre) is
        carte_identite : T_id;
        type nom is (AKBY,SAJID,CHRISTOPHER,DAVID,WILLIAM,ROBERT);	-- Type nom contient les noms pour remplir le registre
        type prenom is (AMINE,BADR,LEO,LUCAS,GEORGES,XAVIER,SARA,ELIZABETH,MARIE);	-- Type prénom contient les prénoms pour remplir le registre
        type ville is (TOULOUSE,CASABLANCA,WASHINGTON,PARIS,LONDON,RABAT,BERLIN,MADRID);
    begin
        Initialiser(Registre);

        for i in 1..10 loop
            Initialiser(carte_identite);
            Ajouter(carte_identite, "Age",Integer'image(i));

            Alea_nom.Get_Random_Number (nombre_aleatoire);
            info := To_Unbounded_String(nom'image(nom'val(nombre_aleatoire)));
            ajouter(carte_identite, "Nom",To_String(info));

            Alea_prenom.Get_Random_Number (nombre_aleatoire);
            info := To_Unbounded_String(prenom'image(prenom'val(nombre_aleatoire)));
            ajouter(carte_identite,"Prénom",To_String(info));

            Alea_ville.Get_Random_Number (nombre_aleatoire);
            info := To_Unbounded_String(ville'image(ville'val(nombre_aleatoire)));
            ajouter(carte_identite,"Ville",To_String(info));

            Ajouter(Registre,i,carte_identite);
        end loop;
    end remplir_registre;


    procedure Afficher_menu is
    begin
        Put_Line("Menu : ");
        put_Line("   1- Ajouter le père d'un individu. ");
        put_Line("   2- Ajouter la mère d'un individu. ");
        put_Line("   3- Obtenir le nombre d'ancêtres connus. ");
        put_Line("   4- Obtenir l'ensemble des ancêtres situés à une certaine génération d'un individu. ");
        put_Line("   5- Afficher l'arbre à partir d'un noeud. ");
        put_Line("   6- Supprimer un individu et ses ancêtres. ");
        put_Line("   7- Obtenir l'ensemble des individus qui n'ont qu'un parent. ");
        put_Line("   8- Obtenir l'ensemble des individus dont les parents sont connus. ");
        put_Line("   9- Obtenir l'ensemble des individus dont les parents sont inconnus. ");
        put_Line("   10- Identifier les ancêtres d'un individu sur n générations données pour un individu. ");
        Put_Line("   11- Afficher tous le registre. ");
        Put_Line("   12- Afficher les informations d'un individu. ");
        Put_Line("   13- Ajouter des informations au registre d'etat civil. ");
        put_Line("   0- Quitter. ");
    end Afficher_menu;

    procedure ajouter_identite(Registre : in out T_Registre; identifiant : in Integer) is
        carte_identite : T_id;
        info : Unbounded_String;
    begin

        Initialiser(carte_identite);

        Put(" Entrer l'age : ");
        Skip_Line;
        info := To_Unbounded_String(Get_Line);
        Ajouter(carte_identite, "Age",To_String(info));

        Put(" Entrer le nom : ");
        info := To_Unbounded_String(Get_Line);
        Ajouter(carte_identite, "Nom",To_String(info));

        Put(" Entrer le prénom : ");
        info := To_Unbounded_String(Get_Line);
        Ajouter(carte_identite, "Prénom",To_String(info));

        Put(" Entrer la ville : ");
        info := To_Unbounded_String(Get_Line);
        Ajouter(carte_identite, "Ville",To_String(info));

        Ajouter(Registre,identifiant,carte_identite);
    end;

    procedure executer_choix(choix : in out Integer) is
    begin
        case choix is
            when 1 => Put("Veuillez entrer l'identifiant d'un individu : ");
                begin
                    Get(identifiant);
                    Skip_Line;
                    Put("Veuillez entrer l'identifiant de son père : ");
                    Get(identifiant_pere);
                    Skip_Line;
                    if not Est_Present(Registre, identifiant_pere) then
                        Put_Line("Cet identifiant n'existe pas dans notre registre d'etat civil. Voulez-vous : ");
                        Put_Line("   1- Ajouter cette personne au registre. ");
                        Put_Line("   2- Choisir un autre identifiant pour le père. ");
                        Put_Line("   3- Retourner au menu principal. ");
                        put(" Veuillez entrer votre choix : ");
                        get(reponse);
                        Skip_Line;
                        if reponse = 1 then
                            ajouter_identite(Registre,identifiant_pere);
                        elsif reponse = 2 then
                            Get(identifiant_pere);
                        else
                            null;
                        end if;
                    else
                        null;
                    end if;
                    if Integer'Value(information_registre(registre,identifiant,"Age")) < Integer'Value(information_registre(registre,identifiant_pere,"Age")) then
                        Ajouter_pere(Abr,identifiant,identifiant_pere);
                        Put_Line("L'arbre devient : ");
                        Afficher(Abr, racine);
                    else
                        put("Impossible d'effectuer cette opération. L'âge de l'individu d'identifiant "); put(identifiant,1); put(" est plus grand que l'âge de son père d'identifiant "); Put(identifiant_pere,1);
                        New_Line;
                    end if;
                exception
                    when Pere_Present_Exception => Put("Le père de l'individu qui a comme identifiant : ");
                        Afficher_identifiant(identifiant);
                        Put(" est déjà  présent");
                    when Identifiant_Absent_Exception => Put("Le fils n'existe pas dans l'arbre. Veuillez entrer un nouveau identifiant du fils : ");
                        Get(identifiant);
                        Skip_Line;
                        Put("Veuillez entrer l'identifiant du père : ");
                        Get(identifiant_pere);
                        Skip_Line;
                        Ajouter_pere(Abr,identifiant,identifiant_pere);
                        Afficher(Abr, racine);

                    when Identifiant_Present_Exception => Put("L'identifiant est déjà present dans l'arbre. Veuillez entrer un nouveau identifiant du père : ");
                        Get(identifiant_pere);
                        Skip_Line;
                        Ajouter_pere(Abr,identifiant,identifiant_pere);
                        Afficher(Abr, racine);

                    when others => null;
                end;


            when 2 => Put("Veuillez entrer l'identifiant d'un individu : ");
                begin
                    Get(identifiant);
                    Skip_Line;
                    Put("Veuillez entrer l'identifiant de sa mère : ");
                    Get(identifiant_mere);
                    Skip_Line;
                    if not Est_Present(Registre, identifiant_mere) then
                        Put_Line("Cet identifiant n'existe pas dans notre registre d'etat civil. Voulez-vous : ");
                        Put_Line("    1- Ajouter cette personne au registre. ");
                        Put_Line("    2- Choisir un autre identifiant pour le mère. ");
                        Put_Line("    3- Retourner au menu. ");
                        put(" Veuillez entrer votre choix : ");
                        get(reponse);
                        Skip_Line;
                        if reponse = 1 then
                            ajouter_identite(Registre,identifiant_mere);
                        elsif reponse = 2 then
                            Get(identifiant_mere);
                        else
                            null;
                        end if;
                    else
                        null;
                    end if;
                    if Integer'Value(information_registre(registre,identifiant,"Age")) < Integer'Value(information_registre(registre,identifiant_mere,"Age")) then
                        Ajouter_mere(Abr,identifiant,identifiant_mere);
                        Put_Line("L'arbre devient : ");
                        Afficher(Abr, racine);
                    else
                        put("Impossible d'effectuer cette opération. L'âge du fils d'identifiant ");put(identifiant,1);put(" est plus grand que l'âge de la mère d'identifiant "); Put(identifiant_mere,1);
                        New_Line;
                    end if;
                exception
                    when Mere_Present_Exception => Put("Le mère de l'individu qui a comme identifiant : ");
                        Afficher_identifiant(identifiant);
                        Put(" est déjà présente");
                    when Identifiant_Absent_Exception => Put("Le fils n'existe pas dans l'arbre. Veuillez entrer un nouveau identifiant du fils : ");
                        Get(identifiant);
                        Skip_Line;
                        Put("Veuillez entrer l'identifiant de la mère : ");
                        Get(identifiant_mere);
                        Skip_Line;
                        Ajouter_mere(Abr,identifiant,identifiant_mere);
                        Afficher(Abr, racine);
                    when Identifiant_Present_Exception => Put("L'identifiant est déjà present dans l'arbre. Veuillez entrer un nouveau identifiant de la mère : ");
                        Get(identifiant_mere);
                        Skip_Line;
                        Ajouter_mere(Abr,identifiant,identifiant_mere);
                        Afficher(Abr, racine);
                end;


            when 3 => Put("Veuillez entrer l'identifiant du noeud : ");
                begin
                    Get(identifiant);
                    Skip_Line;
                    n := Nombre_ancetre(Abr,identifiant);
                    Put("Le nombre d'ancètres connu est : "); Put(n,1); Put_Line("");
                exception
                    when Identifiant_Absent_Exception => Put("L'identifiant n'existe pas. Veuillez entrer un nouveau identifiant : ");
                        Get(identifiant);
                        n := Nombre_ancetre(Abr,identifiant);
                        Put("Le nombre d'ancètres connu est : "); Put(n,1);
                end;

            when 4 => Put("Veuillez entrer l'identifiant du noeud : ");
                begin
                    Get(identifiant);
                    Skip_Line;
                    Put("Veuillez entrer le nombre de génération : ");
                    Get(Generation);
                    Skip_Line;
                    Put("Les ancetres à partir de l'individu d'identifiant "); Put(identifiant,1); Put(" jusqu'a la generation ");
                    Put(Generation,1); Put(" sont : ");
                    Ancetres(Abr,identifiant,Generation); Put_Line("");
                exception
                    when Generation_Introuvable_Exception => Put("La génération que vous avez entrer est introuvable. Veuillez entrer une nouvelle génération : ");
                        Get(Generation);
                        Skip_Line;
                        Ancetres(Abr,identifiant,generation);
                    when Identifiant_Absent_Exception => Put("L'identifiant du noeud n'existe pas. Veuillez entrer un nouveau identifiant : ");
                        Get(identifiant);
                        Skip_Line;
                        Put("Veuillez entrer le nombre de génération : ");
                        Get(Generation);
                        Skip_Line;
                        Put("Les ancetres à partir de l'individu d'identifiant "); Put(identifiant,1); Put(" jusqu'a la generation ");
                        Put(Generation,1); Put(" sont : ");
                        Ancetres(Abr,identifiant,Generation); Put_Line("");
                end;

            when 5 => Put("Veuillez entrer l'identifiant du noeud : ");
                begin
                    Get(identifiant);
                    Skip_Line;
                    Afficher(Abr, identifiant);
                exception
                    when Identifiant_Absent_Exception => Put("L'identifiant du noeud n'existe pas. Veuillez entrer un nouveau identifiant : ");
                        Get(identifiant);
                        Skip_Line;
                        Afficher(Abr, racine);
                end;

            when 6 => Put("Veuillez entrer l'identifiant du noeud : ");
                begin
                    Get(identifiant);
                    Skip_Line;
                    Supprimer(Abr,identifiant);
                    Put_Line("L'arbre devient : ");
                    Afficher(Abr, racine);
                exception
                    when Identifiant_Absent_Exception => Put("L'identifiant du noeud n'existe pas. Veuillez entrer un nouveau identifiant : ");
                        Get(identifiant);
                        Skip_Line;
                        Supprimer(Abr,identifiant);
                        Afficher(Abr, racine);
                end;

            when 7 => Put("Les identifiants des individus qui n'ont qu'un parent connu sonts : ");
                un_parent_connu(Abr); Put_Line("");

            when 8 => Put("Les identifiants des individus dont les parents sonts connues sont : ");
                deux_parents_connus(Abr); Put_Line("");

            when 9 => Put("Les identifiants des individus dont les parents sonts inconnues sont : ");
                aucun_parent_connu(Abr); Put_Line("");

            when 10 => Put("Veuillez entrer l'identifiant d'un individu : ");
                begin
                    Get(identifiant);
                    Skip_Line;
                    Put("Veuillez entrer le nombre de génération choisi : ");
                    Get(generation);
                    Skip_Line;
                    Put("Les identifiants des ancêtres de generation "); Put(generation,1); Put(" de l'individu d'identifiant ");Put(identifiant,1);Put(" sont : ");
                    Ancetres_generation_n(Abr,identifiant,generation); Put_Line("");
                exception
                    when Identifiant_Absent_Exception => Put("L'identifiant de cet individu n'existe pas dans l'arbre. Veuillez saisir un nouveau identifiant : ");
                        Get(identifiant);
                        Skip_Line;
                        Ancetres_generation_n(Abr,identifiant,n);
                    when Generation_Introuvable_Exception => Put("La génération que vous avez saisi est introuvable. Veuillez saisir une nouvelle génération : ");
                        Get(Generation);
                        Skip_Line;
                        Put("Les identifiants des ancêtres de la generation "); Put(n,1); Put("de l'individu d'identifiant "); Put(identifiant,1);Put("sont : ");
                        Ancetres_generation_n(Abr,identifiant,generation); Put_Line("");
                end;

            when 11 => Afficher_registre(registre);

            when 12 => Put(" Veuillez entrer l'identifiant de l'individu : ");
                get(identifiant);
                Put_Line(" Les informations de votre individu sont : ");
                put("Nom : ");
                Put_Line(information_registre(registre,identifiant,"Nom"));
                put("Prénom : ");
                Put_Line(information_registre(registre,identifiant,"Prénom"));
                put("Age : ");
                Put_Line(information_registre(registre,identifiant,"Age"));

            when 13 => Put(" Veuillez entrer l'identifiant de l'individu : ");
                begin
                    get(identifiant);
                    ajouter_identite(Registre,identifiant);
                exception
                    when Identifiant_Present_Registre_Exception => Put("Cet individu existe déjà dans le registre.");
                        Put("Veuillez entrer un nouvel identifiant : ");
                        get(identifiant);
                        ajouter_identite(Registre,identifiant);
                end;

            when 0  => Null;

            when others =>  put("Choix incorrect! Veuillez rechoisir : ");
                get(choix);
                Skip_Line;
                executer_choix(choix);
        end case;
    end executer_choix;


begin
    -- Initialiser un registre plein
    remplir_registre(Registre);

    Put_line("Bonjour!");
    Skip_Line;
    Put_Line("Voulez-vous : ");
    Put_Line(" 1- Initialiser un arbre vide. ");
    Put_Line(" 2- Initialiser un arbre plein. ");
    Put("Veuillez entrer votre choix : ");
    Get(choix);
    Skip_Line;
    if choix = 1 then
        Put("Veuillez entrer l'identifiant de la racine de l'arbre : ");
        Get(racine);
        Skip_Line;
        Initialiser(Abr,racine);
    elsif choix = 2 then
        racine := 1;
        Initialiser(Abr,1);
        Ajouter_pere(Abr,1,2);
        Ajouter_mere(Abr,1,3);
        Ajouter_pere(Abr,2,4);
        Ajouter_mere(Abr,3,5);
        Ajouter_pere(Abr,3,6);
        Ajouter_mere(Abr,4,7);
        Ajouter_pere(Abr,5,8);
    else
        null;
    end if;
    loop
        Afficher_menu;
        Skip_Line;
        Put("Veuillez entrer votre choix :  ");
        Get(choix);
        Skip_Line;
        executer_choix(choix);
        Skip_Line;
        exit when choix = 0;
    end loop;

end menu1;
